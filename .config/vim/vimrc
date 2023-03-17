" Install Pathongen 2nd: READ THIS: https://github.com/tpope/vim-pathogen
" Install NerdTree with Pathogen. READ THIS: https://github.com/scrooloose/nerdtree

" set nocompatible      " We're running Vim, not Vi!
" syntax on             " Enable syntax highlighting
set number	      " Turns on line numbers

" Basic Configuration
nnoremap <c-p> :Files<CR>
syntax enable
set encoding=utf-8
set clipboard="unnamed"         " allow copy and paste to system clipboard
set hidden                      " allow changing buffers w/o write
set number                      " show line numbers
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

" Code folding configuration
"    zo opens a fold at the cursor.
"    zShift+o opens all folds at the cursor.
"    zc closes a fold at the cursor.
"    zm increases the foldlevel by one.
"    zShift+m closes all open folds.
"    zr decreases the foldlevel by one.
"    zShift+r decreases the foldlevel to zero -- all folds will be open.
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
" end code folding configuration

"" Whitespace
set nowrap                      " don't wrap lines
" set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
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

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-markdown'
Plug 'thoughtbot/vim-rspec'
Plug 'skalnik/vim-vroom'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim' " Nice airline + tmux stuff
Plug 'edkolev/tmuxline.vim' " Nice git things
Plug 'kchmck/vim-coffee-script' " https://github.com/leafgarland/typescript-vim
Plug 'leafgarland/typescript-vim' " Code linter, https://github.com/w0rp/ale
Plug 'w0rp/ale' " Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
Plug 'noprompt/vim-yardoc'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'preservim/vim-indent-guides'
call plug#end()

syntax on
filetype plugin indent on    " required
set autoindent expandtab tabstop=2 shiftwidth=2
let g:indent_guides_enable_on_vim_startup = 1 " enable indent guides by default, :IndentGuidesDisable to disable

let g:airline_theme='molokai'
let g:seoul256_background = 233

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
      \ 'colorscheme': 'powerline',
      \ }

