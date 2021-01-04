" custom leader
let mapleader = ","

call plug#begin('~/.vim/plugged')

Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
" Plug 'puremourning/vimspector'
"Plug 'machakann/vim-sandwich'
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

" netwr settings
let g:netrw_liststyle=3
let g:netrw_banner=0

au BufRead,BufNewFile *.sbt set filetype=scala

if filereadable(expand("~/.flavor/coc.vim"))
  source ~/.flavor/coc.vim
endif

" Coming from polyglot's markdown settings
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

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

" Override the annoying bright red and yellow from coc
highlight CocErrorSign guifg=#E06C75
highlight CocWarningSign guifg=#E5C07B

" highlight groups used for statusline
highlight StatusLineStatus guifg=#4B5263 guibg=#2C323C
highlight StatusLineError guifg=#E06C75 guibg=#2C323C
highlight StatusLineWarning guifg=#E5C07B guibg=#2C323C

" highlight groups to match statusline
highlight LspGutterError guifg=#E06C75
highlight LspGutterWarning guifg=#E5C07B

set statusline=%n\   " buffer number
set statusline+=%t\ %M%r%h%w\  " file modified, readonly, help, preview
if exists("coc")
  set statusline+=%#StatusLineError#%{CocMinimalErrors()}\ " coc-errors
  set statusline+=%#StatusLineWarning#%{CocMinimalWarnings()}\ " coc-warnings
  set statusline+=%#StatusLineStatus#%{CocMinimalStatus()}%#StatusLine#\ " coc status 
elseif exists("lsp") " If using vim-lsp there is no status
set statusline+=%=%Y\  " filetype
set statusline+=%{&ff}\  " right align line endings
set statusline+=%l,%v\ " curser position
set statusline+=%p%%\  " percentage on page

" turn on syntax highlighting.
if !exists("g:syntax_on")
  syntax enable
endif

" allow for urls with query strings to be opened with the query string
let g:netrw_gx="<cWORD>"

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
set cursorline
set number
set relativenumber
set conceallevel=0

" allows your update time to be a bit faster
set updatetime=300

set showmatch

" always show signcolumns
set signcolumn=yes

" disables the automatic comment lines after another comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" automatically wrap in markdown
autocmd FileType markdown setlocal textwidth=80

" enforce characters to be 80 or less in js
highlight ColorColumn ctermbg=red
autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)

" always show statusline
set laststatus=2

" search down into subfolders
" provides tab completion for file related tasks
set path+=**
filetype plugin on

" don't search git, node_modules, or targert with wildmenu
set wildignore=.git,*/node_modules/*,*/target/*

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

" Mappings to deal with the quickfix window
nnoremap<leader>fo :copen<cr>
nnoremap<leader>fc :cclose<cr>
nnoremap<leader>fn :cnext<cr>
nnoremap<leader>fp :cprevious<cr>

au BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell
au BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us
