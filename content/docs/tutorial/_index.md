---
title: Tutorial
weight: 2
cascade:
  type: docs
---

This tutorial shows you how to use `mirrorctl` to create and manage an apt repository mirror. By
the end, you'll understand how to:

- sync repositories
- use snapshots
- set up a staging-to-production workflow

## Prerequisites

Before you begin, make sure you have:

- **mirrorctl installed** - See the [Install]({{< relref "../install" >}}) guide.
- **Sufficient disk space** - This tutorial only requires a few megabytes of disk space, but full
  repository mirrors can be quite large (e.g., a full Debian mirror easily exceeds 1TB).
- **A reliable network connection** - Initial syncs require a stable network connection.
- **sudo/root access** - Needed for installing to system directories (optional if using user
  directories).
- **Basic command line knowledge** - You should be comfortable with terminal commands and basic
  text editors.

## Tutorial Structure

Each section builds on the prior sections, so we recommend following the steps in order:

1. **[Your First Mirror]({{< relref "first-mirror" >}})** - Create a minimal repository mirror
1. **[Understand Snapshots]({{< relref "snapshots" >}})** - Learn about mirrorctl's snapshot
   system
1. **[Staging and Production Workflow]({{< relref "staging-production" >}})** - Implement safe,
   tested updates
1. **[Expand Your Mirror]({{< relref "expand-mirror" >}})** - Add architectures, suites, and
   sections
1. **[Security Best Practices]({{< relref "security" >}})** - Configure PGP and TLS verification
1. **[Common Operations]({{< relref "common-operations" >}})** - Day-to-day mirror management
1. **[Next Steps]({{< relref "next-steps" >}})** - Where to go from here

## Getting Help

If you run into issues while following this tutorial:

- Check the [Reference Documentation]({{< relref "/reference" >}}) for detailed configuration
  options
- Review [How-To Guides]({{< relref "/how-tos" >}}) for specific tasks
- Use `mirrorctl --help` or `mirrorctl <command> --help` for command-line help

Ready to get started? Let's [create your first mirror]({{< relref "first-mirror" >}})!
