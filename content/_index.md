---
toc: false
type: default
layout: hextra-home
width: wide
---

{{< hextra/hero-container
  image="/mirrorctl-logo.png"
  imageTitle="mirrorctl - Sync Debian & Ubuntu repositories"
  imageWidth="300"
>}}
{{< hextra/hero-badge link="/docs/reference/releases/mirrorctl-1.4.2-release-notes" >}}
  <div class="hx-w-2 hx-h-2 hx-rounded-full hx-bg-primary-400"></div>
  <span>Latest version: v1.4.2</span>
  {{< icon name="arrow-circle-right" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-headline >}}
  mirrorctl 
{{< /hextra/hero-headline >}}
</div>

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-subtitle >}}
  *mirrorctl* is a mirror-syncing utility for Debian & Ubuntu software repositories.<br/><br/>
  If you're looking for a reliable, easy-to-maintain utility for syncing external mirrors,
  consider *mirrorctl*.
{{< /hextra/hero-subtitle >}}
</div>
{{< /hextra/hero-container >}}

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Noteworthy Features
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

* **Atomic updates** - `mirrorctl` ensures zero-downtime mirror updates by downloading packages to a temporary directory, then atomically switching a symlink to the new content once the sync is complete. This guarantees users always see a consistent, fully-synced mirror rather than one with updates in progress.
* **Configurable snapshots** - You can create post-sync snapshots, giving you the ability to easily roll-back to a known-good mirror state or to facilitate reproducible builds.
* **Staging snapshots** - Mirrors can be configured to publish to a `staging` snapshot, allowing you to fully test mirror contents before promoting them to production. This is especially helpful in preventing any upstream package dependency issues from affecting your users or your deployments.
* **Partial mirror syncs** - You can sync only the portions of a mirror that you want, based on a number of factors, including:
    * architecture (e.g., `amd64`)
    * component (e.g., `main`)
    * suite (e.g., `trixie`)

  And you can even filter repository downloads to:
    * exclude certain patterns (e.g., [exclude](https://packages.microsoft.com/repos/code/pool/main/c/), the `code-exporloration` and `code-insiders` packages, only downloading the `code` packages).
    * download only a prescribed number of package versions, and ignore the rest (e.g., only download the three most recent [versions of a package](https://packages.microsoft.com/repos/code/pool/main/c/code/)).
* **Keep your keys** - `mirrorctl` does not manipulate mirrors (for example, it doesn't merge packages from one mirror into another), so the signing keys provided by the upstream mirrors are the only keys that you need to work with.
* **Safely predict storage needs** - `mirrorctl` offers a `--dry-run` flag that shows you how much space is needed for each mirror, and provides a summary storage total, too. This help you to make sure you have enough space for your storage needs before you start your syncs.

## Security-related highlights

* **Checksum validation** - `mirrorctl` validates checksums before downloading packages, and only downloads packages when the checksums match. Checksum types `md5`, `sha1`, `sha256` and `sha512` are supported.
* **PGP key validation** - By default, the application requires that you provide the upstream mirror's public PGP key, ensuring the integrity of downloaded packages. (This feature can be disabled if needed.)
* **TLS validation** - The application can validate upstream mirror TLS support, and specify minimum and maximum TLS versions. For advanced use cases, `mirrorctl` also supports custom certificate authorities, mutualTLS certificate/key combinations, specific cipher selections, and Server Name Identification (SNI) configurations.
* **Path and symlink validation** - `mirrorctl` also blocks directory traversal attempts, restricts symlinks to approved directories, and validates all file paths. This prevents malicious repository metadata from accessing files outside of prescribed boundaries.
* **Up to date and well-maintained components** - We stay up-to-date with dependency updates and provide a Software Bill of Materials for dependency validation.
