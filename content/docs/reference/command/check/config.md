---
title: check config
weight: 3
---

## The `check config` command

Validate the configuration file and report any issues.

```bash
mirrorctl check config [flags]
```

The `check config` command validates your TOML configuration file without performing any mirroring
operations. It checks for syntax errors, validates all configuration sections, and ensures that
referenced files (like PGP keys) exist and are accessible.

## Validation Checks

The command performs the following validation checks:

- **TOML syntax** - Ensures the file is valid TOML
- **Required fields** - Verifies all required configuration fields are present
- **Mirror IDs** - Validates that mirror IDs are properly formatted
- **URLs** - Checks that repository URLs use supported schemes (http, https)
- **File paths** - Verifies that referenced files (PGP keys, TLS certificates) exist
- **TLS configuration** - Validates TLS version constraints and certificate pairs
- **Logging configuration** - Checks that log level and format values are valid
- **Repository structure** - Ensures suites, sections, and architectures are properly configured

## Usage

Validate the default configuration file:
```bash
mirrorctl check config
```env-vars

Validate a custom configuration file:
```bash
mirrorctl check config --config /path/to/custom.toml
```

Show detailed validation errors:
```bash
mirrorctl check config --verbose-errors
```

## Arguments

This command takes no arguments.

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file to validate. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` if the configuration is valid and `1` if validation fails.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on TOML
  configuration file
- [check tls]({{< relref "/docs/reference/command/check/tls" >}}) - Check TLS connectivity for a
  mirror
- [sync]({{< relref "/docs/reference/command/sync" >}}) - Synchronize repositories
