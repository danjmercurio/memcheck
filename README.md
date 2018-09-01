# Memcheck dot sh

[![N|Solid](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)

### What's this for?
Memcheck.sh is a bash utility that warns when memory is getting low. For my current dev machine, a repurposed thin client with 4GB RAM running MX Linux live from a USB stick, this is really important because on each boot the system loads the root *"persistence file"* into ram, eating up 2GB+ before my desktop, wm, and browser are even launched. When new software is installed or files saved to /home, it uses rsync to overwrite the file, leading to slow but steady bloat and loss of userspace RAM.

Yeah, I need to buy a new laptop. But in the meantime, maybe others will find this useful too.

### Some details
  - gets memory info from free from GNU coreutils, which gets memory info from /proc virtual filesystem
  - Polls every 5 seconds by default
  - Requires libnotify and notify-send binary *(You probably already have this if you run Debian)*
  - Please don't make fun of me for using [code]while true[/code]

