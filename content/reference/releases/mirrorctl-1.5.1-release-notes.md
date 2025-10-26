---
title: v1.5.1
toc: false
date: 2025-10-25
weight: 98
---

This is the second release of `mirrorctl`. It is mostly a bug-fix and code-refactor release.

It is released on **Saturday, October 25th, 2025**.

## Major Changes

* Better handling of invalid mirror IDs.
* `mirrorctl` now prevents users from setting a `max_conns` value that is less than 1.
* The path for snapshot storage is now standardized, and is a child directory to the `dir`
  directory. This prevents snapshots-related path-based attacks.

## Removed Features

* Removed cyclonedx-based SBOM records. We still provide spdx-based SBOM files, and one SBOM is
  good enough for now.

## Improvements

* Simplified some repetitive code segments.
* Bumped the golang version 1.25.3.
