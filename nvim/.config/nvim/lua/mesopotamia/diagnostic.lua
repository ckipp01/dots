local cmd = vim.cmd
local f = require("mesopotamia.functions")
local map = vim.keymap.set

local setup = function()
  cmd([[hi! DiagnosticUnderlineError cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineWarn cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineInfo cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineHint cterm=NONE gui=underline guifg=NONE]])

  map("n", "<leader>aa", function()
    vim.diagnostic.setqflist()
  end)

  map("n", "<leader>ae", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
  end)

  map("n", "<leader>aw", function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
  end)

  map("n", "<leader>nd", function()
    vim.diagnostic.goto_next()
  end)

  map("n", "<leader>pd", function()
    vim.diagnostic.goto_prev()
  end)

  map("n", "<leader>ld", function()
    vim.diagnostic.open_float({ scope = "line" })
  end)

  -- Since a lot of errors can be super long and multiple lines in Scala, I use
  -- this to split on the first new line and only dispaly the first line as the
  -- virtual text... that is when I actually use virtual text for diagnsostics.
  local diagnostic_foramt = function(diagnostic)
    return string.format("%s: %s", diagnostic.source, f.split_on(diagnostic.message, "\n")[1])
  end

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "▬",
        [vim.diagnostic.severity.WARN] = "▬",
        [vim.diagnostic.severity.INFO] = "▬",
        [vim.diagnostic.severity.HINT] = "▬",
      }
    }
  })
end

return {
  setup = setup,
}
