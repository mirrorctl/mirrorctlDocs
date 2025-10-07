---
title: snapshot stage
weight: 6
---

## The `snapshot stage` command

Publish a snapshot to the staging environment.

```bash
mirrorctl snapshot stage <mirror-id> <snapshot-name> [flags]
```

The `snapshot stage` command publishes a specific snapshot to the staging environment by updating
the staging symbolic link defined in your snapshot configuration.

## Usage

Publish a snapshot to staging:
```bash
mirrorctl snapshot stage debian "2024-01-15T10-30-00Z"
```

Stage with a custom configuration file:
```bash
mirrorctl snapshot stage debian "testing" --config /path/to/custom.toml
```

## Arguments

### <mirror-id>

**Required.** The ID of the mirror containing the snapshot. The mirror ID must match a key defined
in the `[mirrors]` section of your configuration file.

### <snapshot-name>

**Required.** The name of the snapshot to publish to staging. The snapshot must exist.

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on snapshot
  configuration
- [snapshot create]({{< relref "/docs/reference/command/snapshot-create" >}}) - Create a snapshot
- [snapshot list]({{< relref "/docs/reference/command/snapshot-list" >}}) - List snapshots
- [snapshot publish]({{< relref "/docs/reference/command/snapshot-publish" >}}) - Publish snapshot
  to production
- [snapshot promote]({{< relref "/docs/reference/command/snapshot-promote" >}}) - Promote staged
  snapshot to production
