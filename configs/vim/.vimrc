set rnu
set termguicolors
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set scrolloff=5
"set cursorline
set clipboard=unnamedplus
set undofile
"set colorcolumn=80

nnoremap _ :Explore<CR>

let g:lightline = {'colorscheme': 'catppuccin_mocha'}
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>

" Plugins
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-sensible'
Plug 'lambdalisue/fern.vim'
Plug 'itchyny/lightline.vim'
Plug 'tribela/vim-transparent'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
colorscheme catppuccin_mocha
