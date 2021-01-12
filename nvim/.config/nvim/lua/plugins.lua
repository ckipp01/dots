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
    use {'kyazdani42/nvim-web-devicons'}
    use {'liuchengxu/vista.vim'}
    use {'neovim/nvim-lspconfig'}
    use {'norcalli/nvim-colorizer.lua'}
    use {
        'nvim-lua/completion-nvim',
        requires = {
            {'hrsh7th/vim-vsnip', opt = true},
            {'hrsh7th/vim-vsnip-integ', opt = true}
        }
    }
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'savq/paq-nvim', opt = true}
    use {'/Users/ckipp/Documents/lua-workspace/nvim-metals'}
    use {'sheerun/vim-polyglot'}
    use {'tpope/vim-fugitive'}
    use {'wakatime/vim-wakatime'}
    use {'wbthomason/packer.nvim', opt = true}
    use {'windwp/nvim-autopairs'}
    use {'Yggdroot/indentLine'}
end)
