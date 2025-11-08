# VHS tape file for mirrorctl sync demo

# Output settings
Output static/mirrorctl-sync.gif

# Set up terminal
Set FontSize 18 
Set Width 1200
Set Height 600
Set Theme "Espresso"
Set WindowBar ColorfulRight

Hide
Type "find /var/www/apt/ -mindepth 1 -delete"
Enter
Type "clear"
Enter
Show

Type@100ms "mirrorctl sync --dry-run"
Sleep 1
Enter
Sleep 10
Screenshot assets/images/dry-run.png

Type@50ms "clear"
Sleep 1
Enter
Sleep 2

Type@100ms "mirrorctl sync"
Sleep 1
Enter

# Wait for command to complete
Sleep 15s
Screenshot assets/images/sync.png
