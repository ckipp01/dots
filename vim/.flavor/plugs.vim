call plug#begin('~/.vim/plugged')

" current theme
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

" md and adoc
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" wakatime plugin to track coding activity
Plug 'wakatime/vim-wakatime'

" allow for nice spacing during reading
Plug 'junegunn/goyo.vim'

" git related plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" language specific syntax plugin
Plug 'sheerun/vim-polyglot'

" help visualize spacing
Plug 'Yggdroot/indentLine'

" necessary for debugging with coc-metals
" Plug 'puremourning/vimspector'

" Used for surrounding stuff
"Plug 'machakann/vim-sandwich'

"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
call plug#end()
