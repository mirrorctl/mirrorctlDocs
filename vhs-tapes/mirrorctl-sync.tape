# VHS tape file for mirrorctl sync demo

# Output settings
Output static/mirrorctl-sync.gif

# Set up terminal
Set FontSize 16
Set Width 1200
Set Height 600
Set Theme "Catppuccin Mocha"

#Set log level to error


# Type and execute the command
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
