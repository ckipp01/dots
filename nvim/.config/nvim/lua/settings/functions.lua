local api = vim.api

local function toggle_nums()
  vim.wo.number = not vim.wo.number
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
}
