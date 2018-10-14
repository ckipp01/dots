if filereadable(expand("~/.flavor/vimrc.plug"))
  source ~/.flavor/vimrc.plug
endif

if filereadable(expand("~/.flavor/plug.settings"))
  source ~/.flavor/plug.settings
endif

" color scheme settings
set background=dark
colorscheme gruvbox

" turn on syntax highlighting.
if !exists("g:syntax_on")
  syntax enable
endif

" allow for urls with query strings to be opened with the query string
let g:netrw_gx="<cWORD>"

" turn off modelines
set modelines=0

" don't wrap at screen end
set nowrap

" tabs vs spations options
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" make sure line endings are always unix
set ff=unix

" display options
set showmode
set showcmd
set cursorline
set number
set noshowmode
set conceallevel=0

" allows your update time to be a bit faster
set updatetime=250

" basically allows your backspace to work as expected
set backspace=indent,eol,start

" annoying red to make sure I don't go over 80 wide
highlight OverLength ctermbg=1 ctermfg=white
match OverLength /\%81v.\+/

" highlight matching pairs of brackets
" use the '%' character to jump between them
set matchpairs+=<:>
set showmatch

" disables the automatic comment lines after another comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]
set laststatus=2

" search down into subfolders
" provides tab completion for file related tasks
set path+=**
filetype plugin on

" visual autocomplete for command menu
set wildmenu
set wildignore=.git,*/node_modules/*,*/target/*

" encoding
set encoding=utf-8

" search settings
" highlight matching search patterns
set hlsearch
" enable incremental search
set incsearch
" include matching uppercase words with lowercase search term
set ignorecase
" include only uppercase words with uppercase search term
set smartcase

" store info from no more than 100 files at a time
" 9999 lines of text, 100kb of data.
set viminfo='100,<9999,s100

" while in vim just use the xclipbard
set clipboard=unnamedplus

" below are custom shortcuts/settings
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" escape
inoremap jj <ESC>
let mapleader = ","

" toggle NERDTree open
nmap <leader>nt :NERDTree<cr>
" toggle highlight search off
nmap <leader>hs :nohlsearch<cr>
" format json
nmap <leader>js :%!jq '.'<cr>
