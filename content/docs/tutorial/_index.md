---
title: Tutorial
weight: 2
cascade:
  type: docs
---

This tutorial will guide you through setting up and using `mirrorctl` to create and manage Debian
repository mirrors. By the end, you'll understand how to sync repositories, work with snapshots,
and implement a staging-to-production workflow for safe, zero-downtime mirror updates.

Through this tutorial you'll learn how to:

- Create your first repository mirror
- Understand how to work with snapshots
- Implement a staging and production workflow
- Expanding mirrors with multiple suites and architectures
- Secure your mirrors with PGP and TLS verification
- Perform common maintenance operations

## Prerequisites

Before you start this tutorial, make sure you have:

- **mirrorctl installed** - See the [Install]({{< relref "../install" >}}) guide
- **Sufficient disk space** - Repository mirrors can be large (Ubuntu amd64 main is ~100GB, and a
  full Debian mirror can exceed 1TB).
- **Reliable network connection** - Initial syncs download significant data
- **sudo/root access** - Required for installing to system directories (optional if using user directories)
- **Basic command line knowledge** - Comfort with terminal commands and text editors

## Time Estimate

- **Basic setup**: 15-30 minutes (plus sync time)
- **Complete tutorial**: 1-2 hours (plus sync time)
- **First sync duration**: Varies based on repository size and network speed (15 minutes to several hours)

## Tutorial Structure

This tutorial is designed to be done in order:

1. **[Your First Mirror]({{< relref "first-mirror" >}})** - Create a minimal repository mirror
2. **[Understand Snapshots]({{< relref "snapshots" >}})** - Learn about mirrorctl's snapshot system
3. **[Staging and Production Workflow]({{< relref "staging-production" >}})** - Implement safe, tested updates
4. **[Expand Your Mirror]({{< relref "expand-mirror" >}})** - Add architectures, suites, and sections
5. **[Security Best Practices]({{< relref "security" >}})** - Configure PGP and TLS verification
6. **[Common Operations]({{< relref "common-operations" >}})** - Day-to-day mirror management
7. **[Next Steps]({{< relref "next-steps" >}})** - Where to go from here

Each section builds on the previous ones, so following in order is recommended for first-time users.

## Getting Help

If you run into issues while following this tutorial:

- Check the [Reference Documentation]({{< relref "/reference" >}}) for detailed configuration options
- Review [How-To Guides]({{< relref "/how-tos" >}}) for specific tasks
- Use `mirrorctl --help` or `mirrorctl <command> --help` for command-line help

Ready to get started? Let's [create your first mirror]({{< relref "first-mirror" >}})!
