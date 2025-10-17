---
title: Staging and Production Workflow
weight: 3
---

A staging-to-production workflow allows you to test mirror updates in a safe environment before exposing them to production systems. This prevents broken packages or corrupted metadata from affecting critical infrastructure.

## The Workflow Pattern

The recommended workflow is:

1. **Sync** - Download new repository content
2. **Snapshot** - Create a point-in-time snapshot
3. **Stage** - Publish the snapshot to a staging environment
4. **Test** - Verify the staged content works correctly
5. **Promote** - Atomically switch production to the tested snapshot

This ensures production always points to verified, working content.

## Understanding Staging and Production

mirrorctl uses symlinks to implement staging and production environments:

- **Staging symlink** (`staging/` or custom path): Points to a snapshot being tested
- **Production symlink** (`current/` or custom path): Points to the active production snapshot

Both are symlinks to specific snapshots. Updates are atomic - just changing what the symlink points to.

## Configuring Staging and Production

Update your `/etc/mirrorctl/mirror.toml` to enable staging:

```toml
# Base directory for all mirrored repositories
dir = "/var/www/apt/"

# Snapshot configuration
[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 5

# Mirror configuration
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
publish_to_staging = true  # Automatically publish new snapshots to staging
```

Setting `publish_to_staging = true` means each sync will automatically:
1. Sync the repository
2. Create a snapshot
3. Publish that snapshot to staging

Production is not affected until you explicitly promote.

## Run a Sync with Auto-Staging

Run a sync:

```bash
sudo mirrorctl sync ubuntu-noble
```

You'll see:

```
INFO  Starting sync for mirror: ubuntu-noble
INFO  Downloading Release file
...
INFO  Sync completed successfully for ubuntu-noble
INFO  Creating snapshot: 2025-10-14T15-45-30Z
INFO  Snapshot created successfully
INFO  Publishing snapshot to staging
INFO  Staging updated: ubuntu-noble -> 2025-10-14T15-45-30Z
```

## Verify the Staging Environment

Check what's in staging:

```bash
ls -la /var/www/apt/ubuntu-noble/
```

You should see a `staging` symlink:

```
lrwxrwxrwx. staging -> /var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T15-45-30Z
```

The staging environment is now a complete, accessible repository mirror pointing to your snapshot.

## Test the Staging Repository

Before promoting to production, test the staged content. Here are common testing approaches:

### 1. Manual Package Installation Test

Configure a test system to use the staging repository:

```bash
# On a test Ubuntu system
echo "deb http://your-mirror-server/ubuntu-noble/staging noble main" | \
  sudo tee /etc/apt/sources.list.d/staging-mirror.list

sudo apt update
sudo apt install some-package  # Test installing packages
```

### 2. Metadata Validation

Check that repository metadata is valid:

```bash
# Fetch and verify Release file
curl http://your-mirror-server/ubuntu-noble/staging/dists/noble/Release

# Verify package indices are accessible
curl http://your-mirror-server/ubuntu-noble/staging/dists/noble/main/binary-amd64/Packages.gz | gunzip | head
```

### 3. Automated Testing

For production environments, consider automated testing:

```bash
# Example: Check Release file signature
gpg --verify /var/www/apt/ubuntu-noble/staging/dists/noble/Release.gpg \
             /var/www/apt/ubuntu-noble/staging/dists/noble/Release

# Example: Verify package counts match expectations
expected_packages=12850
actual_packages=$(curl -s http://your-mirror-server/ubuntu-noble/staging/dists/noble/main/binary-amd64/Packages.gz | gunzip | grep -c "^Package:")

if [ "$actual_packages" -lt "$expected_packages" ]; then
  echo "ERROR: Package count too low!"
  exit 1
fi
```

## Promote Staging to Production

Once you've verified staging is working correctly, promote it to production:

```bash
mirrorctl snapshot promote ubuntu-noble
```

This atomically updates the production symlink to point to the same snapshot as staging:

```
INFO  Promoting staging snapshot to production for ubuntu-noble
INFO  Production updated: ubuntu-noble -> 2025-10-14T15-45-30Z
```

Check the production symlink:

```bash
ls -la /var/www/apt/ubuntu-noble/
```

Now you'll see both staging and production (current):

```
lrwxrwxrwx. staging -> /var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T15-45-30Z
lrwxrwxrwx. current -> /var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T15-45-30Z
```

Both point to the same tested snapshot.

## Configure Production Systems

Configure your production APT clients to use the production path:

```bash
# On production systems
echo "deb http://your-mirror-server/ubuntu-noble/current noble main" | \
  sudo tee /etc/apt/sources.list.d/internal-mirror.list

sudo apt update
```

Using `/current` ensures systems always use the promoted, tested version.

## The Complete Workflow in Practice

Here's a complete example of the staging workflow:

```bash
# 1. Sync and auto-publish to staging
sudo mirrorctl sync ubuntu-noble

# 2. Review what was synced
mirrorctl snapshot list ubuntu-noble

# 3. Test staging (manual or automated)
# ... perform your testing ...

# 4. If tests pass, promote to production
mirrorctl snapshot promote ubuntu-noble

# 5. Verify production systems can access it
curl http://your-mirror-server/ubuntu-noble/current/dists/noble/Release
```

## Manual Staging (Without Auto-Publish)

If you prefer manual control, set `publish_to_staging = false` and manually stage snapshots:

```bash
# Sync and create snapshot (doesn't auto-stage)
sudo mirrorctl sync ubuntu-noble

# List snapshots to find the one you want to stage
mirrorctl snapshot list ubuntu-noble

# Manually stage a specific snapshot
mirrorctl snapshot stage ubuntu-noble "2025-10-14T15-45-30Z"

# Test, then promote
mirrorctl snapshot promote ubuntu-noble
```

This gives you more control over what enters staging.

## Direct Production Publishing (Skip Staging)

In some cases, you may want to publish directly to production:

```bash
# Publish a specific snapshot directly to production
mirrorctl snapshot publish ubuntu-noble "2025-10-14T15-45-30Z"
```

Use this carefully - it bypasses testing and immediately affects production systems.

## Rollback Strategy

If a promoted snapshot causes issues, roll back by publishing a previous snapshot:

```bash
# List snapshots to find a known-good version
mirrorctl snapshot list ubuntu-noble

# Publish the previous snapshot directly to production
mirrorctl snapshot publish ubuntu-noble "2025-10-13T09-30-15Z"
```

This is why keeping multiple snapshots (via `keep_last`) is important!

## Zero-Downtime Updates

Because promotion is just a symlink change, updates are atomic and instantaneous:

1. Old production snapshot remains accessible until the symlink changes
2. Symlink update is atomic (one filesystem operation)
3. New production snapshot is immediately active
4. No time window where the repository is unavailable or inconsistent

Systems using the repository via the `/current` symlink experience zero downtime.

## Best Practices

1. **Always test staging** before promoting to production
2. **Keep at least 3-5 snapshots** for rollback capability
3. **Document your testing criteria** - what must pass before promotion?
4. **Monitor production** after promotion to catch issues quickly
5. **Automate testing** where possible to reduce human error

## What's Next?

Now that you have a robust staging workflow, learn how to [Expand Your Mirror]({{< relref "expand-mirror" >}}) to add more architectures, suites, and sections.
