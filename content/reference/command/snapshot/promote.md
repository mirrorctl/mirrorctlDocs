---
title: snapshot promote
weight: 7
cascade:
  type: docs
---

The `mirrorctl snapshot promote` command promotes the currently staged snapshot to production.

This is part of a workflow where snapshots are tested in staging before being promoted to
production.

```bash
mirrorctl snapshot promote <mirror-id> [flags]
```

## Usage

Promote the staged snapshot to production:
```bash
mirrorctl snapshot promote debian
```

Promote with a custom configuration file:
```bash
mirrorctl snapshot promote debian --config /path/to/custom.toml
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-id` | Yes | The ID of the mirror to promote. <br/> The mirror ID must match a key defined in the `[mirrors]` section of your configuration file. <br/> A snapshot must already be published to staging for this mirror. |

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
- [snapshot stage]({{< relref "/reference/command/snapshot/stage" >}}) - Publish snapshot to
  staging
- [snapshot publish]({{< relref "/reference/command/snapshot/publish" >}}) - Publish snapshot
  to production
- [snapshot list]({{< relref "/reference/command/snapshot/list" >}}) - List snapshots
