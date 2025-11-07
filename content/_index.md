---
title: "mirrorctl"
layout: hextra-home
---

{{< hextra/hero-container
  image="/mirrorctl-sync.gif"
  imageTitle="mirrorctl sync demonstration"
  imageWidth="853"
>}}

{{< hextra/hero-badge link="/reference/releases/mirrorctl-1.5.1-release-notes" >}}
  <div class="hx-w-2 hx-h-2 hx-rounded-full hx-bg-primary-400"></div>
  <span>Latest version: v1.5.1</span>
  {{< icon name="arrow-circle-right" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-headline >}}
  mirrorctl 
{{< /hextra/hero-headline >}}
</div>

<div class="hx-mt-6 hx-mb-6">
{{< hextra/hero-subtitle >}}
  Zero-downtime Debian repository mirroring with atomic updates, snapshots, and conscientious
  attention to security.<br/><br/>
  Built for system administrators who need reliable, and easy-to use mirror infrastructure.
{{< /hextra/hero-subtitle >}}
</div>
{{< /hextra/hero-container >}}

<div style="margin-top: 4rem;"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Key Features
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

<div style="margin-top: 1rem;"></div>

{{< hextra/feature-grid cols="2" >}}
  {{< hextra/feature-card
    title="Zero-Downtime Atomic Updates"
    subtitle="Your users never see incomplete syncs or 'mirror in progress' messages. `mirrorctl` only updates the public-facing mirror after a complete, verified sync succeeds."
  >}}

  {{< hextra/feature-card
    title="Snapshot Management"
    subtitle="Create point-in-time snapshots for rollback capability and reproducible builds. Stage snapshots for testing before promoting to production, with automated pruning by age or count."
  >}}

  {{< hextra/feature-card
    title="Enterprise Security Built-In"
    subtitle="Multi-layer validation with PGP signature verification, checksum validation (md5/sha1/sha256/sha512), TLS enforcement with configurable versions, and path traversal protections. All releases are cosign-signed with SBOMs included."
  >}}

  {{< hextra/feature-card
    title="Flexible & Efficient Syncing"
    subtitle="Sync only what you need by architecture, suite, or component. Filter packages by pattern, limit version counts, and use `--dry-run` to preview storage requirements before downloading."
  >}}
{{< /hextra/feature-grid >}}

<div style="margin-top: 4rem;"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Learn more about mirrorctl
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

<div style="margin-top: 1rem;"></div>

{{< hextra/feature-grid cols="2" >}}
  {{< hextra/feature-card
    title="Get Started"
    subtitle="Install `mirrorctl` and create your first mirror."
    link="/docs/install"
  >}}

  {{< hextra/feature-card
    title="View on GitHub"
    subtitle="Explore the source code, report issues, and contribute to the project."
    link="https://github.com/mirrorctl/mirrorctl"
  >}}
{{< /hextra/feature-grid >}}
