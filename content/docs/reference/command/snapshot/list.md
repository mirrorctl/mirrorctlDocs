---
title: snapshot list
weight: 9
---

The `mirrorctl snapshot list` command displays all snapshots for one or more mirrors.

Use this command to see which snapshots are available and their current status (production,
staging, or unmarked).

```bash
mirrorctl snapshot list [mirror-ids...] [flags]
```

## Usage

List snapshots for all configured mirrors:
```bash
mirrorctl snapshot list
```

List snapshots for a specific mirror:
```bash
mirrorctl snapshot list debian-trixie
```

List snapshots for multiple mirrors:
```bash
mirrorctl snapshot list debian-trixie debian-trixie-security
```

Show detailed snapshot information:
```bash
mirrorctl snapshot list --detailed
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-ids` | No | Optional list of mirror IDs to list snapshots for. <br/> Mirror IDs must match the keys defined in the `[mirrors]` section of your configuration file. <br/> If not specified, snapshots for all mirrors will be listed. |

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--detailed` | `false` | Show detailed snapshot information including size and file count. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Output

For each mirror, the command displays:

**Standard Output:**
- Snapshot name
- Status (production, staging, or unmarked)

**Detailed Output (with --detailed flag):**
- Snapshot name
- Status (production, staging, or unmarked)
- Total size in bytes
- Number of files

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [snapshot create]({{< relref "/docs/reference/command/snapshot/create" >}}) - Create a snapshot
- [snapshot publish]({{< relref "/docs/reference/command/snapshot/publish" >}}) - Publish snapshot
  to production
- [snapshot stage]({{< relref "/docs/reference/command/snapshot/stage" >}}) - Publish snapshot to
  staging
- [snapshot delete]({{< relref "/docs/reference/command/snapshot/delete" >}}) - Delete snapshots
