---
title: Directory permissions
cascade:
  type: docs
---

### Issue

This article is relevant for you if you receive an error message similar to:

`time=2025-10-02T13:18:07.627-05:00 level=ERROR msg="mirror run failed" error="open /var/www/html/mirror-data/.lock: permission denied"`

#### What's happening

The mirrorctl application is trying to create a lock file in the mirror storage directory,
but it doesn't have the needed permissions to do so.

#### How to fix it

Two possible fixes are to either:

1. Grant needed directory permissions through ACLs, or
1. Create a dedicated account group for running `mirrorctl` operations.

You only need to choose one of the options.

#### Option 1: Grant directory permissions through ACLs (Access Control Lists)

One option is to use Access Control Lists (ACLs) to grant user permissions to the storage
directory. In the example below, the commands use ACL's to grant the `username` user access to
the `/var/www/html/mirror-data` directory.

```
sudo setfacl -m u:username:rwx /var/www/html/mirror-data
sudo setfacl -d -m u:username:rwx /var/www/html/mirror-data
```

#### Option 2: Create a dedicated group for 'mirrorctl'

Another option is to create  a `mirrorctl` group, and to grant permissions to the mirror storage
directory via group permissions. In the example below, replace the `username` value with the user
name of the user who will be running the `mirrorctl` application. 

```
sudo groupadd mirrorctl
sudo chgrp mirrorctl /var/www/html/mirror-data
sudo chmod 775 /var/www/html/mirror-data
sudo usermod -aG mirrorctl username
```
