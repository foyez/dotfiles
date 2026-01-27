" ===============================
" Basic Vim Settings
" ===============================
set nocompatible       " Use Vim defaults, not Vi
set number             " Show line numbers
set relativenumber     " Relative line numbers
set ruler              " Show cursor position
set showcmd            " Display incomplete commands
set cursorline         " Highlight current line
set hidden             " Allow buffer switching without saving
set clipboard=unnamedplus " Use system clipboard
set mouse=a            " Enable mouse support
set encoding=utf-8

" ===============================
" Editing Improvements
" ===============================
set tabstop=4          " Width of a tab character
set shiftwidth=4       " Indentation width
set expandtab          " Convert tabs to spaces
set smartindent        " Auto-indent new lines
set autoindent
set wrap               " Wrap long lines
set linebreak          " Break lines at word boundary

" ===============================
" Searching
" ===============================
set hlsearch           " Highlight search results
set incsearch          " Show match while typing
set ignorecase         " Case-insensitive search
set smartcase          " Except if uppercase letters present

" ===============================
" Visual Enhancements
" ===============================
syntax on              " Enable syntax highlighting
colorscheme desert     " Light, clean colors (change as you like)
set background=dark
set showmatch           " Highlight matching brackets
set signcolumn=yes      " Avoid text shifting

" ===============================
" Shortcuts / Mappings
" ===============================
" Save and quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>

" Quickly switch buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Window splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Paste without replacing clipboard
vnoremap <leader>p "_dP

" ===============================
" Plugins (Optional, if you use Vim-Plug)
" ===============================
" call plug#begin('~/.vim/plugged')
" Plug 'preservim/nerdtree'          " File explorer
" Plug 'junegunn/fzf'                " Fuzzy finder
" Plug 'tpope/vim-fugitive'          " Git integration
" Plug 'airblade/vim-gitgutter'      " Git diff in gutter
" Plug 'dense-analysis/ale'           " Linting/formatting
" call plug#end()
