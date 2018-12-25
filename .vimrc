" Install Vundle first:  $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Install Pathongen 2nd: READ THIS: https://github.com/tpope/vim-pathogen
" Install NerdTree with Pathogen. READ THIS: https://github.com/scrooloose/nerdtree

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

" Turn off -- INSERT -- display as lightline will show it instead
set noshowmode

"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim



call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'atelierbram/Base2Tone-vim'  " https://github.com/atelierbram/Base2Tone-vim colorscheme
Plugin 'semibran/vim-colors-synthetic' " https://github.com/semibran/vim-colors-synthetic colorscheme
Plugin 'itchyny/lightline.vim'      " Newer powerline replacement
Plugin 'edkolev/tmuxline.vim'       " Nice airline + tmux stuff
Plugin 'tpope/vim-fugitive'         " Nice git things
Plugin 'tpope/vim-surround'         " Adds ending things
Plugin 'tpope/vim-endwise'          " Adds end to keyword things automatically.
Plugin 'kchmck/vim-coffee-script'   " Please work. I need this one.
Plugin 'leafgarland/typescript-vim' " https://github.com/leafgarland/typescript-vim
Plugin 'w0rp/ale'                   " Code linter, https://github.com/w0rp/ale

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Pathogen settings.  Installation instructions here: https://github.com/tpope/vim-pathogen

syntax on
filetype plugin indent on    " required
execute pathogen#infect()
call pathogen#helptags()

let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['prettier', 'eslint'],
    \   'typescript': ['prettier', 'tslint'],
    \   'ruby': ['rubocop', 'standardrb'],
    \}

let g:ale_fix_on_save = 0 " Set this to 1 if you wanna run :ALEFix on save

" Set lightline theme
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
