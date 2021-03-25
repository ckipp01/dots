local M = {}

local function preview_location(_, _, res)
  vim.lsp.util.preview_location(res[1])
end

M.peek = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location)
end

return M

-- function Peek_definition()
--    local params = vim.lsp.util.make_position_params()
--    return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_,
--                                                                              _,
--                                                                              res)
--        vim.lsp.util.preview_location(res[1])
--    end)
-- end
