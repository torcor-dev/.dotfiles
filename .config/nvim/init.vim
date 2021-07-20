let g:python3_host_prog = '~/.virtualenvs/py3nvim/bin/python'

set clipboard+=unnamedplus
set nu
set rnu

set tabstop=4
set shiftwidth=4
set expandtab

set ignorecase
set smartcase

set hidden

au ColorScheme * hi Normal ctermbg=none guibg=none
" au ColorScheme * highlight clear SignColumn
set termguicolors
" highlight clear SignColumn
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
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'DougBeney/pickachu'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'LunarWatcher/auto-pairs', { 'tag': '*' }
"Plug 'chemzqm/vim-jsx-improve'
"Plug 'marko-cerovac/material.nvim'
" Plug 'yonlu/omni.vim'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'RishabhRD/popfix'
" Plug 'RishabhRD/nvim-lsputils'
call plug#end()

source ~/.config/nvim/fzf_config.vim
source ~/.config/nvim/coc_config.vim
source ~/.config/nvim/dadbod_config.vim
source ~/.config/nvim/airline_config.vim
" source ~/.config/nvim/diagnostic_conf.vim
" lua require("lsp_config")
lua require("treesitter_config")

colorscheme purple_winter

autocmd FileType javascriptreact setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab

" " Completion
" " Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" 
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" " Avoid showing message extra message when using completion
" set shortmess+=c
" 
" " nvim-lsputils
" lua <<EOF
" vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
" vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
" vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
" vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
" vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
" vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
" vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
" vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
" EOF
"
"

