---
title: TLS Configuration
---

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
