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
if [ -f ~/.flavor/aliases ]; then
  source ~/.flavor/aliases
fi

# autojump
if [ -f ~/.autojump/etc/profile.d/autojump.sh ]; then
  source ~/.autojump/etc/profile.d/autojump.sh
else
  git clone git://github.com/wting/autojump.git ~/Software/autojump
  cd ~/Software/autojump && ./install.py
  source ~/.autojump/etc/profile.d/autojump.sh
fi

# some env stuff
if [ -f ~/.env ]; then
  source ~/.env
else
  echo "No .env file found."
fi

# bash completion
if [ -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
else
  echo "No bash_completion ccript found."
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

# export JAVA_HOME="/Users/ckipp/.sdkman/candidates/java/current"

# sdkman stuff
export SDKMAN_DIR="/home/ckipp/.sdkman"
[[ -s "/home/ckipp/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ckipp/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=/Users/ckipp/.local/share/fury/usr/active/bin:/Users/ckipp/.local/share/fury/usr/active/opt:$PATH # Added by Fury
