set number
set relativenumber
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
set scrolloff=4
set ignorecase
set hidden
set noswapfile

syntax on

let mapleader = ","

" auto closing
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<cr> {<cr><bs>}<esc>O

inoremap jk <esc>

nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>
nnoremap gd :bdelete<cr>

" turn off search highlighting
nnoremap ,<space> :nohlsearch <cr>

" compile and run a C program
autocmd FileType c nnoremap <buffer> <leader>r :w<cr>:exec '!clear && cc' shellescape(@%, 1) '&& ./a.out'<cr>

" hide terminal buffer from buffer list (executed when the buffer is left (BufLeave))
autocmd BufLeave * if &buftype=="terminal" | setlocal nobuflisted | endif

" align backslashes for C macros
nnoremap <leader>a :call Align('\')<cr>

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'garbas/vim-snipmate'
Plug 'marcweber/vim-addon-mw-utils'
call plug#end()

colorscheme gruvbox

" align the 'c' character by the right-most column of the visual selection
function! Align(c)
    if strlen(a:c) != 1
        echo "ERROR: argument must be a single character"
        return
    endif
    let start = line("'<")
    let end = line("'>")
    for line in range(start, end)
        call cursor(line, 1)
        " trim right
        execute "s/\\s\\+$//e"
        execute "normal! $x"
        " trim right
        execute "s/\\s\\+$//e"
    endfor
    let aligncol = GetRightmostVisualCol() + 1
    for line in range(start, end)
        let rightmostcharcol = strlen(getline(line)) - 1
        let spacecnt = aligncol - rightmostcharcol - 1
        call cursor(line, 1)
        execute "normal! " . spacecnt . "A a" . a:c
    endfor
  function! GetRightmostVisualCol()
      let start = line("'<")
      let end = line("'>")
      let line = start
      let maxlen = 0
      while line <= end
          let currlen = len(getline(line))
          let maxlen = maxlen < currlen ? currlen : maxlen
          let line += 1
      endwhile
      return maxlen
  endfunction
endfunction
