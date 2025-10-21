---
title: Install
weight: 1
---

## Install a prebuilt binary

Prebuilt binaries are available for for both Linux and Mac operating systems, including builds for
both x86_64 and arm64 architectures. 

Please consult your operating system documentation if you need help setting file permissions or
modifying your PATH environment variable.

{{< tabs items="Linux (x86_64),Linux (arm64),MacOS (arm64 - Apple Silicon),MacOS (x86_64 - Intel)" >}}

{{< tab >}}

```bash
# Download the binary - Linux x86_64
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_linux_amd64.tar.gz

# Extract the archive
tar -xzf mirrorctl_1.5.0_linux_amd64.tar.gz

# Move the binary to your PATH
sudo mv mirrorctl /usr/local/bin/

# Make it executable
sudo chmod +x /usr/local/bin/mirrorctl

# Verify installation
mirrorctl version
```

{{< /tab >}}

{{< tab >}}

```bash
# Download the binary - Linux arm64
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_darwin_arm64.tar.gz

# Extract the archive
tar -xzf mirrorctl_1.5.0_darwin_arm64.tar.gz

# Move the binary to your PATH
sudo mv mirrorctl /usr/local/bin/

# Make it executable
sudo chmod +x /usr/local/bin/mirrorctl

# Verify installation
mirrorctl version
```

{{< /tab >}}
{{< tab >}}
```bash
# Download the binary - MacOS Apple Silicon / arm64
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_linux_arm64.tar.gz

# Extract the archive
tar -xzf mirrorctl_1.5.0_linux_arm64.tar.gz

# Move the binary to your PATH
sudo mv mirrorctl /usr/local/bin/

# Make it executable
sudo chmod +x /usr/local/bin/mirrorctl

# Verify installation
mirrorctl version
```
{{< /tab >}}

{{< tab >}}

```bash
# Download the binary - MacOS x86_64
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_darwin_amd64.tar.gz

# Extract the archive
tar -xzf mirrorctl_1.5.0_darwin_amd64.tar.gz

# Move the binary to your PATH
sudo mv mirrorctl /usr/local/bin/

# Make it executable
sudo chmod +x /usr/local/bin/mirrorctl

# Verify installation
mirrorctl version
```

{{< /tab >}}
{{< /tabs >}}

### Verify checksums (Optional)

To verify the integrity of your download:

```bash
# Download checksums file
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/checksums.txt

# Verify checksum (Linux/macOS)
sha256sum -c checksums.txt --ignore-missing
```

### Verify the mirrorctl cosign signature (Optional)

Official `mirrorctl` release binaries are signed by by the project's `cosign` private key. You can
verify that your `mirrorctl` binary was produced by our build system by following these
instructions:

1. Install [cosign](https://docs.sigstore.dev/cosign/system_config/installation/)
1. Retrieve the `mirrorctl` cosign public key:

   ```
   curl -LO https://github.com/mirrorctl/mirrorctl/raw/refs/heads/main/cosign.pub
   ```

1. Retrieve the `mirrorctl` `.sig` file that corresponds to the archive that you downloaded. For
   example, here's how to download the signature file for the 1.5.0 release file for the `x86_64`
   architecture:

   ```
   curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_linux_amd64.tar.gz.sig
   ```

1. Run the relevant `cosign` command to verify the release archive signature:

   ```
   cosign verify-blob --key cosign.pub /path/to/mirrorctl_1.5.0_linux_amd64.tar.gz --signature /path/to/mirrorctl_1.5.0_linux_amd64.tar.gz.sig
   ```

### Inspect the Software Bill of Materials (Optional)

`mirrorctl` ships with a [Software Bill of Materials](https://www.cisa.gov/sbom) (SBOM) that is
generated at build time, and which you can inspect with the
[Anchore Grype](https://anchore.com/opensource/) application:

1. Install [Anchore Grype](https://github.com/anchore/grype?tab=readme-ov-file#installation).
1. Download the relevant SBOM file for your archive. For example, here's the SBOM for the 1.5.0
   version for the AMD64 Linux archive:

   ```
   curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/mirrorctl_1.5.0_linux_amd64.spdx.json
   ```

1. Run the `grype` command against the downloaded SBOM json file:

   ```
   grype sbom:mirrorctl_1.5.0_linux_amd64.spdx.json
   ```
1. View the results:
   ```
   $ grype sbom:mirrorctl_1.5.0_linux_amd64.spdx.json
   ✔ Vulnerability DB                [updated]  
   ✔ Scanned for vulnerabilities     [0 vulnerability matches]  
     ├── by severity: 0 critical, 0 high, 0 medium, 0 low, 0 negligible
   No vulnerabilities found
   ```

## Upgrade

To upgrade to a newer version, simply download and install the new version following the same
steps above. The new binary will replace the existing one.

## Uninstall

To remove mirrorctl:

```bash
sudo rm /usr/local/bin/mirrorctl
```

## Next Steps

After installation, see the [Tutorial]({{< relref "tutorial" >}}) to get started with mirrorctl.
