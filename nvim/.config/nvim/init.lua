local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local f = require("settings.functions")
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

----------------------------------
-- SETUP PLUGINS -----------------
----------------------------------
cmd([[packadd packer.nvim]])
require("plugins")
require("settings.functions")
require("settings.compe").setup()
require("settings.telescope").setup()
require("settings.lsp").setup()

require("settings.galaxyline").setup()
require("nvim-autopairs").setup()

require("nvim-treesitter.configs").setup({
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = "maintained",
  highlight = { enable = true },
})

----------------------------------
-- VARIABLES ---------------------
----------------------------------
g["mapleader"] = ","
g["netrw_gx"] = "<cWORD>"

-- plugin variables
-- polyglot's markdown settings
g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

-- nvim-metals
--g["metals_server_version"] = "0.10.4"
g["metals_server_version"] = "0.10.4+110-3cdc7a9c-SNAPSHOT"
-- TODO I want to be able to do this so badly
--g["metals_server_version"] = "latest.snapshot"
--g["metals_server_version"] = "0.10.5-SNAPSHOT"
--g["metals_disabled_mode"] = true
----------------------------------
-- OPTIONS -----------------------
----------------------------------
local indent = 2

-- global
global_opt.shortmess:remove("F"):append("c")
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 300
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" }
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.clipboard = "unnamed"
global_opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- window-scoped
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"

-- buffer-scoped
opt.tabstop = indent
opt.shiftwidth = indent
opt.softtabstop = indent
opt.expandtab = true
opt.fileformat = "unix"

-- MAPPINGS -----------------------
-- insert-mode mappings
map("i", "jj", "<ESC>")

map("n", "<leader><leader>n", [[<cmd>lua RELOAD("settings.functions").toggle_nums()<CR>]])
map("n", "<leader><leader>c", [[<cmd>lua RELOAD("settings.functions").toggle_conceal()<CR>]])

-- normal-mode mappings
map("n", "<leader>hs", ":nohlsearch<cr>")
map("n", "<leader>xml", ":%!xmllint --format -<cr>")
map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")
map("n", "<leader>tv", ":vnew | :te<cr>")

-- LSP
map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require"settings.telescope".lsp_workspace_symbols()<CR>]])
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map("n", "<leader>ws", [[<cmd>lua require"metals".worksheet_hover()<CR>]])
map("n", "<leader>a", [[<cmd>lua RELOAD("metals").open_all_diagnostics()<CR>]])
map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
map("n", "<leader>d", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]]) -- buffer diagnostics only
map("n", "]c", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]])
map("n", "[c", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]])
map("n", "<leader>ln", [[<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>]])

map("n", "<leader>q", [[<cmd>lua RELOAD("metals").restart_server()<CR>]])
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])

-- completion
map("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<Tab>"]], { expr = true })
map("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
map("i", "<CR>", [[compe#confirm("<CR>")]], { expr = true })

-- telescope
map("n", "<leader>ff", [[<cmd>lua require"telescope.builtin".find_files()<CR>]])
map("n", "<leader>lg", [[<cmd>lua require"telescope.builtin".live_grep()<CR>]])
map("n", "<leader>fb", [[<cmd>lua require"telescope.builtin".file_browser()<CR>]])
map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])

-- nvim-dap
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>ds", [[<cmd>lua require"dap.ui.variables".scopes()<CR>]])
map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])

-- scala-utils
map("n", "<leader>slc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_line()<CR>]])
map("n", "<leader>sc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_input()<CR>]])

-- other stuff
require("playground.globals")
map("n", "<leader><leader>p", [[<cmd>lua require"playground.functions".peek()<CR>]])
map("n", "<leader><leader>s", [[<cmd>lua RELOAD("playground.semantic").generate()<CR>]])
map("n", "<leader><leader>m", [[<cmd>lua RELOAD("playground.mt").get_dep()<CR>]])
map("n", "<leader><leader>s", [[<cmd>lua RELOAD("playground.functions").set_ext()<CR>]])
map("n", "<leader><leader>g", [[<cmd>lua RELOAD("playground.functions").get_exts()<CR>]])
map("n", "<leader><leader>e", [[:luafile %<CR>]])

----------------------------------
-- COMMANDS ----------------------
----------------------------------
cmd([[autocmd FileType markdown setlocal textwidth=80]])
cmd(
  [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]]
)
cmd([[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]])
cmd([[autocmd TermOpen * startinsert]])

cmd("colorscheme onedark")
-- TODO make sure this works later
-- TODO I can't get this to work as expected
cmd([[highlight LspDiagnosticsUnderlineWarning guifg=None]])
--cmd([[highlight LspDiagnosticsUnderlineWarning guifg=None"]])

cmd([[augroup colorset]])
cmd([[autocmd!]])
-- Needed to esnure float background doesn't get odd highlighting
-- https://github.com/joshdick/onedark.vim#onedarkset_highlight
cmd(
  [[autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })]]
)
cmd([[ autocmd ColorScheme * highlight link LspCodeLens Conceal]])
cmd([[augroup END]])
-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])

cmd([[hi! link LspReferenceText CursorColumn]])
cmd([[hi! link LspReferenceRead CursorColumn]])
cmd([[hi! link LspReferenceWrite CursorColumn]])

cmd([[hi! link LspCodeLens CursorColumn]])
cmd([[augroup END]])

----------------------------------
-- LSP Settings ------------------
----------------------------------
fn.sign_define("LspDiagnosticsSignError", { text = "▬" })
fn.sign_define("LspDiagnosticsSignWarning", { text = "▬" })
fn.sign_define("LspDiagnosticsSignInformation", { text = "▬" })
fn.sign_define("LspDiagnosticsSignHint", { text = "▬" })

vim.cmd([[command! Format lua vim.lsp.buf.formatting()]])
