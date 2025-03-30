set termguicolors
let g:lightline = {'colorscheme': 'catppuccin_mocha'}

call plug#begin()

" Plugins
Plug 'tpope/vim-sensible'
Plug 'lambdalisue/fern.vim'
Plug 'itchyny/lightline.vim'
Plug 'tribela/vim-transparent'
call plug#end()
silent! colorscheme catppuccin_mocha
