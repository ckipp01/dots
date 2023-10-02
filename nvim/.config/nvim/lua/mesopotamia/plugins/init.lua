---@diagnostic disable: missing-fields
local api = vim.api
local cmd = vim.cmd

return require("lazy").setup({
  {
    "folke/neodev.nvim",
    lazy = true
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    config = function()
      require("mesopotamia.plugins.cmp").setup()
    end
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },
  { "kevinhwang91/nvim-bqf" }, -- TODO figure out what we could trigger this on.
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "⋅",
        },
        exclude = {
          filetypes = { "help" }
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle"
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = function()
      require("mesopotamia.plugins.telescope").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("mesopotamia.plugins.treesitter").setup()
    end
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle"
  },
  {
    dir = "/Users/ckipp/Documents/lua-workspace/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  },
  { dir = "/Users/ckipp/Documents/lua-workspace/stylua-nvim" },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })

      vim.cmd.colorscheme("kanagawa")
      --vim.cmd.colorscheme("kanagawa-lotus")

      -- Statusline specific highlights
      local kanagawa_colors = require("kanagawa.colors").setup()
      --local kanagawa_colors = require("kanagawa.colors").setup({ theme = 'lotus' })

      cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.palette.fujiWhite,
        kanagawa_colors.palette.sumiInk3))

      -- For light theme
      -- cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.palette.lotusInk2,
      --   kanagawa_colors.palette.lotusWhite3))

      cmd([[hi! link StatusLineNC Comment]])
      cmd([[hi! link StatusError DiagnosticError]])
      cmd([[hi! link StatusWarn DiagnosticWarn]])
      cmd([[hi! link WinSeparator Comment]])

      local kanagawa_group = api.nvim_create_augroup("kanagawa", { clear = true })
      api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
          vim.highlight.on_yank()
        end,
        group = kanagawa_group,
      })
    end
  },
  { "simrat39/rust-tools.nvim" },
  { "stevearc/dressing.nvim",  event = "VeryLazy" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-vinegar" },
  { "wakatime/vim-wakatime" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
})
