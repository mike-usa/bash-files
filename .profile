# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

## --------------------------------------------------
## Default settings from WSL install above
## Custom settings below
## --------------------------------------------------

# Add Linux Brew to Path
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Add Node Version Manager (NVM) per Brew Install Instructions
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Check if postgres is running
if [ ! "$(pgrep -fa -- -D | grep postgres)" ]; then 
  # Start Postgres Server (postgresql must be installed via homebrew/linuxbrew)
  pg_ctl -D $HOMEBREW_PREFIX/var/postgres start
fi
# To stop postgres:
#pg_ctl stop -D $HOMEBREW_PREFIX/var/postgres

# Update command line prompt for git
# export PS1="\[\033[95m\]\u@\h \[\033[32m\]\W\[\033[33m\] [\$(git symbolic-ref --short HEAD 2>/dev/null)]\[\033[00m\]\$ "
export PS1="\[\033[92m\]\u@\h\[\033[97m\]:\[\033[94m\]\w\[\033[33m\] [\$(git symbolic-ref --short HEAD 2>/dev/null)]\[\033[00m\]\$ "
##################################
# Color    | Code | High Intensity
# -------- | ---- | --------------
# Black    |  30  | 90
# Red      |  31  | 91
# Green    |  32  | 92
# Yellow   |  33  | 93
# Blue     |  34  | 94
# Magenta  |  35  | 95 (purple)
# Cyan     |  36  | 96
# White    |  37  | 97


# Start in the home directory
cd ~/
