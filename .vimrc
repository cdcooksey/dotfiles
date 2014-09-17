set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
set number	      " Turns on line numbers

" Basic Configuration
syntax enable
set encoding=utf-8
set clipboard="unnamed"         " allow copy and paste to system clipboard
set hidden                      " allow changing buffers w/o write
set number                      " show line numbers
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter


"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'    " Nice git things
Plugin 'bling/vim-airline'     " Nice git bottom
"Plugin 'edkolev/tmuxline.vim'  " Nice airline + tmux stuff

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
