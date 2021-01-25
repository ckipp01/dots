return require('packer').startup(function(use)
    use {'airblade/vim-gitgutter'}
    use {'andrejlevkovitch/vim-lua-format'}
    use {'glepnir/galaxyline.nvim'}
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
    use {'joshdick/onedark.vim'}
    use {'junegunn/goyo.vim', opt = true}
    use {'kevinhwang91/nvim-bqf'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'liuchengxu/vista.vim'}
    use {'neovim/nvim-lspconfig'}
    use {'norcalli/nvim-colorizer.lua'}
    use {
        'nvim-lua/completion-nvim',
        requires = {{'hrsh7th/vim-vsnip'}, {'hrsh7th/vim-vsnip-integ'}}
    }
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'scalameta/nvim-metals'}
    -- use {'/Users/ckipp/Documents/lua-workspace/nvim-metals'}
    use {'sheerun/vim-polyglot'}
    use {'tpope/vim-fugitive'}
    use {'wakatime/vim-wakatime'}
    use {'wbthomason/packer.nvim', opt = true}
    use {'windwp/nvim-autopairs'}
    use {'wlangstroth/vim-racket'}
    use {'Yggdroot/indentLine'}
end)
