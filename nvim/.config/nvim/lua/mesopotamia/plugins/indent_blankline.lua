local setup = function()
  require("indent_blankline").setup({
    char = "⋅",
    filetype_exclude = { "help" },
  })
end

return {
  setup = setup,
}
