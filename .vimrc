set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set hidden
syntax on

let mapleader = ","

imap jk <esc>
map gn :bnext<cr>
map gp :bprevious<cr>
map gd :bdelete<cr>

inoremap " ""<left>
inoremap ' ''<left>
inoremap {<cr> {<cr>}<esc>O

nnoremap <leader>r :w<cr>:!clear && cc % && ./a.out<cr>

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'garbas/vim-snipmate'
Plug 'marcweber/vim-addon-mw-utils'
call plug#end()

colorscheme gruvbox
"colorscheme quiet
