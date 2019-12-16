# THEME PURE #
set fish_function_path /Users/ckipp/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /Users/ckipp/.config/fish/functions/theme-pure/conf.d/pure.fish

# AUTOJUMP #
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# ALIASES #
source /Users/ckipp/.flavor/aliases
# ENV #
source /Users/ckipp/.config/fish/env.fish
# FUNCTIONS #
source /Users/ckipp/.config/fish/functions.fish

set PATH /Users/ckipp/bin $PATH

echo "Hello Chris"
fish_logo
