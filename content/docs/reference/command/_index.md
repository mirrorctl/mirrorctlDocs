---
title: Commands
weight: 2
cascade:
  type: docs
sidebar:
  open: true
---

# Commands

- [sync]({{< relref "sync" >}}) - Synchronize repositories
- [check]({{< relref "check" >}}) - Validate configuration and connectivity
  - [check config]({{< relref "check/config" >}}) - Validate configuration file
  - [check tls]({{< relref "check/tls" >}}) - Check TLS configuration
- [snapshot]({{< relref "snapshot" >}}) - Manage repository snapshots
  - [snapshot create]({{< relref "snapshot/create" >}}) - Create new snapshot
  - [snapshot list]({{< relref "snapshot/list" >}}) - List snapshots
  - [snapshot delete]({{< relref "snapshot/delete" >}}) - Delete snapshot
  - [snapshot stage]({{< relref "snapshot/stage" >}}) - Stage snapshot for testing
  - [snapshot publish]({{< relref "snapshot/publish" >}}) - Publish snapshot to production
  - [snapshot promote]({{< relref "snapshot/promote" >}}) - Promote snapshot from staging to production
  - [snapshot prune]({{< relref "snapshot/prune" >}}) - Prune old snapshots
- [version]({{< relref "version" >}}) - Display version information
