---
title: v1.5.0
---

This is the initial release of an application formerly known as `go-apt-mirror`.
While not quite a 'gut rehab' of the application, we've certainly replaced some
plumbing, refinished the floors, and have redone the bathroom. That, along with some fresh
paint, makes this a solid release.

## Major Changes

- The binary has been renamed from `go-apt-mirror` to `mirrorctl`.
- Significantly refactored core mirroring logic to be more modular and extensible. For example,
  we've laid the groundwork for alternate storage backends. There will likely be greater work in
  this area to make the codebase easier to maintain.

## New Features

- Introduced a new snapshotting feature (along with the ability to automatically
  prune snapshots).
- We include a `--dry-run` feature which allows you to anticipate storage needs.
- Introduced a storage abstraction layer for future support of alternate storage backends.
- Improved HTTP client with connection pooling, retries, and better error handling.
- We've added PGP key validation and TLS validation features to the application. Also, we've
  included path-traversal protections to shield against malicious repository packages.
- Improved concurrency control and file locking to ensure data integrity.

## Improvements

- Updated dependencies and switched to standard library components like `slog`.
- Implemented `go-releaser` for publishing, including SBOM creation and artifact signing.
- Updated and improved tests.
