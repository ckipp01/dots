local cmd = vim.cmd
local fn = vim.fn
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
    vim.diagnostic.setqflist({ severity = "E" })
  end)

  map("n", "<leader>aw", function()
    vim.diagnostic.setqflist({ severity = "W" })
  end)

  map("n", "<leader>nd", function()
    vim.diagnostic.goto_next()
  end)

  map("n", "<leader>pd", function()
    vim.diagnostic.goto_prev()
  end)

  map("n", "<leader>ld", function()
    vim.diagnostic.open_float(0, { scope = "line" })
  end)

  fn.sign_define("DiagnosticSignError", { text = "▬", texthl = "DiagnosticError" })
  fn.sign_define("DiagnosticSignWarn", { text = "▬", texthl = "DiagnosticWarn" })
  fn.sign_define("DiagnosticSignInfo", { text = "▬", texthl = "DiagnosticInfo" })
  fn.sign_define("DiagnosticSignHint", { text = "▬", texthl = "DiagnosticHint" })

  -- Since a lot of errors can be super long and multiple lines in Scala, I use
  -- this to split on the first new line and only dispaly the first line as the
  -- virtual text... that is when I actually use virtual text for diagnsostics.
  local diagnostic_foramt = function(diagnostic)
    return string.format("%s: %s", diagnostic.source, f.split_on(diagnostic.message, "\n")[1])
  end

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
  })
end

return {
  setup = setup,
}
