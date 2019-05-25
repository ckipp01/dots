# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# prompt file
if [ -f ~/.patatetoy/patatetoy.sh ]; then
  source ~/.patatetoy/patatetoy.sh
else
  git clone https://github.com/loliee/patatetoy.git "$HOME/.patatetoy"
  source ~/.patatetoy/patatetoy.sh
fi

# function file
if [ -f ~/.flavor/function.bash ]; then
  source ~/.flavor/function.bash
fi

# alias file
if [ -f ~/.flavor/alias.bash ]; then
  source ~/.flavor/alias.bash
fi

# autojump
if [ -f /usr/share/autojump/autojump.bash ]; then
  source /usr/share/autojump/autojump.bash
else
  sudo apt install autojump
  source /usr/share/autojump/autojump.bash
fi

# wakatime tracking
if [ -f ~/.flavor/bash-wakatime.sh ]; then
  source ~/.flavor/bash-wakatime.sh
fi

# some env stuff
if [ -f ~/.env ]; then
  source ~/.env
fi

# bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'


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


export PATH="$HOME/bin/:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# for usage with n and node jazz
export N_PREFIX=$HOME

# sdkman stuff
export SDKMAN_DIR="/home/ckipp/.sdkman"
[[ -s "/home/ckipp/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ckipp/.sdkman/bin/sdkman-init.sh"
