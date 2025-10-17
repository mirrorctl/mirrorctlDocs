---
title: Your First Mirror
weight: 1
---

In this section, you'll create your first repository mirror using `mirrorctl`. We'll start with a minimal configuration that mirrors a single Ubuntu suite and architecture.

## Choose Your Mirror Directory

First, decide where to store your mirrored repositories. This directory will contain all downloaded packages and metadata. Common choices:

- `/var/www/apt/` - Standard location for web-served content
- `/srv/apt` - Alternative system location
- `~/mirrors` - User directory (for testing or non-root usage)

For this tutorial, we'll use `/var/www/apt/`. Create the directory:

```bash
sudo mkdir -p /var/www/apt/
```

If you don't have sudo access or prefer a user directory:

```bash
mkdir -p ~/mirrors
```

## Create Your Configuration File

Create a configuration file at `/etc/mirrorctl/mirror.toml` (or `~/mirror.toml` for non-root usage):

```bash
sudo mkdir -p /etc/mirrorctl
sudo vim /etc/mirrorctl/mirror.toml
```

Or for user directory:

```bash
vim ~/mirror.toml
```

Add the following minimal configuration:

```toml
# Base directory for all mirrored repositories
dir = "/var/www/apt/"

# Define your first mirror
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
```

Let's break down what each setting does:

- **`dir`**: The base directory where all mirrors will be stored
- **`[mirrors.ubuntu-noble]`**: Creates a mirror with ID `ubuntu-noble` (you can choose any ID)
- **`url`**: The upstream repository URL to mirror from
- **`suites`**: Which distribution releases to mirror (e.g., "noble" for Ubuntu 24.04)
- **`sections`**: Which repository sections to include (e.g., "main", "universe", "restricted")
- **`architectures`**: Which CPU architectures to mirror (e.g., "amd64", "arm64")

{{% details title="Using a different directory?" closed="true" %}}

If you chose a different directory like `~/mirrors`, update the `dir` setting:

```toml
dir = "/home/yourusername/mirrors"
# or
dir = "~/mirrors"  # This works too
```

And adjust the commands accordingly:
```bash
vim ~/mirror.toml
mirrorctl sync --config ~/mirror.toml
```

{{% /details %}}

## Understand Disk Space Requirements

Before syncing, it's helpful to know how much space you'll need. Use the `--dry-run` flag to estimate:

```bash
sudo mirrorctl sync --dry-run
```

Or with custom config:

```bash
mirrorctl sync --config ~/mirror.toml --dry-run
```

You'll see output like:

```
INFO  Performing dry run - no files will be downloaded
INFO  Syncing mirror: ubuntu-noble
INFO  Estimated disk space required: 45.2 GB
INFO  Dry run complete
```

The Ubuntu 24.04 (noble) main section for amd64 is approximately 40-50 GB.

## Run Your First Sync

Now you're ready to sync! Run:

```bash
sudo mirrorctl sync
```

Or with custom config:

```bash
mirrorctl sync --config ~/mirror.toml
```

You'll see output showing the sync progress:

```
INFO  Starting sync for mirror: ubuntu-noble
INFO  Downloading Release file
INFO  Verifying Release file integrity
INFO  Downloading Packages files
INFO  Downloading 12,847 packages
INFO  Progress: 1250/12847 packages (9.7%) - 4.2 GB downloaded
...
INFO  Sync completed successfully for ubuntu-noble
INFO  Total downloaded: 45.3 GB
INFO  Duration: 23m 15s
```

The first sync will take time depending on your network speed. Subsequent syncs will be much faster as they only download changes.

## Verify Your Mirror

Once the sync completes, verify the mirror was created:

```bash
ls -l /var/www/apt/
```

You should see:

```
drwxr-xr-x. ubuntu-noble
```

Look inside the mirror:

```bash
ls -l /var/www/apt/ubuntu-noble/
```

You'll see the standard Debian repository structure:

```
drwxr-xr-x. dists
drwxr-xr-x. pool
lrwxrwxrwx. current -> ubuntu-noble
```

The `dists/` directory contains repository metadata, and `pool/` contains the actual package files.

## Understanding the Directory Structure

Let's explore what was created:

```bash
tree -L 2 /var/www/apt/ubuntu-noble/
```

```
/var/www/apt/ubuntu-noble/
├── dists
│   └── noble
├── pool
│   └── main
└── current -> ubuntu-noble
```

- **`dists/noble/`**: Contains the Release file and Packages indices for the noble suite
- **`pool/main/`**: Contains the actual `.deb` package files, organized by source package name
- **`current`**: A symlink pointing to the active mirror (used for atomic updates)

## Test Your Mirror

If you're running a web server, you can test your mirror by configuring a system to use it. First, serve the directory with your web server, or use Python for testing:

```bash
cd /var/www/apt/
python3 -m http.server 8080
```

Then on the same machine (or another), test fetching the Release file:

```bash
curl http://localhost:8080/ubuntu-noble/dists/noble/Release
```

You should see the Release file content.

## Common Issues

### Permission Denied

If you see permission errors:

```bash
sudo chown -R $(whoami):$(whoami) /var/www/apt/
```

Or run mirrorctl with sudo:

```bash
sudo mirrorctl sync
```

### Insufficient Disk Space

If the sync fails due to disk space:

1. Check available space: `df -h /var/www/apt/`
2. Consider mirroring fewer packages (covered in [Expand Your Mirror]({{< relref "expand-mirror" >}}))
3. Use a larger partition or external storage

### Network Issues

If the sync fails due to network issues, simply run the sync again. mirrorctl will resume where it left off:

```bash
sudo mirrorctl sync
```

## What's Next?

Congratulations! You've created your first mirror. Next, learn about [Understanding Snapshots]({{< relref "snapshots" >}}) to enable versioned backups and safe updates.
