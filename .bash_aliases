# file: ./.bash_aliases
# author: @_mikeusa / github: mike-usa

# Syntax Notes
# - 'function' keyword is necessary to not break OSX when overriding utilities
# - 

bind '"^[[A":history-search-backward'
bind '"^[[B":history-search-forward'


alias lla='ls -la'
alias go='cd'
alias prev='cd -'
alias md='mkdir'
alias up='cd ..'
alias home='cd ~/'
alias cls='clear'
function e() { emacs $@ & }
alias subl='sublime'
alias settings='$EDITOR ~/.bash_aliases'
alias refresh='source ~/.bashrc'

# Hidden Files (dotfiles); hidden-all, hidden directories, hidden files
function ha () { ls -lap               | grep -P "\s\." "$@" ; }
function hd () { ls -lap | grep \/$    | grep -P "\s\." "$@" ; }
function hf () { ls -lap | grep -v \/$ | grep -P "\s\." "$@" ; }



# View markdown in terminal; requires pandoc + lynx installed
function mdn () {
  pandoc "$@" | lynx -stdin
}
#######################################################################

# Display aliases and function defs
function a() {
  # display aliases
  alias ;
  
  # display functions; requires grep v3.x or later installed
  declare -F | grep -vP " - fx? _" ;

  # to look up a specific function use command 'type':
  # Example: type <function name>
}

# Wrapper around 'tree' utility
function tree () {
  # -A: ansi line graphics (fixes charset issues)
  # -C: always-on color (no way to override)
  # EXAMPLE: command tree -AC "#@" ;
  ## --------------------------------------------
  # https://superuser.com/a/378126/959327
  # According to answer:
  #  - $LC_ALL overrides all other locale settings
  #  - -A option forces VT100 graphics

  # track default options (removed by supplying as an arg to tree)
  local option=( C p )
  local args=("$@")

  # Iterate over default options and 
  #  check if they are in supplied options
  #  if they are, remove them from the supplied
  #  and default (to overwrite default inclusion)
  local options
  local opt_ndx
  local i
  for opt_ndx in "${!option[@]}"; do
    local opt=${option[$opt_ndx]}
    local found=false

    for i in "${!args[@]}"; do
      if [[ ${args[i]} = "-$opt" ]]; then
        found=true
        unset 'args[i]'
      fi
    done
  done

  # Squish the option values together (join_by function defined below)
  option=$(join_by '' "${option[@]}")

  # Call command with default options if set
  command tree -$option "${args[@]}"
}

# join_by is used in tree
function join_by { local IFS="$1"; shift; echo "$*"; }

# Tar Directory
function tard () {
  NAME=${@: -1}        # last argument (target directory)

  if [ ! -d $NAME ]; then
    echo "$NAME is not a directory"
    unset NAME
    return;
  fi

  NAME=${NAME%/}       # strip trailing slash
  OPTIONS=${@: 1:$#-1} # everything but the last option (target)
  if [ ! -f $NAME.tar.gz ]; then
    tar -czvf $OPTIONS $NAME.tar.gz ${@: -1} --remove-files ;
  fi

  # Cleanup
  unset NAME
  unset OPTIONS
}
# Untar
function untar () {
  # expects a gzipped tar file
  NAME=${1%.tar.gz} ;

  # Do not need --xform (was creating two directories)
  # tar -xzvf $@ --xform="s|^|$NAME/|S"
  if tar -xzvf $@
  then
    rm $1
  fi

  # Cleanup
  unset NAME
}

# Colorize Grep
function grep () {
  # linuxbrew/homebrew installs 'ggrep'; an updated version of grep (3.x or later)
  # is required, since OSX comes with grep v2.x, which doesn't include perl regex 
  # matching

  # TODO: check if ggrep exists before using
  if ! command -v ggrep &> /dev/null
  then
    command grep --color=auto "$@"
  else
    command ggrep --color=auto "$@"
  fi
}

# Start/Stop Postgres and Check if server is running
alias pgstart='pg_ctl -D $HOMEBREW_PREFIX/var/postgres start'
alias pgstop='pg_ctl stop -D $HOMEBREW_PREFIX/var/postgres'
alias pgcheck='[ "$(pgrep -fa -- -D | grep postgres)" ] && echo "Postgres started" || echo "Postgres stopped"'

function dotdiff () {
  diff ~/Projects/github/bash-files ~/. --suppress-common-lines --color=always -y "$@" | grep -v -P "Only in [/.]"
}

#######################################################################

# MS-DOS Prompt/Command Line Conversions
alias cls='clear'
alias clr='clear'
alias copy='cp -i'
alias del='rm -i'
alias delete='rm -i'
alias home='cd ~'
alias md='mkdir'
alias move='mv -i'
########################################



alias +w='chmod +w'
alias +x='chmod +x'
alias ad='cd; a > a; . ~/.bash_profile; a > b; diff a b'
alias ag='alias | grep -i'
alias asp='system_profiler'
alias cba='cat ~/.bash_aliases'
alias cp='cp -i'
alias cpr='cp -R'
alias cw='echo "----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8"'
alias dfh='df -h'
alias dush='sudo du -sh'
alias eject='drutil eject'
alias ejectm='sudo umount -f'
alias envg='env | grep'
alias eth='ifconfig -a'
alias f='finger'

# Git Shortcuts
alias amend='git commit --amend'
alias ga='git add'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gcl='git config --list'
alias gcm1='git commit -m'
alias gcn='git clean -n -d'
alias gco='git checkout'
alias gd='git diff -U0'
alias geth='ifconfig -a | grep -1 eth'
alias gmv='git mv'
alias grm='git rm'
alias gs='git status'
alias gsm='gs | more'
alias pull='git pull'
alias push='git push'
###############


alias h='history'
alias hc='h | cut -c8-'
alias hg='h | grep -v grep | grep -i'
alias k='sudo kill -9'


# ls wrappers
alias l='ls -alFG'
alias l.='ls -d .*'
alias la='l [A-Za-z]*'
alias lb='lh | grep "[0-9][MG] "'
alias ld='l | grep /$'
alias le='ls -le'
alias lg='lt | grep'
alias lh='l -h'
alias ll='ls -l'
alias ls='/bin/ls --color -G'
alias lst='last -10'
alias lt='l -tr'
alias lvl='lt /var/log'
alias lx='lg "*"'
alias lz='l | sort -n -k5'
#############


alias mq='mailq'
alias msd='mysqldump'
alias mv='mv -i'
alias ns='netstat'
alias p='ping -c4 -t4 -o'
alias pbc='arp -a | grep ^bc | sort'
alias pp='pull; push'
alias psa='ps -Ajeww'
alias psg='psa | grep -v grep | grep -i'
alias rmd='sudo rm -rf'
alias sci='~/bin/ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias se='export TERM=vt102'
alias src='. ~/.bash_aliases'
alias st='sudo bash'
alias sue='sudo vi'
alias swu='sudo softwareupdate -l'
alias sync='rsync -pruv'
alias tf='tail -f'
alias tgz='tar gcvf'
alias tl='tail -20'
alias trt='traceroute'
alias untgz='tar xvf'
alias ut='uptime'
alias updatedb='sudo /usr/libexec/locate.updatedb'
