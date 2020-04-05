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
  " This just just an experiment to see if I can 
  " get the total diagnostics in a workspace rather
  " than those just in the current buffer
  function! StatusDiagnostic() abort
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
      return " E " . string(len(errors)) . " W " . string(len(warnings))
    endif
  endfunction
  " I used this instead of coc_status()
  " because coc#status includes both statusline
  " information and diagnostic information
  " since I display diagnostic on the far right,
  " I don't want to also display it in the center again
  " By default airline shows the status, but I dislike
  " the bold display that is the same color as your file.
  " This whill do a minimal status the same color as your
  " line number.
  function! CocMinimalStatus() abort
    return get(g:, 'coc_status', '')
  endfunction
  let g:airline_section_c = '%t %#LineNr#%{CocMinimalStatus()}'
  " langauge server client settings
  if filereadable(expand("~/.flavor/coc.vim"))
    source ~/.flavor/coc.vim
  endif
endif

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#coc#error_symbol = '✘ '
let g:airline#extensions#coc#warning_symbol = '⚠ '
let g:airline#extensions#coc#enabled = 1

" Coming from polyglot's markdown settings
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" nnn.vim
let g:nnn#set_default_mappings = 0
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
nnoremap <leader>n :NnnPicker %:p:h<CR>
