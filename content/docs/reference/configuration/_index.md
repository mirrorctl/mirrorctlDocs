---
title: Configuration
weight: 1
cascade:
  type: docs
---

The mirrorctl configuration file uses TOML format and defines how repositories are mirrored,
including network settings, TLS configuration, snapshot management, and per-mirror options.

## Configuration File Location

By default, mirrorctl reads its configuration from `/etc/mirrorctl/mirror.toml`. You can specify
an alternative location using the `--config` flag with any command.

## Complete Example Configuration

Below is a complete example configuration for mirroring Debian Trixie:

{{< tabs items="Without Comments,With Comments" >}}
{{< tab >}}
  
```toml
# mirrorctl Configuration File
dir = "/var/www/html/mirror"
max_conns = 10

[log]
level = "info"
format = "text"

[tls]
min_version = "1.2"
max_version = "1.3"
insecure_skip_verify = false
cipher_suites = [
    "TLS_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
]
# ca_cert_file = "/path/to/custom-ca.pem"
# client_cert_file = "/path/to/client-cert.pem"
# client_key_file = "/path/to/client-key.pem"
# server_name = "custom-mirror.example.com"

[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 5
keep_within = "30d"

[mirrors.debian-trixie]
url = "https://deb.debian.org/debian/"
suites = ["trixie", "trixie-updates"]
sections = ["main", "contrib", "non-free", "non-free-firmware"]
architectures = ["amd64", "arm64"]
mirror_source = true
pgp_key_path = "/etc/mirrorctl/keys/debian-archive-keyring.gpg"
no_pgp_check = false
publish_to_staging = true

[mirrors.debian-trixie.filters]
keep_versions = 3
exclude_patterns = [
    ".*-dbg$",       # Debug packages
    ".*-dev$"        # Development packages
]

[mirrors.debian-trixie.snapshot]
default_name_format = "trixie-2006-01-02"

[mirrors.debian-trixie.snapshot.prune]
keep_last = 10
keep_within = "60d"
```  
{{< /tab >}}

  {{< tab >}}
```toml
# mirrorctl Configuration File

# Global Settings
# ===============

# Base directory where mirrored repositories will be stored
# REQUIRED: Must be an absolute path
dir = "/var/www/html/mirror"

# Maximum number of concurrent connections per mirror
# Optional: Default is 10
max_conns = 10

# Logging Configuration
# ====================
[log]
# Log level: debug, info, warn, error
# Optional: Default is "info"
level = "info"

# Log format: text, plain, json
# Optional: Default is "text"
format = "text"

# TLS/SSL Configuration
# ====================
[tls]
# Minimum TLS version: "1.2" or "1.3"
# Optional: Default is "1.2"
min_version = "1.2"

# Maximum TLS version: "1.2" or "1.3"
# Optional: Unset allows any supported version
max_version = "1.3"

# Skip certificate verification (INSECURE - testing only!)
# Optional: Default is false
insecure_skip_verify = false

# Path to custom CA certificate file for verification
# Optional: Uses system CA bundle if not specified
# ca_cert_file = "/path/to/custom-ca.pem"

# Client certificate file for mutual TLS authentication
# Optional: Must be paired with client_key_file
# client_cert_file = "/path/to/client-cert.pem"

# Client private key file for mutual TLS authentication
# Optional: Must be paired with client_cert_file
# client_key_file = "/path/to/client-key.pem"

# Allowed cipher suites (empty = Go defaults)
# Optional: Available options:
#   - TLS_AES_128_GCM_SHA256
#   - TLS_AES_256_GCM_SHA384
#   - TLS_CHACHA20_POLY1305_SHA256
#   - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
#   - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
#   - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
#   - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
cipher_suites = [
    "TLS_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
]

# Server name for SNI (Server Name Indication)
# Optional: Overrides hostname from URL
# server_name = "custom-mirror.example.com"

# Snapshot Configuration
# =====================
[snapshot]
# Base path where snapshots will be stored
# Optional: Default is "/var/lib/mirrorctl/snapshots"
path = "/var/lib/mirrorctl/snapshots"

# Default snapshot name format (Go time format)
# Optional: Default is "2006-01-02T15-04-05Z"
# Examples:
#   "2006-01-02T15-04-05Z"     -> 2024-01-15T10-30-00Z
#   "2006-01-02"               -> 2024-01-15
#   "20060102-150405"          -> 20240115-103000
default_name_format = "2006-01-02T15-04-05Z"

# Snapshot pruning/retention policy
[snapshot.prune]
# Number of recent snapshots to keep
# Optional: Default is 5
keep_last = 5

# Keep snapshots within duration
# Optional: Format examples: "7d", "2w", "30d"
# Supported units: d (days), w (weeks)
keep_within = "30d"

# Mirror Configurations
# ====================

# Debian Trixie Mirror
[mirrors.debian-trixie]
# Repository URL (http or https)
# REQUIRED
url = "https://deb.debian.org/debian/"

# Distribution suites to mirror
# REQUIRED: For flat repositories, append "/" to suite name
suites = ["trixie", "trixie-updates"]

# Repository sections to mirror
# REQUIRED for non-flat repositories
sections = ["main", "contrib", "non-free", "non-free-firmware"]

# Architectures to mirror
# REQUIRED for non-flat repositories
# Note: "all" architecture is automatically included
architectures = ["amd64", "arm64"]

# Include source packages
# Optional: Default is false
mirror_source = true

# PGP key file path for signature verification
# Optional: Uses system keyring if not specified
# pgp_key_path = "/usr/share/keyrings/debian-archive-keyring.gpg"

# Disable PGP signature verification
# Optional: Default is false (verification enabled)
no_pgp_check = false

# Automatically publish new syncs to staging
# Optional: Default is false
publish_to_staging = true

# Package filtering configuration
[mirrors.debian-trixie.filters]
# Number of package versions to keep (newest first)
# Optional: 0 = keep all versions
keep_versions = 3

# Patterns for excluding packages (regex)
# Optional: Empty = no exclusions
exclude_patterns = [
    ".*-dbg$",       # Debug packages
    ".*-dev$"        # Development packages
]

# Per-mirror snapshot configuration overrides
[mirrors.debian-trixie.snapshot]
# Override global snapshot name format for this mirror
# Optional: Uses global default if not specified
default_name_format = "trixie-2006-01-02"

# Override global pruning policy for this mirror
[mirrors.debian-trixie.snapshot.prune]
keep_last = 10
keep_within = "60d"
```
{{< /tab >}}

{{< /tabs >}}

## Minimal Configuration Example

There's a lot configured there, but not all of it is required. If you want to go with defaults,
here is a minimal configuration for Debian Trixie that works as-is:

```toml
dir = "/var/www/html/mirror"

[mirrors.debian-trixie]
url = "https://deb.debian.org/debian/"
suites = ["trixie", "trixie-updates"]
sections = ["main", "contrib", "non-free", "non-free-firmware"]
architectures = ["amd64", "arm64"]
mirror_source = true
no_pgp_check = true
```

## Configuration Sections

### Global Settings

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `dir` | string | Yes | - | Base directory for mirrored repositories |
| `max_conns` | integer | No | `10` | Maximum concurrent connections per mirror |

### Logging Configuration

Configure logging behavior under the `[log]` section:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `level` | string | No | `"info"` | Log level: `debug`, `info`, `warn`, `error` |
| `format` | string | No | `"text"` | Log format: `text`, `plain`, `json` |

### TLS Configuration

Configure TLS/SSL settings under the `[tls]` section:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `min_version` | string | No | `"1.2"` | Minimum TLS version: `"1.2"` or `"1.3"` |
| `max_version` | string | No | - | Maximum TLS version: `"1.2"` or `"1.3"` |
| `insecure_skip_verify` | boolean | No | `false` | Skip certificate verification (testing only) |
| `ca_cert_file` | string | No | - | Path to custom CA certificate file |
| `client_cert_file` | string | No | - | Client certificate for mutual TLS |
| `client_key_file` | string | No | - | Client private key for mutual TLS |
| `cipher_suites` | array | No | Go defaults | List of allowed cipher suites |
| `server_name` | string | No | - | Server name for SNI |

### Snapshot Configuration

Configure snapshot behavior under the `[snapshot]` section:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `path` | string | No | `/var/lib/mirrorctl/snapshots` | Base path for snapshots |
| `default_name_format` | string | No | `"2006-01-02T15-04-05Z"` | Default snapshot name format (Go time format) |

#### Snapshot Pruning

Configure retention policy under `[snapshot.prune]`:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `keep_last` | integer | No | `5` | Number of recent snapshots to keep |
| `keep_within` | string | No | - | Keep snapshots within duration (e.g., `"30d"`, `"2w"`) |


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

## Validation

Use the `check config` command to validate your configuration file:

```bash
mirrorctl check config
```

This will verify:
- TOML syntax
- Required fields
- File paths (PGP keys, TLS certificates)
- TLS configuration
- Repository structure

## See Also

- [sync command]({{< relref "/docs/reference/command/sync" >}}) - Synchronize repositories
- [check config command]({{< relref "/docs/reference/command/check-config" >}}) - Validate configuration
- [Environment Variables]({{< relref "/docs/reference/env-vars" >}}) - Environment variable reference
