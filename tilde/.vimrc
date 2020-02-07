" custom leader
let mapleader = ","

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
if filereadable(expand("~/.flavor/plugs.vim"))
  source ~/.flavor/plugs.vim
endif

" plugin settings
if filereadable(expand("~/.flavor/plug-settings.vim"))
  source ~/.flavor/plug-settings.vim
endif

" Theme
set termguicolors

if exists("sunny")
  set background=light
  colorscheme one
else
  set background=dark
  " onedark.vim override: Don't set a background color when running in a terminal;
  " just use the terminal's background color
  if (has("autocmd") && !has("gui_running"))
    augroup colors
      autocmd!
      let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16": "7"}
      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) "No `bg` setting
    augroup END
  endif

  colorscheme onedark
endif

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

" allow for more than one unsaved buffer
set hidden

" show if at least 2 tab pages
set showtabline=1

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

" automatically wrap in markdown
autocmd FileType markdown setlocal textwidth=80

" enforce characters to be 80 or less in js
highlight ColorColumn ctermbg=lightgrey
autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)


" set status line display
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

set backspace=indent,eol,start
" yank to clipboard
set clipboard=unnamed

" escape
inoremap jj <ESC>

" toggle highlight search off
nnoremap<leader>hs :nohlsearch<cr>
" format json
nnoremap<leader>js :%!jq '.'<cr>
" format xml
nnoremap<leader>xml :%!xmllint --format -<cr>

au BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell
au BufReadPost,BufNewFile *.html,*.txt,*.md set spell spelllang=en_us
