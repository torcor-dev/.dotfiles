let g:python3_host_prog = '~/.virtualenvs/py3nvim/bin/python'

set clipboard+=unnamedplus
set relativenumber

set tabstop=4
set shiftwidth=4
set expandtab

set smartcase

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme * highlight clear SignColumn
set termguicolors
highlight clear SignColumn
highlight Normal guibg=none
highlight NonText guibg=none

let mapleader = ' '

map <F2> :bprev<CR>
map <F3> :bnext<CR>
nnoremap Y y$

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'DougBeney/pickachu'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

source ~/.config/nvim/fzf_config.vim
source ~/.config/nvim/coc_config.vim
source ~/.config/nvim/dadbod_config.vim
source ~/.config/nvim/airline_config.vim

colorscheme dracula
