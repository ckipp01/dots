local f = require("mesopotamia.functions")
local map = f.map

local setup = function()
  map("n", "<leader>ff", [[<cmd>lua require("telescope.builtin").find_files({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>lg", [[<cmd>lua require("telescope.builtin").live_grep({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").file_browser({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>gh", [[<cmd>lua require("telescope.builtin").git_commits({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>mc", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
  map("n", "<leader>cc", [[<cmd>lua RELOAD("telescope").extensions.coursier.complete()<CR>]])

  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { "target", "node_modules", "parser.c", "out", "%.min.js" },
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

return {
  setup = setup,
}
