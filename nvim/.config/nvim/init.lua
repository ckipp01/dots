--=================================
-- Mesopotamia
--
-- My Neovim Setup
-- Chris Kpp
--
-- https://www.chris-kipp.io
--=================================

local api = vim.api
local fn = vim.fn
local g = vim.g
local map = vim.keymap.set
local opt = vim.opt
local global_opt = vim.opt_global

g.mapleader = ","

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)


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
global_opt.mouse = ""

if g.light then
  global_opt.background = "light"
end

-- window-scoped
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
--opt.foldmethod = "expr"
--opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

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

-- other stuff
map("n", "<leader><leader>p", require("mesopotamia.playground.functions").peek)

map("n", "<leader><leader>j", function ()
  RELOAD("mesopotamia.playground.functions").get_java_version()
end)

map("n", "<leader><leader>s", function()
  RELOAD("mesopotamia.playground.semantic").generate()
end)

map("n", "<leader><leader>e", [[:luafile %<CR>]])

map("n", "<leader><leader>v", require("mesopotamia.playground.functions").get_latest_metals)

map("n", "<leader><leader>hl", vim.show_pos)

map("n", "<leader><leader>n", require("mesopotamia.functions").toggle_nums)

map("n", "<leader><leader>c", require("mesopotamia.functions").toggle_conceal)

-- Telescope mappings
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ layout_strategy = "vertical" })
end)

map("n", "<leader>lg", function()
  require("telescope.builtin").live_grep({ layout_strategy = "vertical" })
end)

map("n", "<leader>gh", function()
  require("telescope.builtin").git_commits({ layout_strategy = "vertical" })
end)

map("n", "<leader>mc", require("telescope").extensions.metals.commands)

map("n", "gds", require("telescope.builtin").lsp_document_symbols)

map("n", "gws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

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
