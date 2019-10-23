" custom leader
let mapleader = ","

" TODO look into native plugin managment instead of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
if filereadable(expand("~/.flavor/plugs"))
  source ~/.flavor/plugs
endif

" plugin settings
if filereadable(expand("~/.flavor/plug.settings"))
  source ~/.flavor/plug.settings
endif

" langauge server client settings
if filereadable(expand("~/.flavor/coc.settings"))
  source ~/.flavor/coc.settings
endif

"set termguicolors     " enable true colors support
colorscheme nord

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
set conceallevel=0

" allows your update time to be a bit faster
set updatetime=300

set matchpairs+=<:>
set showmatch

" autoclose certain pairs -- no need for a plugin to do this
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

set completeopt-=preview
" disables the automatic comment lines after another comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" enforce characters to be 80 or less in js
highlight ColorColumn ctermbg=lightgrey
autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)

set laststatus=2

" search down into subfolders
" provides tab completion for file related tasks
set path+=**
filetype plugin on

" don't search git, node_modules, or targert with wildmenu
set wildignore=.git,*/node_modules/*,*/target/*

"encoding
set encoding=utf-8

"search settings
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
nnoremap <leader>nt :NERDTree<cr>
" find open file in NerdTree
nnoremap <leader>nf :NERDTreeFind<cr>
" toggle highlight search off
nnoremap<leader>hs :nohlsearch<cr>
" format json
nnoremap<leader>js :%!jq '.'<cr>
" format xml
nnoremap<leader>xml :%!xmllint --format -<cr>

