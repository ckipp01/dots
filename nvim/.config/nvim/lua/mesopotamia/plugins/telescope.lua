local map = vim.keymap.set

local setup = function()
  map("n", "<leader>ff", function()
    require("telescope.builtin").find_files({ layout_strategy = "vertical" })
  end)

  map("n", "<leader>fd", function()
    require("telescope.builtin").find_files({ cwd = "~/dots/nvim/.config/nvim", layout_strategy = "vertical" })
  end)

  map("n", "<leader>ftd", function()
    require("telescope.builtin").find_files({ cwd = "~/Documents/notes", layout_strategy = "vertical" })
  end)

  map("n", "<leader>lg", function()
    require("telescope.builtin").live_grep({ layout_strategy = "vertical" })
  end)

  map("n", "<leader>gh", function()
    require("telescope.builtin").git_commits({ layout_strategy = "vertical" })
  end)

  map("n", "<leader>mc", require("telescope").extensions.metals.commands)

  map("n", "<leader>cc", require("telescope").extensions.coursier.complete)

  map("n", "gds", require("telescope.builtin").lsp_document_symbols)

  map("n", "gws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

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
