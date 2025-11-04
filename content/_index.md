---
title: "mirrorctl"
layout: hextra-home
---

{{< hextra/hero-container
  image="/mirrorctl-logo.png"
  imageTitle="mirrorctl - Sync Debian & Ubuntu repositories"
  imageWidth="300"
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
  Zero-downtime repository mirroring with atomic updates, snapshots, and enterprise-grade security.<br/>
  Built for system administrators who need reliable, production-ready mirror infrastructure.
{{< /hextra/hero-subtitle >}}
</div>
{{< /hextra/hero-container >}}

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
See it in action
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

<div class="hx-mt-6"></div>

<div style="max-width: 1200px; margin: 0 auto;">
  <img src="/mirrorctl-sync.gif" alt="mirrorctl sync demonstration" style="width: 100%; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);" />
</div>

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

<div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
  <a href="/docs/install" style="display: inline-block; padding: 0.75rem 2rem; background: hsl(var(--primary)); color: white; text-decoration: none; border-radius: 0.5rem; font-weight: 600; transition: opacity 0.2s;">Get Started →</a>
  <a href="/docs/tutorial" style="display: inline-block; padding: 0.75rem 2rem; border: 2px solid hsl(var(--primary)); color: hsl(var(--primary)); text-decoration: none; border-radius: 0.5rem; font-weight: 600; transition: all 0.2s;">View Tutorial</a>
</div>

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/hero-container >}}
{{< hextra/hero-section heading="h3" >}}
Key Features
{{< /hextra/hero-section >}}
{{< /hextra/hero-container >}}

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

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

<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>
<div class="hx-mt-6"></div>

{{< hextra/hero-container >}}
<div style="text-align: center; padding: 3rem 1rem;">
  <h2 style="font-size: 2rem; font-weight: 700; margin-bottom: 1rem;">Ready to build reliable mirror infrastructure?</h2>
  <p style="font-size: 1.25rem; opacity: 0.8; margin-bottom: 2rem; max-width: 600px; margin-left: auto; margin-right: auto;">Install mirrorctl in minutes and create your first production-ready mirror today.</p>
  <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
    <a href="/docs/install" style="display: inline-block; padding: 1rem 2.5rem; background: hsl(var(--primary)); color: white; text-decoration: none; border-radius: 0.5rem; font-weight: 600; font-size: 1.125rem; transition: opacity 0.2s;">Get Started →</a>
    <a href="https://github.com/mirrorctl/mirrorctl" style="display: inline-block; padding: 1rem 2.5rem; border: 2px solid hsl(var(--primary)); color: hsl(var(--primary)); text-decoration: none; border-radius: 0.5rem; font-weight: 600; font-size: 1.125rem; transition: all 0.2s;">View on GitHub</a>
  </div>
</div>
{{< /hextra/hero-container >}}
