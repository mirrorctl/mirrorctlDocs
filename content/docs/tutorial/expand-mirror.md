---
title: Expanding Your Mirror
weight: 4
---

So far, you've created a minimal mirror with a single architecture, suite, and section. In practice, you'll often need to support multiple architectures, distribution releases, and repository sections. This section shows how to expand your mirror configuration.

## Understanding the Dimensions

Repository mirrors can be expanded across three dimensions:

1. **Architectures**: CPU architectures (amd64, arm64, i386, etc.)
2. **Suites**: Distribution releases (noble, jammy, focal for Ubuntu; bookworm, trixie, sid for Debian)
3. **Sections**: Repository components (main, universe, restricted, multiverse for Ubuntu; main, contrib, non-free for Debian)

Each combination you add increases the mirror size and sync time.

## Adding Multiple Architectures

Many environments support multiple CPU architectures. Add them to the `architectures` array:

```toml
dir = "/var/www/apt/"

[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 5

[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64", "arm64"]  # Added arm64
publish_to_staging = true
```

This mirrors both x86-64 and ARM64 packages, supporting servers, desktops, and ARM-based systems.

Common architecture combinations:
- **`["amd64"]`**: x86-64 only (most common)
- **`["amd64", "arm64"]`**: Modern servers and ARM systems
- **`["amd64", "i386"]`**: Include legacy 32-bit support
- **`["amd64", "arm64", "armhf"]`**: Full ARM compatibility (32 and 64-bit)

Sync to download the arm64 packages:

```bash
sudo mirrorctl sync ubuntu-noble
```

The new architecture will be added:

```
INFO  Syncing mirror: ubuntu-noble
INFO  Downloading packages for arm64
INFO  Downloaded 8,450 new packages for arm64
INFO  Sync completed successfully
```

## Adding Multiple Suites

Organizations often need to support multiple OS versions. Add multiple releases to the `suites` array:

```toml
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble", "jammy"]  # Ubuntu 24.04 and 22.04
sections = ["main"]
architectures = ["amd64", "arm64"]
publish_to_staging = true
```

This mirrors both Ubuntu 24.04 LTS (Noble) and 22.04 LTS (Jammy).

Common suite combinations:
- **Ubuntu LTS only**: `["noble", "jammy", "focal"]` (24.04, 22.04, 20.04)
- **Latest + LTS**: `["plucky", "noble"]` (current + latest LTS)
- **Debian stable + testing**: `["bookworm", "trixie"]`

After adding suites, sync to download them:

```bash
sudo mirrorctl sync ubuntu-noble
```

The sync will download packages for all suite/architecture/section combinations.

{{% details title="Disk space considerations" closed="true" %}}

Each suite roughly doubles the mirror size:
- 1 suite (noble) × 1 section (main) × 1 arch (amd64): ~45 GB
- 2 suites (noble, jammy) × 1 section × 1 arch: ~90 GB
- 3 suites × 1 section × 1 arch: ~135 GB

Check space requirements before syncing:

```bash
sudo mirrorctl sync --dry-run
```

{{% /details %}}

## Adding Multiple Sections

Sections contain different categories of packages. Ubuntu uses:
- **main**: Officially supported open source software
- **universe**: Community-maintained open source software
- **restricted**: Proprietary drivers and firmware
- **multiverse**: Software with licensing restrictions

Add sections to mirror more packages:

```toml
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble", "jammy"]
sections = ["main", "universe"]  # Added universe
architectures = ["amd64", "arm64"]
publish_to_staging = true
```

This dramatically expands available packages:
- **main only**: ~13,000 packages
- **main + universe**: ~60,000+ packages

{{% callout type="warning" %}}
Adding `universe` significantly increases mirror size (often 3-4x). The example above would grow from ~90 GB to ~300+ GB.
{{% /callout %}}

For Debian, sections are:
- **main**: Free software that meets Debian Free Software Guidelines
- **contrib**: Free software that depends on non-free software
- **non-free**: Software that doesn't meet DFSG
- **non-free-firmware**: Non-free firmware (Debian 12+)

```toml
[mirrors.debian-bookworm]
url = "https://deb.debian.org/debian/"
suites = ["bookworm"]
sections = ["main", "contrib", "non-free", "non-free-firmware"]
architectures = ["amd64"]
```

## Including Source Packages

Source packages allow building software from source and auditing code:

```toml
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
mirror_source = true  # Include source packages
publish_to_staging = true
```

Source packages add significant size (often 30-50% more) but are valuable for:
- Building custom packages
- Security audits
- Compliance requirements
- Offline development environments

## Creating Multiple Mirror Configurations

You can mirror multiple repositories by defining multiple `[mirrors.*]` sections:

```toml
dir = "/var/www/apt/"

[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 5

# Ubuntu mirror
[mirrors.ubuntu]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble", "jammy"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
publish_to_staging = true

# Ubuntu security updates (separate repository)
[mirrors.ubuntu-security]
url = "https://security.ubuntu.com/ubuntu/"
suites = ["noble-security", "jammy-security"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
publish_to_staging = true

# Debian mirror
[mirrors.debian]
url = "https://deb.debian.org/debian/"
suites = ["bookworm", "trixie"]
sections = ["main", "contrib", "non-free"]
architectures = ["amd64"]
publish_to_staging = true
```

Sync all mirrors:

```bash
sudo mirrorctl sync
```

Or sync specific mirrors:

```bash
sudo mirrorctl sync ubuntu ubuntu-security
```

## Partial Mirroring with Filters

For large repositories, you might not want everything. Use filters to reduce mirror size:

```toml
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main", "universe"]
architectures = ["amd64"]

# Filter configuration
[mirrors.ubuntu-noble.filters]
keep_versions = 2  # Only keep the 2 most recent versions of each package
exclude_patterns = [
  ".*-dbg$",      # Exclude debug symbol packages
  ".*-doc$",      # Exclude documentation packages
  "linux-image-.*-generic-hwe.*"  # Exclude HWE kernels
]
```

Filters help manage disk space when mirroring large repositories.

{{% details title="Understanding keep_versions" closed="true" %}}

Debian repositories keep multiple versions of packages. For example:
- `nginx_1.18.0-1_amd64.deb`
- `nginx_1.20.1-1_amd64.deb`
- `nginx_1.24.0-2_amd64.deb`

Setting `keep_versions = 2` keeps only the 2 most recent:
- `nginx_1.24.0-2_amd64.deb`
- `nginx_1.20.1-1_amd64.deb`

This is useful for development mirrors where you don't need full history.

For production, use `keep_versions = 0` (keep all versions) to ensure maximum compatibility.

{{% /details %}}

## Example: Production-Ready Configuration

Here's a realistic production configuration supporting multiple environments:

```toml
dir = "/var/www/apt/"

[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 7
keep_within = "30d"

# Primary Ubuntu mirror - main and universe
[mirrors.ubuntu]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble", "jammy", "focal"]  # Support 3 LTS versions
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
publish_to_staging = true

# Ubuntu security updates - critical for production
[mirrors.ubuntu-security]
url = "https://security.ubuntu.com/ubuntu/"
suites = ["noble-security", "jammy-security", "focal-security"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
publish_to_staging = true

# Ubuntu updates repository
[mirrors.ubuntu-updates]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble-updates", "jammy-updates", "focal-updates"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
publish_to_staging = true
```

Sync all:

```bash
sudo mirrorctl sync
```

## Monitoring Disk Usage

As your mirror expands, monitor disk usage:

```bash
# Check total mirror size
du -sh /var/www/apt/*

# Check snapshot sizes
du -sh /var/lib/mirrorctl/snapshots/*/*
```

Use `--dry-run` before adding new suites or sections:

```bash
sudo mirrorctl sync --dry-run
```

## What's Next?

Now that your mirror is expanded, learn about [Security Best Practices]({{< relref "security" >}}) to ensure your mirror is verified and trustworthy.
