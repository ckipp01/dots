# ALIASES #
alias l='exa -la --icons'
alias ls='exa'
alias tree='exa -T'
alias grep='grep --color=auto'
alias weather='curl wttr.in/hague,netherlands'
alias v="nvim"
alias vl="nvim --cmd \"let g:light='true'\""
alias new-sbt='g8 scala/scala-seed.g8'
alias tmux='tmux -2'
alias 'tail-metals'='tail -f .metals/metals.log'
alias 'tail-lsp'='tail  -f /Users/ckipp/Library/Caches/org.scalameta.metals/lsp.trace.json'
alias 'tail-bsp'='tail  -f /Users/ckipp/Library/Caches/org.scalameta.metals/bsp.trace.json'
alias 'tail-dap-client'='tail  -f /Users/ckipp/Library/Caches/org.scalameta.metals/dap-client.trace.json'
alias 'tail-dap-server'='tail  -f /Users/ckipp/Library/Caches/org.scalameta.metals/dap-server.trace.json'
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

# Setting to change z to j #
set -U Z_CMD "j"

set N_PREFIX $HOME/n

# Ensure that nvim is set as the default editor
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

set -gx XDG_CONFIG_HOME $HOME/.config

# >>> JVM installed by coursier >>>
set -gx JAVA_HOME "/Users/ckipp/Library/Caches/Coursier/arc/https/github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%252B7/OpenJDK17U-jdk_aarch64_mac_hotspot_17.0.7_7.tar.gz/jdk-17.0.7+7/Contents/Home"
# <<< JVM installed by coursier <<<
