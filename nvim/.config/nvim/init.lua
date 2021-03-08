local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local function opt(scope, key, value)
  local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------------------
-- SETUP PLUGINS -----------------
----------------------------------
cmd [[packadd packer.nvim]]
require 'plugins'

require('settings.galaxyline').setup()
require('nvim-autopairs').setup()

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {enable = true}
}

require('settings.compe').setup()
require('settings.telescope').setup()

require('lspsaga').init_lsp_saga({
  finder_action_keys = {open = '<CR>', vsplit = 's', split = 'i', quit = 'q'},
  server_filetype_map = {metals = {'sbt', 'scala'}}
})

----------------------------------
-- VARIABLES ---------------------
----------------------------------
g['mapleader'] = ','
g['netrw_gx'] = '<cWORD>'
g['netrw_liststyle'] = 3
-- g['netrw_banner'] = 0

-- plugin variables
-- polyglot's markdown settings
g['vim_markdown_conceal'] = 0
g['vim_markdown_conceal_code_blocks'] = 0

-- nvim-metals
-- g['metals_use_global_executable'] = true
-- g['metals_server_version'] = '0.10.0'
g['metals_server_version'] = '0.10.0+36-33049b09-SNAPSHOT'
--g['metals_server_version'] = '0.10.1-SNAPSHOT'

----------------------------------
-- OPTIONS -----------------------
----------------------------------
local indent = 2
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'
vim.o.path = vim.o.path .. '**'

-- global
opt('o', 'termguicolors', true)
opt('o', 'hidden', true)
opt('o', 'showtabline', 1)
opt('o', 'updatetime', 300)
opt('o', 'showmatch', true)
opt('o', 'laststatus', 2)
opt('o', 'wildignore', '.git,*/node_modules/*,*/target/*,.metals,.bloop')
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'clipboard', 'unnamed')
opt('o', 'completeopt', 'menu,menuone,noselect')

-- window-scoped
opt('w', 'wrap', false)
opt('w', 'cursorline', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'signcolumn', 'yes')

-- buffer-scoped
opt('b', 'tabstop', indent)
opt('b', 'shiftwidth', indent)
opt('b', 'softtabstop', indent)
opt('b', 'expandtab', true)
opt('b', 'fileformat', 'unix')

-- MAPPINGS -----------------------
-- insert-mode mappings
map('i', 'jj', '<ESC>')

-- normal-mode mappings
map('n', '<leader>hs', ':nohlsearch<cr>')
map('n', '<leader>xml', ':%!xmllint --format -<cr>')
map('n', '<leader>fo', ':copen<cr>')
map('n', '<leader>fc', ':cclose<cr>')
map('n', '<leader>fn', ':cnext<cr>')
map('n', '<leader>fp', ':cprevious<cr>')
map('n', '<leader>tv', ':vnew | :te<cr>')

-- LSP
map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gds', '<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>')
map('n', 'gws', '<cmd>lua require"settings.telescope".lsp_workspace_symbols()<CR>')
map('n', '<leader>rn', '<cmd>lua require"lspsaga.rename".rename()<CR>')
map('n', '<leader>ca', '<cmd>lua require"lspsaga.codeaction".code_action()<CR>')
map('v', '<leader>ca', '<cmd>lua require"lspsaga.codeaction".range_code_action()<CR>')
map('n', '<leader>ws', '<cmd>lua require"metals".worksheet_hover()<CR>')
map('n', '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>') -- buffer diagnostics only
map('n', ']c', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>')
map('n', '[c', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>')
map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>')

-- completion
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})

-- telescope
map('n', '<leader>ff', '<cmd>lua require"telescope.builtin".find_files()<CR>')
map('n', '<leader>lg', '<cmd>lua require"telescope.builtin".live_grep()<CR>')

-- nvim-dap
map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dso', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')

-- other stuff
map('n', '<leader>pd', '<cmd>lua require"playground.functions".peek()<CR>')

----------------------------------
-- COMMANDS ----------------------
----------------------------------
cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
cmd [[autocmd FileType markdown setlocal textwidth=80]]
cmd [[autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)]]
cmd [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]]
cmd [[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]]
cmd [[autocmd TermOpen * startinsert]]
-- LSP
cmd [[augroup lsp]]
cmd [[autocmd!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]]
cmd [[augroup end]]

-- Needed to esnure float background doesn't get odd highlighting
-- https://github.com/joshdick/onedark.vim#onedarkset_highlight
cmd [[augroup colorset]]
cmd [[autocmd!]]
cmd [[autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })]]
cmd [[augroup END]]

cmd 'colorscheme onedark'

----------------------------------
-- LSP Setup ---------------------
----------------------------------
fn.sign_define('LspDiagnosticsSignError', {text = '▬'})
fn.sign_define('LspDiagnosticsSignWarning', {text = '▬'})
fn.sign_define('LspDiagnosticsSignInformation', {text = '▬'})
fn.sign_define('LspDiagnosticsSignHint', {text = '▬'})

vim.cmd [[hi! link LspReferenceText CursorColumn]]
vim.cmd [[hi! link LspReferenceRead CursorColumn]]
vim.cmd [[hi! link LspReferenceWrite CursorColumn]]

vim.cmd [[hi! link LspSagaFinderSelection CursorColumn]]
vim.cmd [[hi! link LspSagaDocTruncateLine LspSagaHoverBorder]]

local shared_diagnostic_settings = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                                                {virtual_text = false})
local lsp_config = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_config.util.default_config = vim.tbl_extend('force', lsp_config.util.default_config, {
  handlers = {['textDocument/publishDiagnostics'] = shared_diagnostic_settings},
  capabilities = capabilities
})

-- nvim-metals
Metals_config = require'metals'.bare_config
Metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = {
    'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl', 'akka.stream.javadsl'
  },
  fallbackScalaVersion = '2.13.4'
}

Metals_config.init_options.statusBarProvider = 'on'
Metals_config.handlers['textDocument/publishDiagnostics'] = shared_diagnostic_settings
Metals_config.capabilities = capabilities

-- Metals_config.on_attach = function()
--   require'metals'.setup_dap()
-- end

-- sumneko lua
lsp_config.sumneko_lua.setup {
  cmd = {
    '/Users/ckipp/Documents/lua-workspace/lua-language-server/bin/macOS/lua-language-server', '-E',
    '/Users/ckipp/Documents/lua-workspace/lua-language-server/main.lua'
  },
  commands = {
    Format = {
      function()
        vim.api.nvim_call_function('LuaFormat', {})
      end
    }
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- since using mainly for neovim
        path = vim.split(package.path, ';')
      },
      diagnostics = {globals = {'vim', 'it'}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}

lsp_config.dockerls.setup {}
lsp_config.html.setup {}
lsp_config.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line('$'), 0})
      end
    }
  }
}
lsp_config.tsserver.setup {}
lsp_config.yamlls.setup {}
lsp_config.racket_langserver.setup {}

lsp_config.gopls.setup {
  cmd = {'gopls', 'serve'},
  settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
}

-- Uncomment for trace logs from neovim
-- vim.lsp.set_log_level('trace')
