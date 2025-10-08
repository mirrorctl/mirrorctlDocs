---
title: snapshot
---

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
