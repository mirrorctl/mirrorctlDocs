---
title: snapshot list
weight: 9
---

## The `snapshot list` command

List snapshots for one or more mirrors.

```bash
mirrorctl snapshot list [mirror-ids...] [flags]
```

The `snapshot list` command displays all snapshots for the specified mirrors. If no mirror IDs are
provided, snapshots for all configured mirrors are listed.

## Usage

List snapshots for all configured mirrors:
```bash
mirrorctl snapshot list
```

List snapshots for a specific mirror:
```bash
mirrorctl snapshot list debian
```

List snapshots for multiple mirrors:
```bash
mirrorctl snapshot list debian debian-security
```

Show detailed snapshot information:
```bash
mirrorctl snapshot list --detailed
```

## Arguments

### [mirror-ids...]

Optional list of mirror IDs to list snapshots for. Mirror IDs must match the keys defined in the
`[mirrors]` section of your configuration file.

If no mirror IDs are specified, snapshots for all repositories defined in the configuration file
will be listed.

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--detailed` | `false` | Show detailed snapshot information including size and file count. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Output

For each mirror, the command displays:

### Standard Output
- Snapshot name
- Status (production, staging, or unmarked)

### Detailed Output (with --detailed flag)
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
  