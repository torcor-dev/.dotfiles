set nocompatible

set clipboard=unnamed

set nu " line numbers
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab " turn tabs into spaces
set autoindent
set smartindent
set backspace=indent,eol,start "delete in insert
set hlsearch
set ignorecase
set smartcase

let mapleader = ' '

"F2 and F3 to move to next/previous buffer
map <F2> :bprev<CR>
map <F3> :bnext<CR>

syntax enable


if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/Colorizer'
Plug 'davidhalter/jedi-vim'
Plug 'vim-python/python-syntax'
Plug 'lifepillar/vim-solarized8'
call plug#end()

"let g:dracula_colorterm = 0
set background=light
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
colorscheme solarized8_flat

filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:python_highlight_all = 1

"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline_theme='fruit_punch'

" FZF

let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
