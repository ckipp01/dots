local M = {}

M.setup = function()
  local cmp = require("cmp")
  cmp.setup({
    sources = {
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "vsnip" },
    },
    snippet = {
      expand = function(args)
        -- Comes from vsnip
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      -- None of this made sense to me when first looking into this since there
      -- is no vim docs, but you can't have select = true here _unless_ you are
      -- also using the snippet stuff. So keep in mind that if you remove
      -- snippets you need to remove this select
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
  })
end

return M
