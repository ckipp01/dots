--=================================
-- Mesopotamia
--
-- My Neovim Setup
-- Chris Kpp
--
-- https://www.chris-kipp.io
--=================================

-- We first make sure we have packer before we do anything
if require("mesopotamia.pre")() then
  return
end

local api = vim.api
local cmd = vim.cmd
local g = vim.g

-- NOTE do this ASAP since some of the stuff in our basic setup uses leader
g["mapleader"] = ","

local f = require("mesopotamia.functions")
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

--================================
-- Basic setup
--================================

require("mesopotamia.plugins")
require("mesopotamia.globals")
require("mesopotamia.statusline")

require("mesopotamia.lsp").setup()
require("mesopotamia.diagnostic").setup()

--================================
-- VARIABLES ---------------------
--================================
g["netrw_gx"] = "<cWORD>"

-- plugin variables
-- polyglot's markdown settings
g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

--================================
-- OPTIONS -----------------------
--================================
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
global_opt.scrolloff = 5

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
opt.modeline = false

-- statusline
opt.statusline = "%!luaeval('Super_custom_status_line()')"

-- MAPPINGS -----------------------
map("i", "jj", "<ESC>")

map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")
map("n", "<leader>xml", ":%!xmllint --format -<cr>")

-- scala-utils
map("n", "<leader>slc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_line()<CR>]])
map("n", "<leader>sc", [[<cmd>lua RELOAD("scala-utils.coursier").complete_from_input()<CR>]])

-- other stuff
map("n", "<leader><leader>p", [[<cmd>lua require("mesopotamia.playground.functions").peek()<CR>]])
map("n", "<leader><leader>s", [[<cmd>lua RELOAD("mesopotamia.playground.semantic").generate()<CR>]])
map("n", "<leader><leader>m", [[<cmd>lua RELOAD("mesopotamia.playground.mt").get_dep()<CR>]])
map("n", "<leader><leader>e", [[:luafile %<CR>]])
map("n", "<leader><leader>v", [[<cmd>lua RELOAD("mesopotamia.playground.functions").get_latest_metals()<CR>]])
map("n", "<leader><leader>j", [[<cmd>lua RELOAD("jenkinsfile_linter").validate()<CR>]])
map("n", "<leader><leader>hl", [[<cmd>lua RELOAD("mesopotamia.playground.functions").get_hl_under_cursor()<CR>]])

map("n", "<leader><leader>n", [[<cmd>lua RELOAD("mesopotamia.functions").toggle_nums()<CR>]])
map("n", "<leader><leader>c", [[<cmd>lua RELOAD("mesopotamia.functions").toggle_conceal()<CR>]])
map("n", "<leader><leader>jc", [[<cmd>lua RELOAD("mesopotamia.functions").replace_java_converters()<CR>]])

--================================
-- COMMANDS ----------------------
--================================
local base_group = api.nvim_create_augroup("base", { clear = true })

api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "setlocal textwidth=80", group = base_group })
api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("n", "<leader>mh", [[<cmd>lua RELOAD("mesopotamia.functions").markdown_headers()<CR>]])
  end,
  group = base_group,
})
api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.md", "*.txt", "COMMIT_EDITMSG" },
  command = "set wrap linebreak nolist spell spelllang=en_us complete+=kspell",
  group = base_group,
})

cmd("colorscheme kanagawa")

-- Statusline specific highlights
local kanagawa_colors = require("kanagawa.colors").setup()
cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.fujiGray, kanagawa_colors.sumiInk1))
cmd([[hi! link StatusLineNC Comment]])
cmd([[hi! link StatusError DiagnosticError]])
cmd([[hi! link StatusWarn DiagnosticWarn]])

local kanagawa_group = api.nvim_create_augroup("kanagawa", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = kanagawa_group,
})
