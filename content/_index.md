---
title: "mirrorctl"
layout: hextra-home
---

{{< hextra/hero-container
  image="/mirrorctl-logo.png"
  imageTitle="mirrorctl - Sync Debian & Ubuntu repositories"
  imageWidth="300"
>}}

{{< hextra/hero-badge link="/docs/reference/releases/mirrorctl-1.5.0-release-notes" >}}
  <div class="hx-w-2 hx-h-2 hx-rounded-full hx-bg-primary-400"></div>
  <span>Latest version: v1.5.0</span>
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
  If you're looking for a reliable, secure, and easy-to-use utility for syncing external mirrors,
  consider *mirrorctl*.
{{< /hextra/hero-subtitle >}}
</div>
{{< /hextra/hero-container >}}

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Why use mirrorctl?
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/feature-grid cols="3" >}}
  {{< hextra/feature-card
    title="Atomic Updates"
    subtitle="`mirrorctl` only updates the publicly-facing mirror once a successful mirror sync is complete. Users will never see a mirror with a 'sync in progress' message."
  >}}

  {{< hextra/feature-card
    title="Configurable Snapshots"
    subtitle="Create repository snapshots at will, giving you the ability to easily roll-back to a known-good mirror state or to facilitate reproducible builds. You can even stage snapshots for testing before promoting them to production."
  >}}

  {{< hextra/feature-card
    title="Partial Repository Syncs"
    subtitle="You can sync only the portions of a mirror that you want, limiting your sync based on architecture, component or suite. You can even filter repository downloads to exclude certain patterns or download only a prescribed number of package versions."
  >}}

  {{< hextra/feature-card
    title="Predictable Storage Needs"
    subtitle="`mirrorctl` provides a '--dry-run' flag that shows you how much storage would be used by a repository sync without actually downloading the packages. This helps you to gauge storage needs before you sync your repositories."
  >}}

  {{< hextra/feature-card
    title="Easy to Keep Clean"
    subtitle="`mirrorctl` can optionally prune repository snapshots based on a set count of snapshots, or you can prune your repository based on a snapshot's age. Either way, `mirrorctl` makes it easy to keep storage needs in check."
  >}}
{{< /hextra/feature-grid >}}

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Security-related highlights
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

{{< hextra/feature-grid cols="3" >}}
  {{< hextra/feature-card
    title="Checksum Validation"
    subtitle="`mirrorctl` validates checksums before downloading packages, and only downloads packages when the checksums match. Checksum types `md5`, `sha1`, `sha256` and `sha512` are supported."
  >}}

  {{< hextra/feature-card
    title="PGP Key Validation"
    subtitle="By default, the application requires that you provide the upstream mirror's public PGP key, ensuring the integrity of downloaded packages. (This feature can be disabled if needed during testing.)"
  >}}

  {{< hextra/feature-card
    title="TLS Validation"
    subtitle="The application can validate upstream mirror TLS support, and allows you to configure minimum and maximum TLS versions. For advanced use cases, `mirrorctl` also supports custom certificate authorities, mutualTLS certificate/key combinations, specific cipher selections, and Server Name Identification (SNI) configurations."
  >}}

  {{< hextra/feature-card
    title="No Need to Generate Keys"
    subtitle="`mirrorctl` does not manipulate mirrors (for example, it doesn't merge packages from one repository into another), so the PGP keys provided by the upstream repositories are the only keys that you need to work with."
  >}}

  {{< hextra/feature-card
    title="Path and Symlink Protections"
    subtitle="`mirrorctl` also blocks directory traversal attempts, restricts symlinks to approved directories, and validates all file paths. This prevents malicious repository metadata from accessing files outside of prescribed boundaries."
  >}}

  {{< hextra/feature-card
    title="Signed Artifacts with SBOMs Included"
    subtitle="Each release is signed by our repository's `cosign` key, and includes a Software Bill of Materials, allowing you to easily validate the artifacts and their dependencies."
  >}}
{{< /hextra/feature-grid >}}
