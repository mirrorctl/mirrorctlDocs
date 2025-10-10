---
title: Install
weight: 1
---

We plan on making easier-to-use deployment methods in the future, but for now you can get started
with the following commands.

## Manual Installation

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

## Alternative Installation Locations

If you don't have sudo access or prefer to install to a different location:

```bash
# Install to user directory
mkdir -p ~/.local/bin
mv mirrorctl ~/.local/bin/
chmod +x ~/.local/bin/mirrorctl

# Add to PATH (add this to your ~/.bashrc or ~/.zshrc)
export PATH="$HOME/.local/bin:$PATH"
```

## Verify Installation

After installation, verify that mirrorctl is working correctly:

```bash
mirrorctl version
```

## Verify Checksums (Optional)

To verify the integrity of your download:

```bash
# Download checksums file
curl -LO https://github.com/mirrorctl/mirrorctl/releases/download/v1.5.0/checksums.txt

# Verify checksum (Linux/macOS)
sha256sum -c checksums.txt --ignore-missing
```

## Upgrading

To upgrade to a newer version, simply download and install the new version following the same steps above. The new binary will replace the existing one.

## Uninstalling

To remove mirrorctl:

```bash
sudo rm /usr/local/bin/mirrorctl
```

Or if installed to `~/.local/bin`:

```bash
rm ~/.local/bin/mirrorctl
```

## Next Steps

After installation, see the [Tutorial]({{< relref "tutorial" >}}) to get started with mirrorctl.
