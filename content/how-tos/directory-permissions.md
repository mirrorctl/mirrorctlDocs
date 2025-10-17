---
title: Directory permissions
cascade:
  type: docs
---

### Issue

This article is relevant for you if you receive an error message containing:

`level=ERROR msg="mirror run failed" error="open /var/www/apt/.lock: permission denied"`

#### What's happening

The mirrorctl application is trying to create a lock file in the mirror storage directory,
but it doesn't have the permissions to do so.

#### How to fix it

Two possible fixes are to either:

1. Grant needed directory permissions through ACLs, or
1. Create a dedicated account group for running `mirrorctl` operations.

You only need to choose one of the options.

#### Option 1: Grant directory permissions through ACLs (Access Control Lists)

One option is to use Access Control Lists (ACLs) to grant user permissions to the storage
directory. In the example below, the commands use ACL's to grant the `username` user access to
the `/var/www/apt/` directory.

```
sudo setfacl -m u:username:rwx /var/www/apt/
sudo setfacl -d -m u:username:rwx /var/www/apt/
```

#### Option 2: Create a dedicated group for 'mirrorctl'

Another option is to create  a `mirrorctl` group, and to grant permissions to the mirror storage
directory via group permissions. In the example below, replace the `username` value with the user
name of the user who will be running the `mirrorctl` application. 

```
sudo groupadd mirrorctl
sudo chgrp mirrorctl /var/www/apt/
sudo chmod 775 /var/www/apt/
sudo usermod -aG mirrorctl username
```
