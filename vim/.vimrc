" I truly hope no one is coming here to reference this...
" honestly, this is pretty much used to ensure that I can
" still test coc-metals. Apart from that all of this stuff is
" probably wildly out of date
" custom leader
let mapleader = ","

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

au BufRead,BufNewFile *.sbt set filetype=scala

" Gets Errors and Warnings for buffer plus the Status message from coc.nvim
function! StatusDiagnosticForBuffer() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" Gets Errors and Warnings for the entire workspace from coc.nvim
function! StatusDiagnosticForWorkspace() abort
  let diagnostics = CocAction('diagnosticList')
  if type(diagnostics) == v:t_list
    let errors = []
    let warnings = []
    for diagnostic in diagnostics
      if diagnostic['severity'] == 'Error'
        call add(errors, diagnostic)
      endif
      if diagnostic['severity'] == 'Warning'
        call add(warnings, diagnostic)
      endif
    endfor
    return " ✘ " . string(len(errors)) . "  " . string(len(warnings)) . " "
  endif
endfunction

" Just gets the status message from coc.nvim
function! CocMinimalStatus() abort
  return get(g:, 'coc_status', '')
endfunction

" Just gets the errors from the current buffer
function! CocMinimalErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  return join(msgs)
endfunction

" Just gets the warnings from the current buffer
function! CocMinimalWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs)
endfunction

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHold
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Used to expand decorations in worksheets
nmap <leader>ws <Plug>(coc-metals-expand-decoration)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

xmap <leader>al  <Plug>(coc-codeaction-line)
nmap <leader>al  <Plug>(coc-codeaction-line)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>
" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocActionAsync('fold', <f-args>)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

set background=dark

colorscheme onedark

" Because no one likes to be blinded by awful colors
highlight CocErrorSign guifg=#E06C75
highlight CocWarningSign guifg=#E5C07B
highlight StatusLineStatus guifg=#4B5263 guibg=#2C323C
highlight StatusLineError guifg=#E06C75 guibg=#2C323C
highlight StatusLineWarning guifg=#E5C07B guibg=#2C323C

set statusline=%n\   " buffer number
set statusline+=%t\ %M%r%h%w\  " file modified, readonly, help, preview
set statusline+=%#StatusLineError#%{CocMinimalErrors()}\ " coc-errors
set statusline+=%#StatusLineWarning#%{CocMinimalWarnings()}\ " coc-warnings
set statusline+=%#StatusLineStatus#%{CocMinimalStatus()}%#StatusLine#\ " coc status 
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
