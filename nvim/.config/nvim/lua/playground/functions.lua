local function preview_location(_, _, res)
  vim.lsp.util.preview_location(res[1])
end

local function peek()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location)
end

local ns = vim.api.nvim_create_namespace("playground")

local function set_ext()
  local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_extmark(0, ns, lnum, 0, {})
end

local function get_exts()
  local all = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
  print(vim.inspect(all))
end

local function visual_selection_range()
  --local test = vim.lsp.util.make_given_range_params()

  --local test = vim.lsp.util.make_range_params()
  local _, start_line_num, start_col_num, _ = unpack(vim.fn.getpos("'<"))
  local a = vim.api.nvim_buf_get_mark(0, '<')
  local b = vim.fn.getpos("'<")
  local b = vim.fn.getpos("'>")

  P(a)
  P(b)
  --if csrow < cerow or (csrow == cerow and cscol <= cecol) then
  --  return csrow - 1, cscol - 1, cerow - 1, cecol
  --else
  --  return cerow - 1, cecol - 1, csrow - 1, cscol
  --end
end

return {
  peek = peek,
  set_ext = set_ext,
  get_exts = get_exts,
  visual_selection_range = visual_selection_range,
}
