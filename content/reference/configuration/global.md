---
title: global
---

### Global Settings Reference

| Setting | Type | Required | Default | Description |
|---------|------|----------|---------|-------------|
| `dir` | string | Yes | - | Base directory for mirrored repositories |
| `max_conns` | integer | No | `10` | Maximum concurrent connections per mirror |

### Global Settings Example

```toml
# mirrorctl Configuration File

# Global Settings
# ===============

# Base directory where mirrored repositories will be stored
# REQUIRED: Must be an absolute path
dir = "/var/www/apt/"

# Maximum number of concurrent connections per mirror
# Optional: Default is 10
max_conns = 10
```
