" custom leader
let mapleader = ","

" plugins
if filereadable(expand("~/.flavor/plugs"))
  source ~/.flavor/plugs
endif

" custom functions
if filereadable(expand("~/.flavor/vim.functions"))
  source ~/.flavor/vim.functions
endif

" plugin settings
if filereadable(expand("~/.flavor/plug.settings"))
  source ~/.flavor/plug.settings
endif

" langauge server client settings
if filereadable(expand("~/.flavor/coc.settings"))
  source ~/.flavor/coc.settings
endif

" color theming
if exists('sunny')
  set background=light
else
  set background=dark
endif

colorscheme gruvbox8_soft
set termguicolors

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

" tabs vs spaces!
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" make sure line endings are always unix
set ff=unix

set showtabline=1 " not fully sure I want this yet

" display options
set showmode
set showcmd
set cursorline
set number
set relativenumber
set conceallevel=0

" allows your update time to be a bit faster
set updatetime=300

set matchpairs+=<:>
set showmatch

" disables the automatic comment lines after another comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" enforce characters to be 80 or less in js
highlight ColorColumn ctermbg=lightgrey
autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)

" set status line display
set statusline=%n\   " buffer number
set statusline+=%t%m%r%h%w\  " file, modified, readonly
set statusline+=%{StatusDiagnostic()}
set statusline+=%=%{&ff}\  " right align line endings
set statusline+=%Y\  " filetype
set statusline+=%l,%v\ " curser position
set statusline+=%p%%\  " percentage on page
set laststatus=2

" search down into subfolders
" provides tab completion for file related tasks
set path+=**
filetype plugin on

" don't search git, node_modules, or targert with wildmenu
set wildignore=.git,*/node_modules/*,*/target/*

" encoding
set encoding=utf-8

" search settings
set incsearch
" include matching uppercase words with lowercase search term
set ignorecase
" include only uppercase words with uppercase search term
set smartcase

" while in vim just use xclipboard
set clipboard=unnamedplus

" escape
inoremap jj <ESC>

" toggle NERDTree open
nmap <leader>nt :NERDTree<cr>
" toggle highlight search off
nmap <leader>hs :nohlsearch<cr>
" format json
nmap <leader>js :%!jq '.'<cr>
" format xml
nmap <leader>xml :%!xmllint --format -<cr>

