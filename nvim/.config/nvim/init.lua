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
-- PLUGINS -----------------------
----------------------------------
cmd [[packadd packer.nvim]]
require 'plugins'

----------------------------------
-- VARIABLES ---------------------
----------------------------------
g['mapleader'] = ','
g['netrw_gx'] = '<cWORD>'
g['netrw_liststyle'] = 3
g['netrw_banner'] = 0

-- plugin variables
-- polyglot's markdown settings
g['vim_markdown_conceal'] = 0
g['vim_markdown_conceal_code_blocks'] = 0

-- nvim-metals
-- g['metals_server_version'] = '0.9.8'
g['metals_server_version'] = '0.9.10+14-94a8c9c3-SNAPSHOT'
--g['metals_server_version'] = '0.9.10-SNAPSHOT'

----------------------------------
-- OPTIONS -----------------------
----------------------------------
local indent = 2

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
opt('o', 'completeopt', 'menuone,noinsert,noselect')
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'
vim.o.path = vim.o.path .. '**'

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
-- map('n', '<leader>js', ':%!jq "."<cr>') If satisfied with the jsonls, I can just remove this
map('n', '<leader>xml', ':%!xmllint --format -<cr>')
map('n', '<leader>fo', ':copen<cr>')
map('n', '<leader>fc', ':cclose<cr>')
map('n', '<leader>fn', ':cnext<cr>')
map('n', '<leader>fp', ':cprevious<cr>')
map('n', '<leader>nn', ':NvimTreeToggle<CR>')
map('n', '<leader>nf', ':NvimTreeFindFile<CR>')

-- LSP
map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>ws', '<cmd>lua require"metals".worksheet_hover()<CR>')
map('n', '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>') -- buffer diagnostics only
map('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>')
map('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>')

-- completion
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

----------------------------------
-- COMMANDS ----------------------
----------------------------------
cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
cmd [[autocmd FileType markdown setlocal textwidth=80]]
cmd [[autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)]]
cmd [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]]
cmd [[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]]

-- LSP
cmd [[augroup lsp]]
cmd [[autocmd!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
-- cmd [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
-- cmd [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
-- cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
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
fn.sign_define('LspDiagnosticsSignError', {text = '✘', texthl = 'LspDiagnosticsDefaultError'})
fn.sign_define('LspDiagnosticsSignWarning', {text = '', texthl = 'LspDiagnosticsDefaultWarning'})

-- LspDiagnosticsUnderlineError
-- LspDiagnosticsUnderlineWarning
-- LspDiagnosticsUnderlineInformation
-- vim.cmd [[hi! LspDiagnosticsUnderlineWarning guifg=none]] -- I don't ge twhy this doesn't work TODO figure this out
vim.cmd [[hi! link LspReferenceText CursorColumn]]
vim.cmd [[hi! link LspReferenceRead CursorColumn]]
vim.cmd [[hi! link LspReferenceWrite CursorColumn]]

local shared_diagnostic_settings = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                                                {virtual_text = {prefix = '', truncated = true}})
local lsp_config = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_config.util.default_config = vim.tbl_extend('force', lsp_config.util.default_config, {
  handlers = {['textDocument/publishDiagnostics'] = shared_diagnostic_settings},
  on_attach = require'completion'.on_attach,
  capabilities = capabilities
})

-- nvim-metals
metals_config = require'metals'.bare_config
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl'}
}

metals_config.on_attach = function()
  require'completion'.on_attach();
end

metals_config.init_options.statusBarProvider = 'on'
metals_config.handlers['textDocument/publishDiagnostics'] = shared_diagnostic_settings
metals_config.capabilities = capabilities

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

-- Uncomment for trace logs from neovim
-- vim.lsp.set_log_level("trace")
----------------------------------
-- TREESITTER Setup --------------
----------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'html', 'javascript', 'yaml', 'css', 'toml', 'lua', 'json'},
  highlight = {enable = true}
}

require('statusline').setup()
require('nvim-autopairs').setup()
