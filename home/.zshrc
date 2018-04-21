
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

#plugins
plugins=(git)

# This stuff is for pure prompt
autoload -U promptinit; promptinit
prompt pure

# User configuration
prompt_context() {}

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# aliases
alias andagago="cd ~/Documents/Node/andaga"
alias rec="asciinema rec"
alias ssh='TERM=xterm-color ssh'
alias marktext="cd /usr/bin/ && ./marktext-0.10.21-x86_64.AppImage"

# path
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin"
