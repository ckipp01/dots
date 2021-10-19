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
require("settings.cmp").setup()
require("settings.telescope").setup()
require("settings.lsp").setup()
require("settings.statusline")

require("nvim-autopairs").setup()
require("gitsigns").setup()

require("nvim-treesitter.configs").setup({
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    --disable = { "scala" },
  },
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
g["metals_server_version"] = "0.10.7+124-df3f5d66-SNAPSHOT"
--g["metals_server_version"] = "0.10.7"
-- Only for testing scala-cli
--g["metals_server_org"] = "org.virtuslab"
--g["metals_server_version"] = "0.10.8-SNAPSHOT"

----------------------------------
-- OPTIONS -----------------------
----------------------------------
local indent = 2

-- global
-- If you're copying my dot files and aren't familiar with nvim-metals, then
-- make sure you remove("F"). Do as I say, not as I do
global_opt.shortmess:remove("F"):append("c")
--global_opt.shortmess:append("c")
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

-- statusline
opt.statusline = "%!luaeval('Super_custom_status_line()')"

-- MAPPINGS -----------------------
map("i", "jj", "<ESC>")

map("n", "<leader><leader>n", [[<cmd>lua RELOAD("settings.functions").toggle_nums()<CR>]])
map("n", "<leader><leader>c", [[<cmd>lua RELOAD("settings.functions").toggle_conceal()<CR>]])

map("n", "<leader>nhs", ":nohlsearch<cr>")
map("n", "<leader>xml", ":%!xmllint --format -<cr>")
map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")
map("n", "<leader>tv", ":vnew | :te<cr>")

-- LSP
map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require"settings.telescope".lsp_workspace_symbols()<CR>]])
map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
map("n", "<leader>ws", [[<cmd>lua require"metals".hover_worksheet()<CR>]])
map("n", "<leader>a", [[<cmd>lua require("metals").open_all_diagnostics()<CR>]])
map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
map("n", "<leader>d", [[<cmd>lua vim.diagnostic.setloclist()<CR>]]) -- buffer diagnostics only
map("n", "<leader>nd", [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
map("n", "<leader>pd", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
map("n", "<leader>ld", [[<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>]])
map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])

map("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])

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
map("v", "<leader><leader>v", [[<cmd>lua RELOAD("playground.functions").visual_selection_range()<CR>]])
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

cmd([[augroup colorset]])
cmd([[autocmd!]])

--- For some reason when this is included in the augroup down below it doesn't work
---- Needed to esnure float background doesn't get odd highlighting
---- https://github.com/joshdick/onedark.vim#onedarkset_highlight
cmd(
  [[autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })]]
)
cmd([[autocmd ColorScheme * highlight link LspCodeLens Conceal]])
cmd([[augroup END]])

cmd("colorscheme onedark")

-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])
--cmd([[autocmd FileType dap-repl lua require("dap.ext.autocompl").attatch()]])

-- used in textDocument/hightlight
cmd([[hi! link LspReferenceText CursorColumn]])
cmd([[hi! link LspReferenceRead CursorColumn]])
cmd([[hi! link LspReferenceWrite CursorColumn]])

-- Diagnostic specific colors
cmd([[hi! DiagnosticError guifg=#e06c75]]) -- light red
cmd([[hi! DiagnosticWarn guifg=#e5c07b]]) -- light yellow
cmd([[hi! DiagnosticInfo guifg=#56b6c2]]) -- cyan
cmd([[hi! link DiagnosticHint DiagnosticInfo]])

-- _Maybe_ try underline for a bit
cmd([[hi! DiagnosticUnderlineError cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineWarn cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineInfo cterm=NONE gui=underline guifg=NONE]])
cmd([[hi! DiagnosticUnderlineHint cterm=NONE gui=underline guifg=NONE]])

-- Statusline specific highlights
cmd([[hi! StatusLine guifg=#5C6370 guibg=#282c34]])
cmd([[hi! link StatusError DiagnosticError]])
cmd([[hi! link StatusWarn DiagnosticWarn]])

cmd([[augroup END]])

vim.cmd([[command! Format lua vim.lsp.buf.formatting()]])

----------------------------------
-- DIAGNOSTIC SETTINGS -----------
----------------------------------
fn.sign_define("DiagnosticSignError", { text = "▬", texthl = "DiagnosticError" })
fn.sign_define("DiagnosticSignWarn", { text = "▬", texthl = "DiagnosticWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "▬", texthl = "DiagnosticInfo" })
fn.sign_define("DiagnosticSignHint", { text = "▬", texthl = "DiagnosticHint" })

-- Since a lot of errors can be super long and multiple lines in Scala, I use
-- this to split on the first new line and only dispaly the first line as the
-- virtual text... that is when I actually use virtual text for diagnsostics
local diagnostic_foramt = function(diagnostic)
  return string.format("%s: %s", diagnostic.source, f.split_on(diagnostic.message, "\n")[1])
end

vim.diagnostic.config({ virtual_text = { format = diagnostic_foramt }, severity_sort = true })
