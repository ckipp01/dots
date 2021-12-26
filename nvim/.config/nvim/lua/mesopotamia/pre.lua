local download_packer = function()
  local choice = vim.fn.inputlist({ "Looks like you need to install packer.", "1. yes", "2. no" })

  if choice ~= 1 then
    return
  end

  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print("Downloading packer.nvim...")
  print(out)
  print("You'll need to restart now and run :PackerInstall")
end

return function()
  if not pcall(require, "packer") then
    download_packer()

    return true
  end

  return false
end
