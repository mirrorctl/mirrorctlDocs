---
title: snapshot prune
weight: 10
cascade:
  type: docs
---

The `mirrorctl snapshot prune` command removes old snapshots according to the configured retention
policy or based on command-line flags that override that policy.

```bash
mirrorctl snapshot prune [mirror-ids...] [flags]
```

## Usage

Prune snapshots for all mirrors using configured retention policies:
```bash
mirrorctl snapshot prune
```

Prune snapshots for a specific mirror:
```bash
mirrorctl snapshot prune debian
```

Keep only the last 10 snapshots:
```bash
mirrorctl snapshot prune debian --keep-last 10
```

Keep snapshots created within the last 60 days:
```bash
mirrorctl snapshot prune debian --keep-within 60d
```

Combine retention policies:
```bash
mirrorctl snapshot prune debian --keep-last 5 --keep-within 30d
```

Preview what would be deleted without actually deleting:
```bash
mirrorctl snapshot prune debian --dry-run
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-ids` | No | Optional list of mirror IDs to prune snapshots for. <br/> Mirror IDs must match the keys defined in the `[mirrors]` section of your configuration file. <br/> If not specified, snapshots for all mirrors will be pruned. |

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--keep-last` | `0` | Number of most recent snapshots to keep. Overrides configuration file setting. |
| `--keep-within` | | Keep snapshots within the specified duration (e.g., "30d", "1w"). Overrides configuration file setting. |
| `--dry-run` | `false` | Show what would be deleted without actually deleting snapshots. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Duration Format

The `--keep-within` flag accepts duration strings with the following suffixes:
- `d` - days (e.g., "30d" = 30 days)
- `w` - weeks (e.g., "4w" = 4 weeks)
- `h` - hours (e.g., "168h" = 7 days)

## Retention Policy

Snapshots are protected from pruning if they meet any of the following criteria:
- Within the most recent N snapshots (when `--keep-last` is specified)
- Created within the specified time period (when `--keep-within` is specified)
- Currently published to production
- Currently published to staging

When both `--keep-last` and `--keep-within` are specified, a snapshot is kept if it matches either criterion.

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/reference/configuration" >}}) - Details on snapshot
  retention configuration
- [snapshot create]({{< relref "/reference/command/snapshot/create" >}}) - Create a snapshot
- [snapshot list]({{< relref "/reference/command/snapshot/list" >}}) - List snapshots
- [snapshot delete]({{< relref "/reference/command/snapshot/delete" >}}) - Manually delete
  snapshots
