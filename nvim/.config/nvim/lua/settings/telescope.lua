-- https://github.com/nvim-telescope/telescope.nvim
local M = {}

M.setup = function()
  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "target", "node_modules", "parser.c", "out", "*.min.js" },
      prompt_prefix = "❯",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      mappings = {
        n = {
          ["f"] = actions.send_to_qflist,
        },
      },
    },
  })

  require("telescope").load_extension("fzy_native")
end

-- This is mainly for Metals since we don't respond to "" as a query to get all
-- the symbols. This will first get the input form the user and then execute
-- the query.
M.lsp_workspace_symbols = function()
  vim.ui.input({
    prompt = "Query: ",
  }, function(result)
    if result ~= nil then
      require("telescope.builtin").lsp_workspace_symbols({ query = result })
    end
  end)
end

return M
