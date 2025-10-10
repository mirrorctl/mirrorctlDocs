---
title: config
weight: 3
cascade:
  type: docs
---

The `mirrorctl check config` command validates the configuration file and reports any issues.

This command is helpful when you're creating a mirrorctl configuration file and want to validate
it before attempting to use it. It checks for syntax errors, validates all configuration sections,
and ensures that referenced files (like PGP keys) exist and are accessible.

```bash
mirrorctl check config [flags]
```

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
```

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

## Output

Example of a successful configuration check:

```
$ mirrorctl check config                 
time=2025-10-09T10:27:41.551-05:00 level=INFO msg="the toml configuration file passes validation checks"
```

Example of a failed configuration check:

```
$ mirrorctl check config             
2025/10/09 10:29:10 ERROR configuration validation failed error="configuration contains unknown sections: [mirrors.debian-trixie.sweets]\nThese sections don't match any expected configuration structure." path=/etc/mirrorctl/mirror.toml
```

## Exit Status

The command exits with status `0` if the configuration is valid and `1` if validation fails.

## See Also

- [Configuration Reference]({{< relref "/reference/configuration" >}}) - Details on TOML
  configuration file
- [check tls]({{< relref "/reference/command/check/tls" >}}) - Check TLS connectivity for a
  mirror
- [sync]({{< relref "/reference/command/sync" >}}) - Synchronize repositories
