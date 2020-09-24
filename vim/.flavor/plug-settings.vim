" netwr settings
let g:netrw_liststyle=3
let g:netrw_banner=0

" vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

if exists("lsp")
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
elseif exists("lsc")
  let g:lsc_auto_map = v:true
  let g:lsc_server_commands = { 'scala': 'metals-vim' }
elseif exists("vnative") && has("nvim")
  if filereadable(expand("~/.flavor/nvim-lsp.vim"))
    source ~/.flavor/nvim-lsp.vim
  endif
else
  " langauge server client settings
  if filereadable(expand("~/.flavor/coc.vim"))
    source ~/.flavor/coc.vim
  endif
endif

" Coming from polyglot's markdown settings
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" nnn.vim
let g:nnn#set_default_mappings = 0
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
nnoremap <leader>n :NnnPicker %:p:h<CR>
