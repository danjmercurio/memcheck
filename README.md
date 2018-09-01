# Memcheck dot sh

[![N|Solid](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)

### What's this for?
Memcheck.sh is a bash utility that warns when memory is getting low. For my current dev machine, a repurposed thin client with 4GB RAM running MX Linux live from a 32GB USB stick, this is really important because on each boot the system loads the root *"persistence file"* into ram, eating up 2GB+ before my desktop, wm, and browser are even launched. When new software is installed or files saved to `/home/*`, it uses rsync to overwrite the file before shutting down, leading to a slow but steady increase of this file's size and gradual loss of userspace RAM. Since I have nowhere to put a swapfile, running out of RAM just freezes Xfce.

Yeah, I need to buy a new laptop. But in the meantime, maybe others will find this useful too.

### Some details
  - Gets memory info from free from GNU coreutils, which gets memory info from /proc virtual filesystem
  - Polls every 5 seconds by default
  - Requires libnotify and notify-send binary *(You probably already have this if you run Debian)*
  - Feel free to ridicule me for using `while true`
  
### What was the original version like, and where can I find it?
It included provisions to email the user instead of using `libnotify`. Although this is a good approach I perfer to receive desktop notifications which I am much more likely to notice.

The original is here: https://www.tecmint.com/shell-script-to-send-email-alert-when-memory-low/

### Can I change any of the options?
Yes, you can reconfigure the following options by cloning the repo and substituting your own values where I have defined the defaults
  - `MEMORY_CRITICAL_LIMIT=100` Default: **100mb**
  - `MEMORY_LOW_LIMIT=300` Default: **300mb**
  - `CHECK_INTERVAL='5s'` Default: **Check memory levels every 5 seconds.**
  
  Protip: Run `man sleep` for details on all possible values run sleep --help or read the documentation from GNU coreutils at http://www.gnu.org/software/coreutils/sleep

### Possible future changes
  - Support for setting/loading config from environment variables
  - Zsh support


