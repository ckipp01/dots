if filereadable(expand("~/.flavor/vimrc.plug"))
  source ~/.flavor/vimrc.plug
endif

if filereadable(expand("~/.flavor/plug.settings"))
  source ~/.flavor/plug.settings
endif

" Color scheme settings
colorscheme onedark 

" Turn on syntax highlighting.
if !exists("g:syntax_on")
  syntax enable
endif

" Allow for urls with query strings to be opened with the query string
let g:netrw_gx="<cWORD>"

" Turn off modelines
set modelines=0

" Don't wrap at screen end
set nowrap

" Tabs vs spations options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Make sure line endings are always unix
set ff=unix

" Display options
set showmode
set showcmd
set cursorline
set number

" Allows your update time to be a bit faster
set updatetime=250

" Basically allows your backspace to work as expected
set backspace=indent,eol,start

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>
set showmatch

" Disables the automatic comment lines after another comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]
set laststatus=2

" Search down into subfolders
" Provides tab completion for file related tasks
set path+=**
filetype plugin on

" Visual autocomplete for command menu
set wildmenu
set wildignore=.git,*/node_modules/*,*/target/*

" Encoding
set encoding=utf-8

" Search settings
" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data.
set viminfo='100,<9999,s100

" While in vim just use the xclipbard
set clipboard=unnamedplus

" Below are custom shortcuts/settings
inoremap jj <ESC>
let mapleader = ","

" Toggle NERDTree open
nmap <leader>nt :NERDTree<cr>
" Toggle highlight search off
nmap <leader>hs :nohlsearch<cr>
