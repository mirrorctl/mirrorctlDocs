---
title: Understanding Snapshots
weight: 2
---

Snapshots are one of mirrorctl's key features. They allow you to maintain multiple versions of your repository, enabling rollback, reproducible builds, and safe testing of updates before deploying to production.

## What Are Snapshots?

A snapshot is a point-in-time copy of your mirror. mirrorctl creates snapshots using hardlinks, which means:

- Snapshots take minimal additional disk space (only new/changed files consume extra space)
- Snapshots are created instantly, even for large repositories
- Each snapshot is a complete, consistent view of the repository at a specific time

Think of snapshots like Git commits for your mirror - each one captures the exact state at a moment in time.

## Why Use Snapshots?

Snapshots enable several important capabilities:

1. **Rollback**: If an update breaks something, quickly revert to a previous working version
2. **Testing**: Test new mirror content in staging before promoting to production
3. **Reproducible builds**: Pin build environments to specific snapshot versions
4. **Zero-downtime updates**: Switch between versions atomically via symlink changes
5. **Audit trail**: Maintain a history of repository changes over time

## Enabling Automatic Snapshots

Update your `/etc/mirrorctl/mirror.toml` configuration to enable automatic snapshot creation after each sync:

```toml
# Base directory for all mirrored repositories
dir = "/var/www/apt/"

# Snapshot configuration
[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"  # Timestamp format

[snapshot.prune]
keep_last = 5  # Keep the 5 most recent snapshots

# Mirror configuration
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
publish_to_staging = false  # We'll enable this in the next section
```

The `default_name_format` uses Go's time format. The example format creates names like:
- `2025-10-14T09-30-45Z`
- `2025-10-15T14-22-10Z`

{{% details title="Understanding the snapshot path" closed="true" %}}

The `snapshot.path` setting determines where snapshots are stored. The default is `/var/lib/mirrorctl/snapshots`.

For our `ubuntu-noble` mirror, snapshots will be stored at:
```
/var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T09-30-45Z/
```

Each snapshot is a complete mirror structure with `dists/` and `pool/` directories.

{{% /details %}}

## Create Your First Snapshot

Create the snapshot directory:

```bash
sudo mkdir -p /var/lib/mirrorctl/snapshots
```

Now run a sync. mirrorctl will automatically create a snapshot after syncing:

```bash
sudo mirrorctl sync ubuntu-noble
```

You'll see additional output about snapshot creation:

```
INFO  Starting sync for mirror: ubuntu-noble
INFO  Downloading Release file
...
INFO  Sync completed successfully for ubuntu-noble
INFO  Creating snapshot: 2025-10-14T09-30-45Z
INFO  Snapshot created successfully
```

## List Your Snapshots

View all snapshots for a mirror:

```bash
mirrorctl snapshot list ubuntu-noble
```

Output:

```
MIRROR         SNAPSHOT NAME           CREATED              SIZE
ubuntu-noble   2025-10-14T09-30-45Z   2025-10-14 09:30:45  45.3 GB
```

{{% details title="Where are snapshots stored?" closed="true" %}}

Check the snapshot directory structure:

```bash
ls -l /var/lib/mirrorctl/snapshots/ubuntu-noble/
```

You'll see:

```
drwxr-xr-x. 2025-10-14T09-30-45Z
```

Each snapshot directory contains a complete mirror:

```bash
tree -L 2 /var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T09-30-45Z/
```

```
/var/lib/mirrorctl/snapshots/ubuntu-noble/2025-10-14T09-30-45Z/
├── dists
│   └── noble
└── pool
    └── main
```

{{% /details %}}

## Create Additional Snapshots

Run another sync to create a second snapshot:

```bash
sudo mirrorctl sync ubuntu-noble
```

Since the mirror hasn't changed much, the sync will be quick:

```
INFO  Starting sync for mirror: ubuntu-noble
INFO  Checking for updates
INFO  42 new packages available
INFO  Downloading 42 packages
INFO  Sync completed successfully for ubuntu-noble
INFO  Creating snapshot: 2025-10-15T14-22-10Z
INFO  Snapshot created successfully
```

List snapshots again:

```bash
mirrorctl snapshot list ubuntu-noble
```

```
MIRROR         SNAPSHOT NAME           CREATED              SIZE
ubuntu-noble   2025-10-15T14-22-10Z   2025-10-15 14:22:10  45.4 GB
ubuntu-noble   2025-10-14T09-30-45Z   2025-10-14 09:30:45  45.3 GB
```

Notice the second snapshot only added 100 MB despite being a "complete" copy - this is the efficiency of hardlinks!

## Manual Snapshot Creation

You can also create snapshots manually without syncing:

```bash
mirrorctl snapshot create ubuntu-noble
```

This creates a snapshot of the current mirror state with an auto-generated name.

Or specify a custom name:

```bash
mirrorctl snapshot create ubuntu-noble "before-upgrade"
```

Custom names are useful for marking significant events:
- `"before-upgrade"`
- `"known-good-config"`
- `"2025-q1-baseline"`

## Snapshot Pruning

Over time, you'll accumulate many snapshots. The `keep_last` setting in your config automatically prunes old snapshots when creating new ones.

With `keep_last = 5`, only the 5 most recent snapshots are retained. When a 6th snapshot is created, the oldest is automatically deleted.

You can also manually prune snapshots:

```bash
mirrorctl snapshot prune ubuntu-noble
```

This applies the retention policy configured in your TOML file.

{{% details title="Advanced pruning configuration" closed="true" %}}

You can use time-based retention instead of count-based:

```toml
[snapshot.prune]
keep_within = "30d"  # Keep snapshots from the last 30 days
```

Or combine both:

```toml
[snapshot.prune]
keep_last = 5         # Keep at least 5 recent snapshots
keep_within = "30d"   # Also keep anything within 30 days
```

This ensures you keep at least 5 snapshots, but also preserve all snapshots from the last 30 days (even if that's more than 5).

{{% /details %}}

## Deleting Specific Snapshots

To delete a specific snapshot:

```bash
mirrorctl snapshot delete ubuntu-noble "2025-10-14T09-30-45Z"
```

Use this carefully - deleted snapshots cannot be recovered!

## Snapshots vs. Working Mirror

It's important to understand the relationship:

- **Working mirror** (`/var/www/apt/ubuntu-noble/`): The actively synced repository
- **Snapshots** (`/var/lib/mirrorctl/snapshots/ubuntu-noble/*/`): Frozen point-in-time copies

When you run `mirrorctl sync`, it updates the working mirror. If snapshots are enabled, it then creates a snapshot of that updated state.

The working mirror is what gets updated. Snapshots are created from it and never change.

## What's Next?

Now that you understand snapshots, learn how to use them in a [Staging and Production Workflow]({{< relref "staging-production" >}}) for safe, tested mirror updates.
