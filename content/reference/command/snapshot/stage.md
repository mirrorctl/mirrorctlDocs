---
title: snapshot stage
weight: 6
cascade:
  type: docs
---

The `mirrorctl snapshot stage` command publishes a specific snapshot to the staging environment.

This allows you to test a snapshot before promoting it to production.

```bash
mirrorctl snapshot stage <mirror-id> <snapshot-name> [flags]
```

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

| Argument | Required | Description |
|------|---------|-------|
| `mirror-id` | Yes | The ID of the mirror containing the snapshot. <br/> The mirror ID must match a key defined in the `[mirrors]` section of your configuration file. |
| `snapshot-name` | Yes | The name of the snapshot to publish to staging. <br/> The snapshot must exist. |

## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--verbose-errors` | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/reference/configuration" >}}) - Details on snapshot
  configuration
- [snapshot create]({{< relref "/reference/command/snapshot/create" >}}) - Create a snapshot
- [snapshot list]({{< relref "/reference/command/snapshot/list" >}}) - List snapshots
- [snapshot publish]({{< relref "/reference/command/snapshot/publish" >}}) - Publish snapshot
  to production
- [snapshot promote]({{< relref "/reference/command/snapshot/promote" >}}) - Promote staged
  snapshot to production
