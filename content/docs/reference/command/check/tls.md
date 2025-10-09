---
title: check tls
weight: 4
---

The `mirrorctl check tls` command checks a mirror's TLS configuration and capabilities.

```bash
mirrorctl check tls <mirror-id> [flags]
```

This command is helpful when you want to know what TLS versions and cipher suites are supported,
as well as when you want to verify a server's certificate chain.

## Usage

Here's an example that checks the TLS configuration for a `debian-trixie` mirror using a custom
configuration file:

```bash
mirrorctl check tls debian-trixie --config /path/to/custom.toml
```

## Arguments

| Argument | Required | Description |
|------|---------|-------|
| `mirror-id` | Yes | The ID of the mirror to check. <br/> The mirror ID must match a key defined in the `[mirrors]` section of your configuration file. |


## Flags

| Flag | Default | Usage |
|------|---------|-------|
| `--config`, `-c` | `/etc/mirrorctl/mirror.toml` | Path to the configuration file. |

## Output

```
$ mirrorctl check tls debian-trixie
Checking TLS status for mirror 'debian-trixie' (deb.debian.org:443)...

[+] TLS Version Support:
    TLS 1.0: Not Supported (remote error: tls: protocol version not supported)
    TLS 1.1: Not Supported (remote error: tls: protocol version not supported)
    TLS 1.2: Supported
    TLS 1.3: Supported

[+] Connection Details:
    Negotiated Version: TLS 1.3
    Negotiated Cipher:  TLS_AES_128_GCM_SHA256

[+] Server Certificate Chain:
    - Cert 0:
      Subject:  cdn-fastly.deb.debian.org
      Issuer:   R12
      Expires:  2025-12-12T00:56:07Z

    - Cert 1:
      Subject:  R12
      Issuer:   ISRG Root X1
      Expires:  2027-03-12T23:59:59Z

TLS check complete.
```

## Exit Status

The command exits with status `0` on success and `1` if the mirror is not found in the configuration.

## See Also

- [Configuration Reference]({{< relref "/docs/reference/configuration" >}}) - Details on TLS
  configuration
- [Environment Variables]({{< relref "/docs/reference/env-vars" >}}) - TLS-related environment
  variables
- [check config]({{< relref "/docs/reference/command/check/config" >}}) - Validate configuration
  file
- [sync]({{< relref "/docs/reference/command/sync" >}}) - Synchronize repositories
