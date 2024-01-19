vim.cmd([[
set number
set relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set autoindent
set nowrap
set nohlsearch
set noswapfile
set termguicolors
colo oxocarbon
]])

local defaultops={silent=true,noremap=true}

vim.g.mapleader=" "
vim.keymap.set('i','jj','<Esc>',defaultops)
vim.keymap.set('n','<Leader>e',':Lex<CR>',defaultops)
vim.cmd([[
let g:netrw_keepdir = 0
let g:netrw_winsize = 20
let g:netrw_banner = 0
]])




