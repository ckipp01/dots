# ALIASES #
source /Users/ckipp/.flavor/aliases
# ENV #
source /Users/ckipp/.config/fish/env.fish
# FUNCTIONS #
source /Users/ckipp/.config/fish/functions.fish

set PATH /Users/ckipp/.local/bin /Users/ckipp/bin /Users/ckipp/Library/Application\ Support/Coursier/bin /Users/ckipp/.sdkman/candidates/sbt/current/bin /Users/ckipp/.local/share/fury/usr/active/bin /Users/ckipp/.local/share/fury/usr/active/opt /Users/ckipp/Applications/Racket-v7.9/bin $PATH

# Setting to change z to j #
set -U Z_CMD "j"

set N_PREFIX $HOME/n

# Ensure that nvim is set as the default editor
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/ckipp/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/ckipp/.ghcup/bin $PATH
