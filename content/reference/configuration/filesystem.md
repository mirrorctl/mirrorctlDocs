---
title: Tutorial
weight: 2
cascade:
  type: docs
---

### mirrorctl filesystem overview

This article provides a graphical display of where different `mirrorctl` components could sit on
the filesystem.

These are recommended paths, but you may use alternate locations depending on your needs.

#### 1. Installation location

A typical `mirrorctl` binary installation would go into `/usr/local/bin/mirrorctl`.

{{< filetree/container >}}
  {{< filetree/folder name="/usr" >}}
    {{< filetree/folder name="local" >}}
      {{< filetree/folder name="bin" >}}
        {{< filetree/file name="mirrorctl" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

#### 2. Configuration file locations

The recommended configuration file location is under an `/etc/mirrorctl/` directory.

- The default configuration file location is: `/etc/mirrorctl/config.toml`
- The recommended storage location for repository PGP public keys is: `/etc/mirrorctl/keys/`.

You will need to create the appropriate directories, and can do so with the command:
`sudo mkdir -p /etc/mirrorctl/keys`.

{{< filetree/container >}}
  {{< filetree/folder name="/etc" >}}
    {{< filetree/folder name="mirrorctl" >}}
          {{< filetree/file name="config.toml" >}}
      {{< filetree/folder name="keys" >}}
          {{< filetree/file name="debian-repo-key.gpg" >}}
          {{< filetree/file name="ubuntu-repo-key.gpg" >}}
          {{< filetree/file name="vendor-repo-key.asc" >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

#### 3. Data storage locations

{{< filetree/container >}}
  {{< filetree/folder name="/var" >}}
    {{< filetree/folder name="www" >}}
      {{< filetree/folder name="html" >}}
        {{< filetree/folder name="debian-trixie" state="closed"  >}}
          {{< filetree/folder name="dists" state="closed"  >}}
          {{< /filetree/folder >}}
          {{< filetree/folder name="pool" state="closed" >}}
          {{< /filetree/folder >}}
        {{< /filetree/folder >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}