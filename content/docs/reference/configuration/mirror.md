---
title: Mirror Configuration
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
