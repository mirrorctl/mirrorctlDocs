---
title: Environment Variables
weight: 3
---

Environment variables override the corresponding values in the configuration file. This allows for
runtime customization without modifying the TOML configuration.

Using environtment variables is particularly useful in CI/CD and container-related environments.

## General Configuration

| Variable | Default | Usage |
|----------|---------|-------|
| `MIRRORCTL_DIR` | (from configuration file) | Override the mirror directory path where repositories are stored. |
| `MIRRORCTL_MAX_CONNS` | `10` | Override the maximum number of concurrent connections for downloading files. |

## Logging

| Variable | Default | Usage |
|----------|---------|-------|
| `MIRRORCTL_LOG_LEVEL` | `info` | Override the log level. Valid values: `debug`, `info`, `warn`, `error`. |
| `MIRRORCTL_LOG_FORMAT` | `text` | Override the log format. Valid values: `json`, `text`, `plain`. |

## TLS/HTTPS Configuration

| Variable | Default | Usage |
|----------|---------|-------|
| `MIRRORCTL_TLS_MIN_VERSION` | `1.2` | Minimum TLS version to use. Valid values: `1.2`, `1.3`. |
| `MIRRORCTL_TLS_MAX_VERSION` | (latest supported) | Maximum TLS version to use. Valid values: `1.2`, `1.3`. |
| `MIRRORCTL_TLS_INSECURE_SKIP_VERIFY` | `false` | Skip TLS certificate verification. Valid values: `true`, `false`. **Warning:** Only use for testing. |
| `MIRRORCTL_TLS_CA_CERT_FILE` | (system CA bundle) | Path to custom CA certificate file for verification. |
| `MIRRORCTL_TLS_CLIENT_CERT_FILE` | | Path to client certificate file for mutual TLS authentication. |
| `MIRRORCTL_TLS_CLIENT_KEY_FILE` | | Path to client private key file for mutual TLS authentication. |
| `MIRRORCTL_TLS_CIPHER_SUITES` | (Go defaults) | Comma-separated list of allowed cipher suites. See supported cipher suites below. |
| `MIRRORCTL_TLS_SERVER_NAME` | (hostname from URL) | Server name for SNI (Server Name Indication). Overrides the hostname from the URL. |

### Supported Cipher Suites

When setting `MIRRORCTL_TLS_CIPHER_SUITES`, use a comma-separated list of the following values:

- `TLS_AES_128_GCM_SHA256` (TLS 1.3)
- `TLS_AES_256_GCM_SHA384` (TLS 1.3)
- `TLS_CHACHA20_POLY1305_SHA256` (TLS 1.3)
- `TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256` (TLS 1.2)
- `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384` (TLS 1.2)
- `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256` (TLS 1.2)
- `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` (TLS 1.2)

Example:
```bash
export MIRRORCTL_TLS_CIPHER_SUITES="TLS_AES_256_GCM_SHA384,TLS_CHACHA20_POLY1305_SHA256"
```

## Usage Examples

Override the mirror directory:
```bash
export MIRRORCTL_DIR=/mnt/mirrors
mirrorctl sync
```

Enable debug logging:
```bash
export MIRRORCTL_LOG_LEVEL=debug
mirrorctl sync
```

Use JSON formatted logs:
```bash
export MIRRORCTL_LOG_FORMAT=json
mirrorctl sync
```

Configure custom CA certificate:
```bash
export MIRRORCTL_TLS_CA_CERT_FILE=/etc/ssl/certs/custom-ca.pem
mirrorctl sync
```

Set up mutual TLS authentication:
```bash
export MIRRORCTL_TLS_CLIENT_CERT_FILE=/etc/mirrorctl/client.crt
export MIRRORCTL_TLS_CLIENT_KEY_FILE=/etc/mirrorctl/client.key
mirrorctl sync
```

## See Also

- [Command Reference]({{< relref "/reference/command" >}}) - Details on environment variables
- [Configuration Reference]({{< relref "/reference/configuration" >}}) - Details on TOML configuration file
