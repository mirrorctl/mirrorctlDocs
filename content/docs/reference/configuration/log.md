---
title: log
---

### Logging Configuration

Configure logging behavior under the `[log]` section:

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `level` | string | No | `"info"` | Log level: `debug`, `info`, `warn`, `error` |
| `format` | string | No | `"text"` | Log format: `text`, `plain`, `json` |

### Configuration Example

```toml
# Logging Configuration
# ====================
[log]
# Log level: debug, info, warn, error
# Optional: Default is "info"
level = "info"

# Log format: text, plain, json
# Optional: Default is "text"
format = "text"
```
