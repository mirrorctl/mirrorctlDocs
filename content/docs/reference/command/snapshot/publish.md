---
title: snapshot publish
weight: 8
---

The `mirrorctl snapshot publish` command publishes a specific snapshot to the production
environment.

This updates the production symbolic link to point to the specified snapshot.

```bash
mirrorctl snapshot publish <mirror-id> <snapshot-name> [flags]
```

## Usage

Publish a snapshot to production:
```bash
mirrorctl snapshot publish debian "2024-01-15T10-30-00Z"
```

Publish with a custom configuration file:
```bash
mirrorctl snapshot publish debian "stable" --config /path/to/custom.toml
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-id` | Yes | The ID of the mirror containing the snapshot. <br/> The mirror ID must match a key defined in the `[mirrors]` section of your configuration file. |
| `snapshot-name` | Yes | The name of the snapshot to publish to production. <br/> The snapshot must exist. |

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
- [snapshot create]({{< relref "/docs/reference/command/snapshot/create" >}}) - Create a snapshot
- [snapshot list]({{< relref "/docs/reference/command/snapshot/list" >}}) - List snapshots
- [snapshot stage]({{< relref "/docs/reference/command/snapshot/stage" >}}) - Publish snapshot to
  staging
- [snapshot promote]({{< relref "/docs/reference/command/snapshot/promote" >}}) - Promote staged
  snapshot to production
