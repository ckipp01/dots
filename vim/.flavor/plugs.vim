" collection of plugins for vim
call plug#begin('~/.vim/plugged')

" current theme
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

" nnn.vim
Plug 'mcchrish/nnn.vim'
"Plug 'preservim/nerdtree'

" md and adoc
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'habamax/vim-asciidoctor'

" wakatime plugin to track coding activity
Plug 'wakatime/vim-wakatime'

" allow for nice spacing during reading
Plug 'junegunn/goyo.vim'

" git related plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" language specific syntax plugin
Plug 'sheerun/vim-polyglot'
"Plug 'ckipp01/vim-scala'

" help visualize spacing
Plug 'Yggdroot/indentLine'

" help with debugging plugins
Plug 'tpope/vim-scriptease'

" necessary for debugging with coc-metals
Plug 'puremourning/vimspector'

" Document symbol explorer
Plug 'liuchengxu/vista.vim'

" Used for surrounding stuff
Plug 'machakann/vim-sandwich'

Plug 'nvim-treesitter/nvim-treesitter'

" Used for testing Nvim lua plugins
" Just uncomment then when you need them
" Plug 'tjdevries/luvjob.nvim'

if exists("lsp")
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
elseif exists("lsc")
  Plug 'natebosch/vim-lsc'
elseif exists("vnative") && has("nvim")
  Plug 'neovim/nvim-lsp'
  Plug 'haorenW1025/completion-nvim'
  Plug 'haorenW1025/diagnostic-nvim'
  " While I don't want these, snippets aren't workign without it at all for LSP
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  "
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/telescope.nvim'
else
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif

call plug#end()
