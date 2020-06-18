"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" These settings are a work in progress for using https://scalameta.org/metals
" with the built-in LSP support of Nvim. They are also meant to serve as an
" example of what a setup can look like. They aren't necessarily meant to be
" copied verbatim, but rather referenced, improved, tweaked, etc.
" They assume that you have the following plugins installed for the listed
" reasons. Also ensure that you have Nvim nightly installed. The latest stable
" release does not yet have built-in LSP support.
"
" - https://github.com/neovim/nvim-lsp
"     (automated installation and basic setup info)
" - https://github.com/haorenW1025/completion-nvim
"     (completions much like your familiar to with other LSP clients)
" - https://github.com/haorenW1025/diagnostic-nvim
"     (a bit more sensible diagnostic than what ships by default)
"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gsd         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gsw         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>

" Mapping specific to plugins
nnoremap <silent> [c          :NextDiagnostic<CR>
nnoremap <silent> ]c          :PrevDiagnostic<CR>
nnoremap <silent> <space>d    :OpenDiagnostic<CR>

"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then setting this isn't necessary
let g:metals_server_version = '0.9.1-SNAPSHOT'
let g:metals_decoration_color = 'Conceal' 

"-----------------------------------------------------------------------------
" lua callbacks
"-----------------------------------------------------------------------------
:lua << EOF
  local nvim_lsp = require'nvim_lsp'
  local metals   = require'metals'
  local setup    = require'metals.setup' 
  local M = {}

  M.on_attach = function()
      require'diagnostic'.on_attach();
      require'completion'.on_attach();
      setup.auto_commands()
    end

  nvim_lsp.metals.setup{
    on_attach    = M.on_attach;
    root_dir     = metals.root_pattern("build.sbt", "build.sc", ".git");
    init_options = {
      statusBarProvider            = "on";
      inputBoxProvider             = true;
      quickPickProvider            = true;
      executeClientCommandProvider = true;
      hoverProvider                = true;
      decorationProvider           = true;
    };

    on_init = setup.on_init;

    callbacks = {
      ["textDocument/hover"]          = metals['textDocument/hover'];
      ["metals/status"]               = metals['metals/status'];
      ["metals/inputBox"]             = metals['metals/inputBox'];
      ["metals/quickPick"]            = metals['metals/quickPick'];
      ["metals/executeClientCommand"] = metals["metals/executeClientCommand"];
      ["metals/publishDecorations"]   = metals["metals/publishDecorations"];
      ["metals/didFocusTextDocument"] = metals["metals/didFocusTextDocument"];
    };
  }
EOF

"-----------------------------------------------------------------------------
" completion-nvim settings
"-----------------------------------------------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"-----------------------------------------------------------------------------
" diagnostic-nvim settings
"-----------------------------------------------------------------------------
"let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '


"-----------------------------------------------------------------------------
" statusline functions
"-----------------------------------------------------------------------------
function! LspErrors() abort
  let errorCount = luaeval('vim.lsp.util.buf_diagnostics_count("Error")')
  let possibleLspSign = sign_getdefined("LspDiagnosticsErrorSign")
  let sign = get(possibleLspSign, 0, {"text": "E"})
  if (errorCount > 0)
    return sign.text . errorCount
  else
    return ''
  endif
endfunction


function! LspWarnings() abort
  let warningCount = luaeval('vim.lsp.util.buf_diagnostics_count("Warning")')
  let possibleLspSign = sign_getdefined("LspDiagnosticsWarningSign")
  let sign = get(possibleLspSign, 0, {"text": "W"})
  if (warningCount > 0)
    return sign.text . warningCount
  else
    return ''
  endif
endfunction

"-----------------------------------------------------------------------------
" Helpful general settings
"-----------------------------------------------------------------------------
" Needed for compltions
autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Needed if you want to set your own gutter signs
" NOTE: the `texthl` groups I created. You can use the defaults or create your
" own to match your statusline for example
call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspGutterError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspGutterWarning"})

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
