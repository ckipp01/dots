local api = vim.api

local function toggle_nums()
  vim.wo.number = not vim.wo.number
end

local function toggle_conceal()
  local current = vim.wo.conceallevel
  if current == 2 then
    vim.wo.conceallevel = 0
  else
    vim.wo.conceallevel = 2
  end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

return {
  map = map,
  toggle_nums = toggle_nums,
  toggle_conceal = toggle_conceal,
}
