---
title: snapshot promote
weight: 9
---

## The `snapshot promote` command

Promote the currently staged snapshot to production.

```bash
mirrorctl snapshot promote <mirror-id> [flags]
```

The `snapshot promote` command promotes the snapshot currently published to staging to the
production environment. This provides a safe workflow where snapshots can be tested in staging
before being promoted to production.

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

### <mirror-id>

**Required.** The ID of the mirror to promote. The mirror ID must match a key defined in the
`[mirrors]` section of your configuration file. A snapshot must already be published to staging
for this mirror.

## Flags

| Name | Shorthand | Default | Usage |
|------|-----------|---------|-------|
| `--config` | `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |
| `--verbose-errors` | | `false` | Show detailed error information including stack traces. |

## Exit Status

The command exits with status `0` on success and `1` on error.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on snapshot
  configuration
- [snapshot stage]({{< relref "/docs/reference/command/snapshot-stage" >}}) - Publish snapshot to
  staging
- [snapshot publish]({{< relref "/docs/reference/command/snapshot-publish" >}}) - Publish snapshot
  to production
- [snapshot list]({{< relref "/docs/reference/command/snapshot-list" >}}) - List snapshots
