 "Call the .vimrc.plug file
if filereadable(expand("~/.flavor/vimrc.plug"))
  source ~/.flavor/vimrc.plug
endif

"Color scheme settings
let g:seoul256_background=234
colorscheme seoul256 
let g:enable_bold_font=1
let g:enable_italic_font=1

"lightline settings
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

"Turn on syntax highlighting.
if !exists("g:syntax_on")
  syntax enable
endif

"Allow for urls with query strings to be opened with the query string
let g:netrw_gx="<cWORD>"

"Turn off modelines
set modelines=0

"Don't wrap at screen end
set nowrap

"Tabs vs spations options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
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
"Provides tab completion for file related tasks
set path+=**
filetype plugin on

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

"Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data.
set viminfo='100,<9999,s100

"While in vim just use the xclipbard
set clipboard=unnamedplus

"Ale settings
let g:ale_completion_enabled=1

"Settings for notes
"This sets where where notes will be stored
let g:notes_directories = ['~/notes']
let g:notes_suffix = '.md'
let g:notes_unicode_enabled = 0
let g:notes_conceal_url = 0
"Turn on Goyo specifcally for txt files
au BufReadPost,BufNewFile *.md :Goyo 90%
au BufReadPost,BufNewFile *.md set wrap linebreak nolist spell spelllang=en_us complete+=kspell

"Below are custom shortcuts/settings
let mapleader = ","

"Toggle NERDTree open
nmap <leader>nt :NERDTree<cr>
"Toggle highlight search off
nmap <leader>hs :nohlsearch<cr>
