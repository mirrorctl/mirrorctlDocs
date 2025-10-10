---
title: tls
---

### TLS Options

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

### Configuration Example

```toml
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
```
