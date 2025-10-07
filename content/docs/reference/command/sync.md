---
title: sync
weight: 1
toc: false
---

The `sync` command initiates the download of external repositories, creating local mirrors of 
those repositories.

```bash
mirrorctl sync [mirror-ids...] [flags]
```


1. It reads configuration from a TOML file (default: `/etc/mirrorctl/mirror.toml`)
1. It then synchronizes either
   - all of configured repositories (if no mirror IDs are provided in the command), or
   - the individual repository / repositories that are provided as part of the sync command.

## Usage

Synchronize all repositories in your `/etc/mirrorctl/mirror.toml` configuration file:
```bash
mirrorctl sync
```

Synchronize only specific repositories:
```bash
mirrorctl sync debian debian-security
```

Use a custom configuration file:
```bash
mirrorctl sync --config /path/to/custom-location.toml
```

Override the configured log level, setting it to `debug`:
```bash
mirrorctl sync --log-level debug
```

Show detailed error information with stack traces:
```bash
mirrorctl sync --verbose-errors
```

Suppress all output except for errors:
```bash
mirrorctl sync --quiet
```

Calculate disk usage without downloading files:
```bash
mirrorctl sync --dry-run
```

Overwrite an existing snapshot if one already exists:
```bash
mirrorctl sync --force
```

## Arguments

### [mirror-ids ...]

Optional list of mirror IDs to synchronize. Mirror IDs must match the keys defined in the
`[mirrors]` section of your configuration file.

If no mirror IDs are specified, all repositories defined in the configuration file will be
synchronized.

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--log-level`, `-l` | (from configuration file) | Override the log level specified in the configuration file. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |
| `--quiet`, `-q` | `false` | Suppress all output except for errors. |
| `--dry-run` | `false` | Calculate and report disk usage requirements without actually downloading any files. |
| `--no-pgp-check` | `false` | Disable PGP signature verification on Release files. Use for testing only. |
| `--force` | `false` | Overwrite the snapshot if it already exists. |
| `--help`, `-h` | `false` | Display help information for the `sync` command. |

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on TOML configuration file
- [Environment Variables]({{< relref "/docs/reference/env-vars" >}}) - Details on environment variables
