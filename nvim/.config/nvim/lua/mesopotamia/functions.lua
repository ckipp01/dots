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

-- TODO make this generic so I can reuse this
local function replace_java_converters()
  local line_contents = vim.api.nvim_get_current_line()

  local new_conents = line_contents:gsub(
    "import scala.collection.JavaConverters._",
    "import scala.jdk.CollectionConverters._"
  )

  local line = vim.fn.line(".") - 1

  vim.api.nvim_buf_set_text(0, line, 0, line, #line_contents, { new_conents })
end

local function markdown_headers()
  vim.cmd([[vimgrep /^#/ % | copen]])
end

return {
  map = map,
  markdown_headers = markdown_headers,
  replace_java_converters = replace_java_converters,
  split_on = split_on,
  toggle_nums = toggle_nums,
  toggle_conceal = toggle_conceal,
}
