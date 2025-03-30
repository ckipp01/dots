---@diagnostic disable: missing-fields
local api = vim.api
local cmd = vim.cmd

return require("lazy").setup({
  {
    "folke/neodev.nvim",
    lazy = true
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime"
  },
  {
    "j-hui/fidget.nvim",
    opts = {}
  },
  { "kevinhwang91/nvim-bqf" }, -- TODO figure out what we could trigger this on.
  { "github/copilot.vim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
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
        },
        scope = {
          enabled = false
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
    dir = "/Users/ckipp/Documents/lua-workspace/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    }
  },
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
      local kanagawa_colors = require("kanagawa.colors").setup()

      cmd(string.format([[hi! StatusLine guifg=%s guibg=%s]], kanagawa_colors.palette.fujiWhite,
        kanagawa_colors.palette.sumiInk3))

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
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' }
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' }
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      }
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },
  { "tpope/vim-fugitive" },
  { "wakatime/vim-wakatime" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
})
