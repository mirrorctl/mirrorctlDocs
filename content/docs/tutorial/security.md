---
title: Security Best Practices
weight: 5
---

Securing your mirror infrastructure is critical - compromised repositories can lead to backdoored packages being distributed across your entire infrastructure. mirrorctl provides several security features to ensure mirror integrity and authenticity.

## Security Overview

Repository mirrors should verify:

1. **Transport security**: Encrypted connections via TLS/HTTPS
2. **Content authenticity**: PGP signature verification on Release files
3. **Content integrity**: Checksum verification on all downloaded files

mirrorctl enforces these by default and provides configuration options for stricter security policies.

## Using HTTPS Repositories

Always prefer HTTPS over HTTP when available:

```toml
[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"  # HTTPS, not HTTP
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
```

HTTPS prevents:
- Man-in-the-middle attacks
- Content tampering during transit
- Eavesdropping on repository access patterns

{{% callout type="warning" %}}
Never use `http://` for production mirrors unless absolutely necessary. Many major repositories now support HTTPS.
{{% /callout %}}

## TLS Configuration

Configure TLS security requirements in the `[tls]` section:

```toml
dir = "/var/www/apt/"

# Enforce strict TLS security
[tls]
min_version = "1.2"           # Minimum TLS 1.2 (default)
insecure_skip_verify = false  # Always verify certificates (default)

[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
```

For high-security environments, require TLS 1.3:

```toml
[tls]
min_version = "1.3"
max_version = "1.3"
cipher_suites = [
    "TLS_AES_256_GCM_SHA384",
    "TLS_CHACHA20_POLY1305_SHA256"
]
```

This restricts connections to only the most secure TLS version and cipher suites.

### Verify TLS Configuration

Before syncing, verify TLS is working correctly:

```bash
mirrorctl check tls ubuntu-noble
```

Expected output:

```
Checking TLS status for mirror 'ubuntu-noble' (archive.ubuntu.com:443)...

[+] TLS Version Support:
    TLS 1.0: Not Supported
    TLS 1.1: Not Supported
    TLS 1.2: Supported
    TLS 1.3: Supported

[+] Connection Details:
    Negotiated Version: TLS 1.3
    Negotiated Cipher:  TLS_AES_256_GCM_SHA384

[+] Server Certificate Chain:
    - Cert 0:
      Subject:  archive.ubuntu.com
      Issuer:   R3
      Expires:  2025-12-15T08:45:22Z

TLS check complete.
```

This confirms:
- The server supports modern TLS versions
- Certificate chain is valid
- Certificate expiration is in the future

## PGP Signature Verification

Repository Release files are signed with PGP keys. Verifying these signatures ensures:
- The repository content is authentic (from the official source)
- The content hasn't been tampered with
- You're not syncing from a compromised mirror

### Obtaining Repository Signing Keys

First, obtain the official signing keys for your repositories:

**Ubuntu:**
```bash
# Create key directory
sudo mkdir -p /etc/mirrorctl/keys

# Download Ubuntu archive key
sudo gpg --keyserver keyserver.ubuntu.com \
         --recv-keys 0x871920D1991BC93C \
         --export > /etc/mirrorctl/keys/ubuntu-archive-keyring.gpg
```

**Debian:**
```bash
# Download Debian release key
sudo gpg --keyserver keyserver.ubuntu.com \
         --recv-keys 0x648ACFD622F3D138 \
         --export > /etc/mirrorctl/keys/debian-archive-keyring.gpg
```

{{% details title="Alternative: Download keys from official sources" closed="true" %}}

You can also download signing keys directly from official documentation:

**Ubuntu:**
```bash
curl -fsSL https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x871920D1991BC93C | \
  gpg --dearmor | sudo tee /etc/mirrorctl/keys/ubuntu-archive-keyring.gpg > /dev/null
```

**Debian:**
```bash
curl -fsSL https://ftp-master.debian.org/keys/release-12.asc | \
  gpg --dearmor | sudo tee /etc/mirrorctl/keys/debian-bookworm-release.gpg > /dev/null
```

Always verify key fingerprints against official documentation before using them.

{{% /details %}}

### Configure PGP Verification

Add the key path to your mirror configuration:

```toml
dir = "/var/www/apt/"

[tls]
min_version = "1.2"

[mirrors.ubuntu-noble]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble"]
sections = ["main"]
architectures = ["amd64"]
pgp_key_path = "/etc/mirrorctl/keys/ubuntu-archive-keyring.gpg"  # Enable PGP verification

[mirrors.debian-bookworm]
url = "https://deb.debian.org/debian/"
suites = ["bookworm"]
sections = ["main"]
architectures = ["amd64"]
pgp_key_path = "/etc/mirrorctl/keys/debian-archive-keyring.gpg"
```

Now when you sync, mirrorctl verifies the Release file signature:

```bash
sudo mirrorctl sync ubuntu-noble
```

Output includes verification:

```
INFO  Starting sync for mirror: ubuntu-noble
INFO  Downloading Release file
INFO  Verifying PGP signature on Release file
INFO  PGP signature valid - signed by key 0x871920D1991BC93C
INFO  Downloading Packages files
...
```

If signature verification fails, the sync aborts:

```
ERROR PGP signature verification failed: invalid signature
ERROR Sync failed for ubuntu-noble
```

This prevents syncing compromised or tampered content.

{{% callout type="warning" %}}
**Never disable PGP verification in production!**

Only use `no_pgp_check = true` for testing or development mirrors. Production mirrors must always verify signatures.
{{% /callout %}}

## Checksum Verification

In addition to PGP signatures, mirrorctl verifies checksums for all downloaded files:

1. The Release file contains SHA256 checksums for all Packages files
2. Packages files contain checksums for all .deb packages
3. mirrorctl verifies each file's checksum after download

This happens automatically and requires no configuration. If checksums don't match, the file is re-downloaded.

## Configuration Validation

Before deploying configuration changes, validate them:

```bash
mirrorctl check config
```

This checks:
- TOML syntax is valid
- All required fields are present
- PGP key files exist and are readable
- TLS certificates exist (if using custom CAs)
- URLs use supported schemes
- Mirror IDs are unique

Example output:

```
INFO  the toml configuration file passes validation checks
```

If there are issues:

```
ERROR configuration validation failed error="PGP key file not found: /etc/mirrorctl/keys/missing.gpg"
```

Always run `check config` before syncing with new configurations.

## Secure Configuration Example

Here's a production-ready secure configuration:

```toml
dir = "/var/www/apt/"

# Strict TLS requirements
[tls]
min_version = "1.2"
insecure_skip_verify = false

# Snapshot configuration
[snapshot]
path = "/var/lib/mirrorctl/snapshots"
default_name_format = "2006-01-02T15-04-05Z"

[snapshot.prune]
keep_last = 7
keep_within = "30d"

# Ubuntu main repository
[mirrors.ubuntu]
url = "https://archive.ubuntu.com/ubuntu/"
suites = ["noble", "jammy"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
pgp_key_path = "/etc/mirrorctl/keys/ubuntu-archive-keyring.gpg"
publish_to_staging = true

# Ubuntu security repository
[mirrors.ubuntu-security]
url = "https://security.ubuntu.com/ubuntu/"
suites = ["noble-security", "jammy-security"]
sections = ["main", "universe"]
architectures = ["amd64", "arm64"]
pgp_key_path = "/etc/mirrorctl/keys/ubuntu-archive-keyring.gpg"
publish_to_staging = true
```

## Testing Security Configuration

After configuring security features, test them:

### 1. Validate Configuration

```bash
sudo mirrorctl check config
```

Ensures configuration is syntactically correct and all referenced files exist.

### 2. Check TLS Connectivity

```bash
mirrorctl check tls ubuntu
mirrorctl check tls ubuntu-security
```

Verifies TLS handshake succeeds and certificates are valid.

### 3. Perform Test Sync

```bash
sudo mirrorctl sync ubuntu --dry-run
```

Tests connectivity and PGP verification without downloading packages.

### 4. Full Sync Test

```bash
sudo mirrorctl sync ubuntu
```

Performs a complete sync with all security checks enabled.

## Handling Security Failures

### PGP Verification Failure

If PGP verification fails:

1. **Check key file exists**: `ls -l /etc/mirrorctl/keys/`
2. **Verify key fingerprint**: Compare against official documentation
3. **Check for key updates**: Repository keys change occasionally
4. **Verify upstream mirror**: Ensure the mirror URL is official, not a third-party mirror

### TLS Certificate Errors

If TLS verification fails:

1. **Check system time**: Incorrect time causes certificate validation failures
2. **Update CA certificates**: `sudo apt update && sudo apt install ca-certificates`
3. **Verify mirror URL**: Ensure you're using the correct hostname
4. **Check firewall rules**: Ensure outbound HTTPS (port 443) is allowed

### Checksum Mismatches

If checksum verification fails:

1. **Retry the sync**: Transient network issues can corrupt files
2. **Check disk space**: Full disks can cause truncated downloads
3. **Verify mirror is official**: Unofficial mirrors may serve corrupted content
4. **Report to mirror maintainers**: Persistent issues indicate mirror problems

## Security Monitoring

Monitor your mirrors for security issues:

```bash
# Check mirror sync logs for verification failures
sudo journalctl -u mirrorctl-sync | grep -i "verification\|signature\|checksum"

# Monitor disk usage to detect unexpected growth
du -sh /var/www/apt/*

# Verify snapshots haven't been tampered with
ls -la /var/lib/mirrorctl/snapshots/ubuntu-noble/
```

## What's Next?

With your mirror secured, learn about [Common Operations]({{< relref "common-operations" >}}) for day-to-day mirror management and maintenance.
