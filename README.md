# Memcheck dot sh

[![N|Solid](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)](https://github.com/odb/official-bash-logo/raw/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)

### What's this for?
Memcheck.sh is a bash utility that warns when memory is getting low. It is written for a project laptop I bought for cheap, a repurposed thin client with 4GB RAM and a *2GB hard drive* (!!) running MX Linux (Debian 9) booting from a 32GB SanDisk liveusb with MX's root persistence mode enabled. This allows a user to save files and software across live Linux sessions. Keeping tabs on available memory is really important because on each boot the system loads the root *"persistence file"* into ram, eating up ~2GB before the desktop, wm, and web browser are even loaded. When new software is installed or files saved to `/home/*`, it uses rsync to overwrite the file before shutting down, leading to a slow but steady increase of this file's size and gradual loss of userspace RAM. Since I have nowhere to put a swapfile, running out of RAM just freezes Xfce.

#### Why don't you just save the persistence file to the USB Drive, with its 32GB of storage?
Having flashed the ISO image of the Linux installation media to the drive using `dd`, the drive now only reports having a capacity equal to the size of the original ISO file. I suspect that this is a side effect of disk imaging, because even the venerable `GParted` reports something similar, or way off depending on its config. If anybody knows anything about this, I'm all ears. Is it possible to expand the disk image of the installation media with free space to take up the whole drive? I want to experiment with this but I only own one flash drive right now, so if I mess up the live USB I won't be able to boot anything, period.

#### Why don't you install an ultralight distro, like DamnSmallLinux?
I love DSL dearly and it was my go-to remedy, but I cannot get my laptop to boot it. It doesn't recognize this distro, while others work fine.

**Yeah, I need to buy a new laptop. But in the meantime, maybe others will find this useful too.**

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


