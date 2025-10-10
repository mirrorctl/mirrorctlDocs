---
title: Guide
cascade:
  type: docs
---

`mirrorctl` is a mirror-syncing utility for Debian software repositories. It provides
admin-friendly features for creating and maintaining secure, reliable mirror infrastructure with
zero-downtime updates, configurable snapshots, and robust security validation.

## Key Features

- **Atomic updates** - Zero-downtime mirror updates through atomic symlink switching
- **Configurable snapshots** - Create post-sync snapshots for rollback and reproducible builds
- **Staging snapshots** - Test mirror contents before promoting to production
- **Partial mirror syncs** - Sync only what you need by architecture, component, or suite
- **Security-focused** - Checksum validation, PGP key validation, and TLS verification built-in

## Getting Started

New to mirrorctl? Start here:

- **[Install]({{< relref "install" >}})** - Download and install mirrorctl on your system
- **[Tutorial]({{< relref "tutorial" >}})** - Step-by-step guide to get started with your first
  mirror

Additional resources:

- **[How-To Articles]({{< relref "how-tos" >}})** - Task-oriented guides for common operations
  commands
- **[Reference]({{< relref "reference" >}})** - Detailed documentation for configuration and
