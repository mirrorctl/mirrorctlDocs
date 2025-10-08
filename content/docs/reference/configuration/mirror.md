---
title: mirror
---

### Mirror Configuration

Each mirror is configured under `[mirrors.<mirror-id>]`:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `url` | string | Yes | - | Repository URL (http or https) |
| `suites` | array | Yes | - | Distribution suites to mirror |
| `sections` | array | Yes* | - | Repository sections (required for non-flat repos) |
| `architectures` | array | Yes* | - | Architectures to mirror (required for non-flat repos) |
| `mirror_source` | boolean | No | `false` | Include source packages |
| `pgp_key_path` | string | No | - | Path to PGP key for signature verification |
| `no_pgp_check` | boolean | No | `false` | Disable PGP signature verification |
| `publish_to_staging` | boolean | No | `false` | Automatically publish syncs to staging |

\* Not required for flat repositories

#### Per-Mirror Filters

Configure package filtering under `[mirrors.<mirror-id>.filters]`:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `keep_versions` | integer | No | `0` | Number of package versions to keep (0 = all) |
| `exclude_patterns` | array | No | `[]` | Regex patterns for excluding packages |

#### Per-Mirror TLS Configuration

Override global TLS settings under `[mirrors.<mirror-id>.tls]` using the same settings as the global `[tls]` section.

#### Per-Mirror Snapshot Configuration

Override global snapshot settings under `[mirrors.<mirror-id>.snapshot]` and `[mirrors.<mirror-id>.snapshot.prune]` using the same settings as the global snapshot sections.


## Flat Repository Example

For flat repositories (repositories without sections/architectures), append `/` to the suite name:

```toml
dir = "/var/www/apt"

[mirrors.debian-experimental]
url = "https://deb.debian.org/debian/"
suites = ["experimental/"]
# sections and architectures are not used for flat repositories
```
