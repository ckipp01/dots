local pattern = 'scala'
local cmd = { 'metals' }
-- Add files/folders here that indicate the root of a project
local root_markers = { 'inlay.worksheet.sc', 'build.sbt' }

local settings = {
  metals = {
    enableSemanticHighlighting = false,
    showInferredType = true
  }
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = pattern,
  callback = function(args)
    local match = vim.fs.find(root_markers, { path = args.file, upward = true })[1]
    local root_dir = match and vim.fn.fnamemodify(match, ':p:h') or nil
    vim.lsp.start({
      name = 'metals',
      cmd = cmd,
      root_dir = root_dir,
      settings = settings
    })
  end
})
