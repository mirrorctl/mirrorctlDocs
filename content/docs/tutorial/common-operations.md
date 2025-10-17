---
title: Common Operations
weight: 6
---

This section covers day-to-day mirror management tasks you'll perform regularly: scheduling automated syncs, managing snapshots, monitoring mirror health, and troubleshooting common issues.

## Scheduling Automatic Syncs

Mirrors need regular updates to stay current. Use cron to schedule automated syncs.

### Using Cron

Create a cron job to sync daily at 2 AM:

```bash
sudo crontab -e
```

Add the following line:

```
0 2 * * * /usr/local/bin/mirrorctl sync >> /var/log/mirrorctl/sync.log 2>&1
```

This runs `mirrorctl sync` daily at 2:00 AM and logs output to `/var/log/mirrorctl/sync.log`.

Create the log directory:

```bash
sudo mkdir -p /var/log/mirrorctl
```

### Different Sync Schedules for Different Mirrors

You can sync mirrors on different schedules:

```bash
# Sync security updates every 4 hours (critical)
0 */4 * * * /usr/local/bin/mirrorctl sync ubuntu-security >> /var/log/mirrorctl/security.log 2>&1

# Sync main repository daily at 2 AM
0 2 * * * /usr/local/bin/mirrorctl sync ubuntu >> /var/log/mirrorctl/ubuntu.log 2>&1

# Sync development repository weekly on Sunday at 3 AM
0 3 * * 0 /usr/local/bin/mirrorctl sync ubuntu-proposed >> /var/log/mirrorctl/proposed.log 2>&1
```

This prioritizes security updates while reducing bandwidth usage for less critical mirrors.

### Using Systemd Timers

For systemd-based systems, create a timer for more control:

Create `/etc/systemd/system/mirrorctl-sync.service`:

```ini
[Unit]
Description=Mirrorctl Repository Sync
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/mirrorctl sync
StandardOutput=journal
StandardError=journal
```

Create `/etc/systemd/system/mirrorctl-sync.timer`:

```ini
[Unit]
Description=Run mirrorctl sync daily
Requires=mirrorctl-sync.service

[Timer]
OnCalendar=daily
OnCalendar=02:00
Persistent=true

[Install]
WantedBy=timers.target
```

Enable and start the timer:

```bash
sudo systemctl daemon-reload
sudo systemctl enable mirrorctl-sync.timer
sudo systemctl start mirrorctl-sync.timer
```

Check timer status:

```bash
sudo systemctl status mirrorctl-sync.timer
sudo systemctl list-timers mirrorctl-sync.timer
```

View sync logs:

```bash
sudo journalctl -u mirrorctl-sync.service -f
```

## Managing Snapshots

### List All Snapshots

View snapshots for a specific mirror:

```bash
mirrorctl snapshot list ubuntu-noble
```

View all snapshots for all mirrors:

```bash
mirrorctl snapshot list
```

### Create Manual Snapshots

Create a snapshot before making configuration changes:

```bash
mirrorctl snapshot create ubuntu-noble "before-config-change"
```

Create a snapshot of all mirrors:

```bash
for mirror in ubuntu ubuntu-security ubuntu-updates; do
  mirrorctl snapshot create "$mirror" "2025-q1-baseline"
done
```

### Prune Old Snapshots

Manually apply retention policy:

```bash
mirrorctl snapshot prune ubuntu-noble
```

Prune all mirrors:

```bash
for mirror in ubuntu ubuntu-security ubuntu-updates; do
  mirrorctl snapshot prune "$mirror"
done
```

### Delete Specific Snapshots

Remove a specific snapshot:

```bash
mirrorctl snapshot delete ubuntu-noble "2025-10-01T09-30-00Z"
```

{{% callout type="warning" %}}
Deleted snapshots cannot be recovered. Verify you're deleting the correct snapshot before confirming.
{{% /callout %}}

## Monitoring Mirror Health

### Check Sync Status

After a scheduled sync, verify it succeeded:

```bash
# For cron jobs
tail -50 /var/log/mirrorctl/sync.log

# For systemd
sudo journalctl -u mirrorctl-sync.service --since "today"
```

Look for:
- `Sync completed successfully` messages
- PGP signature verification success
- No error or warning messages

### Monitor Disk Space

Repository mirrors consume significant disk space. Monitor regularly:

```bash
# Check mirror disk usage
du -sh /var/www/apt/*

# Check snapshot disk usage
du -sh /var/lib/mirrorctl/snapshots/*/*

# Check available space
df -h /var/www/apt/
```

Set up automated alerts when disk usage exceeds 80%:

```bash
#!/bin/bash
# Save as /usr/local/bin/check-mirror-disk.sh

THRESHOLD=80
USAGE=$(df /var/www/apt/ | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "WARNING: Mirror disk usage at ${USAGE}%" | \
    mail -s "Mirror Disk Space Alert" admin@example.com
fi
```

Schedule it in cron:

```
0 */6 * * * /usr/local/bin/check-mirror-disk.sh
```

### Monitor Sync Timing

Track how long syncs take:

```bash
# View sync duration from logs
grep "Duration:" /var/log/mirrorctl/sync.log | tail -5
```

Increasing sync times may indicate:
- Growing repository size
- Network bandwidth issues
- Disk I/O problems

### Verify Mirror Integrity

Periodically verify your mirror serves correct content:

```bash
# Test Release file accessibility
curl -I http://your-mirror-server/ubuntu-noble/current/dists/noble/Release

# Verify Release file signature (if you have the key)
gpg --verify \
  /var/www/apt/ubuntu-noble/current/dists/noble/Release.gpg \
  /var/www/apt/ubuntu-noble/current/dists/noble/Release

# Test package download
apt download --print-uris curl | grep http://your-mirror-server
```

## Troubleshooting Common Issues

### Sync Failures

If syncs fail, check:

1. **Network connectivity**:
   ```bash
   curl -I https://archive.ubuntu.com/ubuntu/
   ```

2. **DNS resolution**:
   ```bash
   nslookup archive.ubuntu.com
   ```

3. **Disk space**:
   ```bash
   df -h /var/www/apt/
   ```

4. **Configuration validity**:
   ```bash
   mirrorctl check config
   ```

5. **Detailed error output**:
   ```bash
   sudo mirrorctl sync --verbose-errors
   ```

### PGP Verification Failures

If PGP verification fails:

1. **Verify key file exists**:
   ```bash
   ls -l /etc/mirrorctl/keys/ubuntu-archive-keyring.gpg
   ```

2. **Check key fingerprint**:
   ```bash
   gpg --show-keys /etc/mirrorctl/keys/ubuntu-archive-keyring.gpg
   ```

3. **Test manual verification**:
   ```bash
   gpg --verify \
     /var/www/apt/ubuntu-noble/dists/noble/Release.gpg \
     /var/www/apt/ubuntu-noble/dists/noble/Release
   ```

4. **Update signing keys** (keys change periodically):
   ```bash
   sudo gpg --keyserver keyserver.ubuntu.com \
            --recv-keys 0x871920D1991BC93C \
            --export > /etc/mirrorctl/keys/ubuntu-archive-keyring.gpg
   ```

### Slow Syncs

If syncs are taking too long:

1. **Use a closer upstream mirror**: Change `url` to a geographically closer mirror
2. **Check network bandwidth**: `iftop` or `nload` during sync
3. **Reduce mirror scope**: Fewer architectures/sections if possible
4. **Check disk I/O**: `iostat -x 5` during sync
5. **Consider parallel downloads**: Future mirrorctl feature

### Disk Space Issues

If you're running out of space:

1. **Prune old snapshots**:
   ```bash
   mirrorctl snapshot prune --keep-last 3 ubuntu-noble
   ```

2. **Reduce `keep_last` in config**:
   ```toml
   [snapshot.prune]
   keep_last = 3  # Reduced from 5
   ```

3. **Use package filters**:
   ```toml
   [mirrors.ubuntu-noble.filters]
   keep_versions = 2
   exclude_patterns = [".*-dbg$", ".*-doc$"]
   ```

4. **Remove unnecessary architectures/sections**:
   ```toml
   architectures = ["amd64"]  # Remove arm64 if not needed
   sections = ["main"]         # Remove universe if not needed
   ```

### Corrupted Mirror State

If the mirror state becomes corrupted:

1. **Run a fresh sync**:
   ```bash
   sudo mirrorctl sync ubuntu-noble
   ```
   mirrorctl will detect and re-download corrupted files.

2. **Restore from snapshot**:
   ```bash
   # List snapshots to find a good one
   mirrorctl snapshot list ubuntu-noble

   # Publish the good snapshot to production
   mirrorctl snapshot publish ubuntu-noble "2025-10-14T09-30-00Z"
   ```

3. **In extreme cases, re-create the mirror**:
   ```bash
   # Backup config
   sudo cp /etc/mirrorctl/mirror.toml /etc/mirrorctl/mirror.toml.backup

   # Remove corrupted mirror
   sudo rm -rf /var/www/apt/ubuntu-noble

   # Resync
   sudo mirrorctl sync ubuntu-noble
   ```

## Updating Configuration

When updating mirror configuration:

1. **Test configuration validity**:
   ```bash
   sudo mirrorctl check config
   ```

2. **Create a snapshot first** (if config changes might affect content):
   ```bash
   mirrorctl snapshot create ubuntu-noble "before-config-update"
   ```

3. **Test with dry-run**:
   ```bash
   sudo mirrorctl sync --dry-run
   ```

4. **Apply the change**:
   ```bash
   sudo mirrorctl sync
   ```

5. **Verify the update**:
   ```bash
   mirrorctl snapshot list ubuntu-noble
   ls -la /var/www/apt/ubuntu-noble/
   ```

## Log Management

Over time, logs can consume significant space. Rotate them:

Create `/etc/logrotate.d/mirrorctl`:

```
/var/log/mirrorctl/*.log {
    daily
    rotate 14
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root root
}
```

Test logrotate:

```bash
sudo logrotate -d /etc/logrotate.d/mirrorctl
sudo logrotate -f /etc/logrotate.d/mirrorctl
```

## Monitoring with Systemd

If using systemd timers, monitor with:

```bash
# Check last sync status
sudo systemctl status mirrorctl-sync.service

# View recent logs
sudo journalctl -u mirrorctl-sync.service -n 50

# Follow logs in real-time
sudo journalctl -u mirrorctl-sync.service -f

# Check timer schedule
sudo systemctl list-timers mirrorctl-sync.timer
```

## Performance Tips

1. **Schedule syncs during off-peak hours** to reduce impact on network
2. **Use local/nearby upstream mirrors** to reduce latency
3. **Monitor and tune snapshot retention** to balance safety and disk usage
4. **Use SSD storage** for better I/O performance during syncs
5. **Ensure sufficient RAM** for caching during large syncs

## What's Next?

You've learned the essential operations for managing mirrorctl. Check out [Next Steps]({{< relref "next-steps" >}}) to explore advanced topics and additional resources.
