# ALIASES #
alias l='eza -la --icons'
alias ls='eza'
alias tree='eza -T'
alias grep='grep --color=auto'
alias weather='curl wttr.in/hague,netherlands'
alias v="nvim"
alias vl="nvim --cmd \"let g:light='true'\""
alias new-sbt='g8 scala/scala-seed.g8'
alias tmux='tmux -2'
alias 'tail-metals'='tail -f .metals/metals.log'
alias gfu='git fetch upstream'
alias gp='git push'
alias gmum='git merge upstream/main'
alias cleanBloop="rm -rf /Users/ckipp/.ivy2/local/ch.epfl.scala/sbt-bloop/ && rm -rf ./.bloop/"
alias bat="bat --theme='TwoDark'"
alias scli="scala-cli"
alias 'scala3-nightly-repl'='scli repl --scala 3.nightly'
alias 'scala2-repl'='cs launch scala:2.13.10'
alias diff="delta"

# FUNCTIONS #
source /Users/ckipp/.config/fish/functions.fish

set PATH /Users/ckipp/.local/bin \
   /Users/ckipp/bin \
   /Users/ckipp/Library/Application\ Support/Coursier/bin\
   /Users/ckipp/.cargo/bin \
   /usr/local/opt/gnu-sed/libexec/gnubin \
   /Users/ckipp/go/bin $PATH

# Ensure that nvim is set as the default editor
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

set -gx XDG_CONFIG_HOME $HOME/.config





# >>> JVM installed by coursier >>>
set -gx JAVA_HOME "/Users/ckipp/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20%252B8/OpenJDK11U-jdk_aarch64_mac_hotspot_11.0.20_8.tar.gz/jdk-11.0.20+8/Contents/Home"
# <<< JVM installed by coursier <<<

zoxide init fish --cmd j | source
