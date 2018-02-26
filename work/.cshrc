# $FreeBSD: src/share/skel/dot.cshrc,v 1.10.2.3 2001/08/01 17:15:46 obrien Exp $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
#

alias su su -
alias top	top -i
alias :q   'echo THIS IS NOT VIM DUMMY '
alias :w   'echo THIS IS NOT VIM DUMMY '
alias weather curl wttr.in/Minneapolis
alias tmux tmux -2
alias precmd "source ~/bin/gitscripts.csh"
alias sitemapper "/usr/local/bin/php .scheduled_tasks_run.php"
alias ... "cd ../.."

source ~/.git-completion.tcsh

# A righteous umask
umask 022

set path = (/sbin /bin /usr/sbin /usr/bin /usr/games/ /usr/local/sbin /usr/local/bin /usr/bin/core_perl/ $HOME/bin /usr/local/bin/indexer /usr/local/sbin/searchd)

setenv  EDITOR vim
setenv  PAGER less
setenv  BLOCKSIZE K

#LS colors - BSD
setenv	CLICOLOR yes
setenv LSCOLORS	'gafxcxdxbxegedabagacad'
#LS colors - Linux
setenv LS_COLORS 'di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

#set LANG / LOCALE
setenv LANG	"en_US.UTF-8"
setenv LC_ALL "en_US.UTF-8"
setenv MM_CHARSET "utf8"

setenv FTP_PASSIVE_MODE yes

#tcsh options
#no autologout
set autologout=0
#completes the command
set complete
#autocorrects the command and completes it
set correct=complete
#autolist possible completions
set autolist
#autoexpand from the history
set autoexpand
#only sets unique history items (erases old ones)
set histdup=erase
#sets the up arrow key to use history for commands
bindkey -k up history-search-backward
#no user tracking of lofins / logouts
unset watch

if ($?prompt) then
        # An interactive shell -- set some stuff up
        set filec
        set history = 100
        set savehist = 100
        set mail = (/var/mail/$USER)
endif

# Colors!
set     red="%{\033[1;31m%}"
set   green="%{\033[0;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     normal="%{\033[0m%}" # This is needed at the end... :(

# Cow-spoken fortunes every time you open a terminal
fortune | cowsay

# Clean up after ourselves...
unset red green yellow blue magenta cyan yellow white normal

