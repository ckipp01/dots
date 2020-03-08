# ALIASES #
source /Users/ckipp/.flavor/aliases
# ENV #
source /Users/ckipp/.config/fish/env.fish
# FUNCTIONS #
source /Users/ckipp/.config/fish/functions.fish

set PATH /Users/ckipp/bin /Users/ckipp/Library/Application\ Support/Coursier/bin $PATH

# Setting to change z to j #
set -U Z_CMD "j"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ckipp/google-cloud-sdk/path.fish.inc' ]; . '/Users/ckipp/google-cloud-sdk/path.fish.inc'; end
set -g fish_user_paths "/usr/local/opt/thrift@0.9/bin" $fish_user_paths
