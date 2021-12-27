return require("packer").startup(function(use)
  use({ "ckipp01/nvim-jvmopts" })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
    config = require("mesopotamia.plugins.cmp").setup(),
  })
  use({ "kevinhwang91/nvim-bqf" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = require("gitsigns").setup(),
  })
  use({ "liuchengxu/vista.vim" })
  use({ "machakann/vim-sandwich" })
  use({ "neovim/nvim-lspconfig" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = require("mesopotamia.plugins.telescope").setup(),
  })
  use({ "nvim-treesitter/nvim-treesitter", config = require("mesopotamia.plugins.telescope").setup() })
  use({ "nvim-treesitter/playground" })
  use({
    "/Users/ckipp/Documents/lua-workspace/nvim-metals",
    requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  })
  use({ "/Users/ckipp/Documents/lua-workspace/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } })
  use({ "/Users/ckipp/Documents/lua-workspace/stylua-nvim" })
  use({ "/Users/ckipp/Documents/lua-workspace/scala-utils.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "rebelot/kanagawa.nvim" })
  use({ "sheerun/vim-polyglot" })
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-vinegar" })
  use({ "wakatime/vim-wakatime" })
  use({ "wbthomason/packer.nvim" })
  use({ "windwp/nvim-autopairs", config = require("nvim-autopairs").setup() })
  use({ "Yggdroot/indentLine" })
end)
