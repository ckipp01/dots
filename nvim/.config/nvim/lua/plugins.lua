return require("packer").startup(function(use)
  use({ "glepnir/galaxyline.nvim" })
  use({ "glepnir/lspsaga.nvim" })
  use({ "joshdick/onedark.vim" })
  use({ "junegunn/goyo.vim", opt = true })
  use({ "hrsh7th/nvim-compe", requires = { { "hrsh7th/vim-vsnip" } } })
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    cmd = "MarkdownPreview",
  })
  use({ "kevinhwang91/nvim-bqf" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "liuchengxu/vista.vim" })
  use({ "machakann/vim-sandwich" })
  use({ "mfussenegger/nvim-dap" })
  use({ "neovim/nvim-lspconfig" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "nvim-treesitter/playground" })
  use({ "/Users/ckipp/Documents/lua-workspace/nvim-metals" })
  use({ "/Users/ckipp/Documents/lua-workspace/stylua-nvim" })
  use({ "sheerun/vim-polyglot" })
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-vinegar" })
  use({ "wakatime/vim-wakatime" })
  use({ "wbthomason/packer.nvim", opt = true })
  use({ "windwp/nvim-autopairs" })
  use({ "wlangstroth/vim-racket" })
  use({ "Yggdroot/indentLine" })
end)
