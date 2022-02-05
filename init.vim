call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'jlanzarotta/bufexplorer'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme gruvbox

set number
set relativenumber
set cursorline

set nowrap
set nobackup
set nowb
set noswapfile

set smarttab

set shiftwidth=4
set tabstop=4

augroup FUAD
	autocmd InsertEnter * :set norelativenumber
	autocmd InsertLeave * :set relativenumber
augroup END

" Plugins
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
nnoremap <leader>o :BufExplorer<cr>

" Remaps
let mapleader = ";"

nnoremap <leader>w :w<CR>
nnoremap <silent> Q :nohl<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
