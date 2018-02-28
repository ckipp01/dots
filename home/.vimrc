"Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
   source ~/.vimrc.plug
endif

"Color scheme settings
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

"So that my colorschemes actually work in stupid putty
if &term =~ "xterm"
  "256 colors
  let &t_Co = 256
  "restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

"Airline theme
let g:airline_theme='gruvbox'

"Specific for ale
let g:airline#extensions#ale#enabled = 1

"Turn on syntax highlighting.
"There is logic in here to make sure you don't call sytax highlighting twich which will screw it up
if !exists("g:syntax_on")
  syntax enable
endif

"Turn off modelines
set modelines=0

"Don't wrap at screen end
set nowrap

"Tabs vs spations options
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noshiftround

"Make sure line endings are always unix
set ff=unix

"Display options
set showmode
set showcmd
set cursorline
set number

"Allows your update time to be a bit faster
set updatetime=250

"Basically allows your backspace to work as expected
set backspace=indent,eol,start

"Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>
set showmatch

"Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]
set laststatus=2

"Search down into subfolders
"Proives tab completion for file related tasks
set path+=**

"Visual autocomplete for command menu
set wildmenu

"Encoding
set encoding=utf-8

"Search settings
"Highlight matching search patterns
set hlsearch
"Enable incremental search
set incsearch
"Include matching uppercase words with lowercase search term
set ignorecase
"Include only uppercase words with uppercase search term
set smartcase

"Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

"Below are plug specific settings
"This sets where where notes will be stored
let g:notes_directories = ['~/notes']

"Specific indenting for scala
let g:scala_scaladoc_indent = 1

"Below are custom shortcuts/settings
let mapleader = ","

"Toggle NERDTree open
nmap <leader>nt :NERDTree<cr>
"Toggle tagbar open
nmap <leader>tb :TagbarToggle<CR>
