# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# prompt file
source ~/.patatetoy/patatetoy.sh
# function file
source ~/.flavor/function.bash
# alias file
source ~/.flavor/alias.bash
# autojump
source /usr/share/autojump/autojump.bash
# wakatime tracking
source ~/.flavor/bash-wakatime.sh

# run any necessary functions on startup
run_on_startup;

# history stuff
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# allow for my prompt history to all be accumulated from various open places
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# for setting history length
HISTSIZE=1000
HISTFILESIZE=2000

# checking and resizing of windowsize
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors &&\
    eval "$(dircolors -b ~/.dircolors)" ||\
    eval "$(dircolors -b)"
fi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'

# bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$PATH"

# for usage with n and node jazz
export N_PREFIX=$HOME

# sdkman stuff
export SDKMAN_DIR="/home/ckipp/.sdkman"
[[ -s "/home/ckipp/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ckipp/.sdkman/bin/sdkman-init.sh"
