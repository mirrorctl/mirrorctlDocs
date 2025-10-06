---
title: version
weight: 99
---

## The `version` command

Print version information including build details.

```bash
mirrorctl version
```

The `version` command displays the current version of mirrorctl, the git commit hash used to build
the binary, and the build timestamp.

## Usage

Display version information:
```bash
mirrorctl version
```

## Arguments

This command takes no arguments.

## Flags

This command has no specific flags. Global flags from the root command are available but not
typically used with `version`.

## Exit Status

The command exits with status `0` on success.

## See Also

- [sync]({{< relref "/docs/reference/command/sync" >}}) - Synchronize repositories
