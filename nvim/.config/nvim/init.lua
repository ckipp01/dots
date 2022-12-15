--=================================
-- Mesopotamia
--
-- My Neovim Setup
-- Chris Kpp
--
-- https://www.chris-kipp.io
--=================================

local api = vim.api
local cmd = vim.cmd
local g = vim.g

-- NOTE do this ASAP since some of the stuff in our basic setup uses leader
g.mapleader = ","

local map = vim.keymap.set
local opt = vim.opt
local global_opt = vim.opt_global

--================================
-- Basic setup
--================================

require("mesopotamia.plugins")
require("mesopotamia.globals")

require("mesopotamia.lsp").setup()
require("mesopotamia.diagnostic").setup()

--================================
-- VARIABLES ---------------------
--================================
g.netrw_gx = "<cWORD>"

-- plugin variables
-- polyglot's markdown settings
g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

--================================
-- OPTIONS -----------------------
--================================
local indent = 2

-- global
global_opt.shortmess:append("c")
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
global_opt.completeopt = { "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5
global_opt.laststatus = 3

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
opt.statusline = [[%!luaeval('require("mesopotamia.statusline_winbar").super_custom_status_line()')]]
opt.winbar = [[%!luaeval('require("mesopotamia.statusline_winbar").super_custom_winbar()')]]

-- MAPPINGS -----------------------
map("i", "jj", "<ESC>")

map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")
map("n", "<leader>xml", ":%!xmllint --format -<cr>")

-- scala-utils (these aint working... really should try to work on these)
--map("n", "<leader>slc", RELOAD("scala-utils.coursier").complete_from_line)
--map("n", "<leader>sc", RELOAD("scala-utils.coursier").complete_from_input)

-- other stuff
map("n", "<leader><leader>p", require("mesopotamia.playground.functions").peek)

map("n", "<leader><leader>s", function()
  RELOAD("mesopotamia.playground.semantic").generate()
end)

map("n", "<leader><leader>e", [[:luafile %<CR>]])

map("n", "<leader><leader>v", require("mesopotamia.playground.functions").get_latest_metals)

map("n", "<leader><leader>hl", function()
  RELOAD("mesopotamia.playground.functions").get_hl_under_cursor()
end)

map("n", "<leader><leader>n", require("mesopotamia.functions").toggle_nums)

map("n", "<leader><leader>c", require("mesopotamia.functions").toggle_conceal)

--================================
-- COMMANDS ----------------------
--================================
local base_group = api.nvim_create_augroup("base", { clear = true })

api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "setlocal textwidth=80", group = base_group })
api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("n", "<leader>mh", require("mesopotamia.functions").markdown_headers)
  end,
  group = base_group,
})
api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.md", "*.txt", "COMMIT_EDITMSG" },
  command = "set wrap linebreak nolist spell spelllang=en_us complete+=kspell",
  group = base_group,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.scala.html" },
  command = "set filetype=scala",
  group = base_group,
})

cmd.colorscheme("kanagawa")

-- Statusline specific highlights
local kanagawa_colors = require("kanagawa.colors").setup()
cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.fujiGray, kanagawa_colors.sumiInk1))
cmd([[hi! link StatusLineNC Comment]])
cmd([[hi! link StatusError DiagnosticError]])
cmd([[hi! link StatusWarn DiagnosticWarn]])
cmd([[hi! link WinSeparator Comment]])

local kanagawa_group = api.nvim_create_augroup("kanagawa", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = kanagawa_group,
})
