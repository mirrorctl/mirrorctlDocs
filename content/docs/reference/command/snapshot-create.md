---
title: snapshot create
weight: 5
---

## The `snapshot create` command

Create a new snapshot of a mirror.

```bash
mirrorctl snapshot create <mirror-id> [snapshot-name] [flags]
```

The `snapshot create` command creates a hardlink-based snapshot of a mirror. Snapshots allow you
to maintain multiple versions of a repository for staging and production workflows.

## Usage

Create a snapshot with an auto-generated name:
```bash
mirrorctl snapshot create debian
```

Create a snapshot with a custom name:
```bash
mirrorctl snapshot create debian "2024-01-15-stable"
```

Create a snapshot and immediately publish it to staging:
```bash
mirrorctl snapshot create debian --stage
```

Overwrite an existing snapshot:
```bash
mirrorctl snapshot create debian "backup" --force
```

## Arguments

### <mirror-id>

**Required.** The ID of the mirror to snapshot. The mirror ID must match a key defined in the
`[mirrors]` section of your configuration file.

### [snapshot-name]

Optional name for the snapshot. If not provided, a timestamp-based name will be auto-generated
according to the mirror's snapshot configuration.

## Flags

| Name | Shorthand | Default | Usage |
|------|-----------|---------|-------|
| `--config` | `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--force` | | `false` | Overwrite existing snapshot with the same name. |
| `--stage` | | `false` | Publish the snapshot to staging after creation. |
| `--verbose-errors` | | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on snapshot
  configuration
- [snapshot list]({{< relref "/docs/reference/command/snapshot-list" >}}) - List snapshots
- [snapshot stage]({{< relref "/docs/reference/command/snapshot-stage" >}}) - Publish snapshot to
  staging
- [snapshot publish]({{< relref "/docs/reference/command/snapshot-publish" >}}) - Publish snapshot
  to production
