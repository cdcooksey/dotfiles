set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set termguicolors
 if has('nvim')
" https://github.com/neovim/neovim/wiki/FAQ
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif

set background=dark
set termguicolors
syntax enable
set foldmethod=indent
