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

local function split_on(s, delimiter)
  local result = {}
  local from = 1
  local delim_from, delim_to = string.find(s, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(s, from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = string.find(s, delimiter, from)
  end
  table.insert(result, string.sub(s, from))
  return result
end

return {
  map = map,
  split_on = split_on,
  toggle_nums = toggle_nums,
  toggle_conceal = toggle_conceal,
}
