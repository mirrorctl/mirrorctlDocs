---
title: snapshot delete
weight: 11
---

The `mirrorctl snapshot delete` command permanently removes one or more snapshots from a mirror.

By default, it will not delete snapshots that are currently published to staging or production
unless the `--force` flag is used.

```bash
mirrorctl snapshot delete <mirror-id> <snapshot-name...> [flags]
```

## Usage

Delete a single snapshot:
```bash
mirrorctl snapshot delete debian "old-snapshot"
```

Delete multiple snapshots:
```bash
mirrorctl snapshot delete debian "snap1" "snap2" "snap3"
```

Force delete a snapshot even if it's currently published:
```bash
mirrorctl snapshot delete debian "current" --force
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-id` | Yes | The ID of the mirror containing the snapshots to delete. <br/> The mirror ID must match a key defined in the `[mirrors]` section of your configuration file. |
| `snapshot-name` | Yes | One or more snapshot names to delete. <br/> At least one snapshot name must be provided. |

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--force` | `false` | Delete snapshot even if it is currently published or staged. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` on success and `1` on error.

If deleting multiple snapshots, the command will continue attempting to delete remaining
snapshots even if one fails.

## See Also

- [snapshot create]({{< relref "/docs/reference/command/snapshot/create" >}}) - Create a snapshot
- [snapshot list]({{< relref "/docs/reference/command/snapshot/list" >}}) - List snapshots
- [snapshot prune]({{< relref "/docs/reference/command/snapshot/prune" >}}) - Automatically remove
  old snapshots
