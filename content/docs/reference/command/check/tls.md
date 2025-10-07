---
title: check tls
weight: 4
---

## The `check tls` command

Check TLS configuration and capabilities for a mirror.

```bash
mirrorctl check tls <mirror-id> [flags]
```

The `check tls` command performs a detailed TLS handshake and certificate check against the remote
server for a configured mirror. This helps diagnose TLS connection issues by testing supported TLS
versions, negotiated cipher suites, and examining the certificate chain.

## Usage

Check TLS configuration for a specific mirror:
```bash
mirrorctl check tls debian
```

Use a custom configuration file:
```bash
mirrorctl check tls debian --config /path/to/custom.toml
```

## Arguments

### <mirror-id>

**Required.** The ID of the mirror to check. The mirror ID must match a key defined in the
`[mirrors]` section of your configuration file.

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |

## Output

The command displays the following information:

### TLS Version Support
Tests connectivity with each TLS version (1.0, 1.1, 1.2, 1.3) and reports whether the remote
server supports each version.

### Connection Details
Shows the negotiated TLS version and cipher suite when connecting with your current configuration
settings.

### Server Certificate Chain
Displays information about each certificate in the server's certificate chain:
- Subject (Common Name)
- Issuer (Common Name)
- Expiration date

## Exit Status

The command exits with status `0` on success and `1` if the mirror is not found in the configuration.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on TLS
  configuration
- [Environment Variables]({{< relref "/docs/reference/env-vars" >}}) - TLS-related environment
  variables
- [check config]({{< relref "/docs/reference/command/check/config" >}}) - Validate configuration
  file
- [sync]({{< relref "/docs/reference/command/sync" >}}) - Synchronize repositories
