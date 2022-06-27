return require("packer").startup(function(use)
	use({ "gurpreetatwal/vim-avro" })
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
	use({ "jbyuki/venn.nvim" })
	use({ "kevinhwang91/nvim-bqf" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = require("mesopotamia.plugins.indent_blankline").setup(),
	})
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
	use({ "nvim-treesitter/nvim-treesitter", config = require("mesopotamia.plugins.treesitter").setup() })
	use({ "nvim-treesitter/playground" })
	use({
		"/Users/ckipp/Documents/lua-workspace/nvim-metals",
		requires = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
	})
	use({ "/Users/ckipp/Documents/lua-workspace/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } })
	use({ "/Users/ckipp/Documents/lua-workspace/stylua-nvim" })
	use({ "/Users/ckipp/Documents/lua-workspace/scala-utils.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({ "rebelot/kanagawa.nvim" })
	use({ "simrat39/rust-tools.nvim" })
	use({ "sheerun/vim-polyglot" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-vinegar" })
	use({ "wakatime/vim-wakatime" })
	use({ "wbthomason/packer.nvim" })
	use({ "windwp/nvim-autopairs", config = require("nvim-autopairs").setup() })
end)
