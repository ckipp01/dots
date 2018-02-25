# Path to your oh-my-zsh installation.
export ZSH=/Users/ckipp01/.oh-my-zsh

# Theme settings
ZSH_THEME=""

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin"
