local cmd = vim.cmd
local fn = vim.fn

local setup = function()
  cmd([[hi! DiagnosticUnderlineError cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineWarn cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineInfo cterm=NONE gui=underline guifg=NONE]])
  cmd([[hi! DiagnosticUnderlineHint cterm=NONE gui=underline guifg=NONE]])

  fn.sign_define("DiagnosticSignError", { text = "▬", texthl = "DiagnosticError" })
  fn.sign_define("DiagnosticSignWarn", { text = "▬", texthl = "DiagnosticWarn" })
  fn.sign_define("DiagnosticSignInfo", { text = "▬", texthl = "DiagnosticInfo" })
  fn.sign_define("DiagnosticSignHint", { text = "▬", texthl = "DiagnosticHint" })

  -- Since a lot of errors can be super long and multiple lines in Scala, I use
  -- this to split on the first new line and only dispaly the first line as the
  -- virtual text... that is when I actually use virtual text for diagnsostics
  local diagnostic_foramt = function(diagnostic)
    return string.format("%s: %s", diagnostic.source, f.split_on(diagnostic.message, "\n")[1])
  end

  --vim.diagnostic.config({ virtual_text = { format = diagnostic_foramt }, severity_sort = true })
  vim.diagnostic.config({ virtual_text = false })
end

return {
  setup = setup,
}
