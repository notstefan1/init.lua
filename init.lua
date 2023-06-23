
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent")
vim.cmd("set noswapfile")
vim.cmd("syntax on")
vim.cmd("set termguicolors")
vim.cmd("set hidden")
vim.cmd("set nowrap")
vim.opt.background="dark"

local defaultop={noremap=true,silent=true}
local keymap=vim.api.nvim_set_keymap

vim.g.mapleader=" "
keymap("i","jj","<esc>",defaultop)
keymap("n","<leader>e",":Lexplore<CR>",defaultop)

vim.cmd("let g:netrw_winsize=18")
vim.cmd("let g:netrw_banner=0")
vim.cmd("let g:netrw_liststyle=3")
vim.cmd("let g:netrw_preview=1")
vim.cmd("let g:netrw_keepdir=1")
vim.cmd("let g:netrw_altv=1")

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { "bluz71/vim-moonfly-colors", as = "moonfly" }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		{'neovim/nvim-lspconfig'},             
		{'williamboman/mason.nvim'},           
		{'williamboman/mason-lspconfig.nvim'}, 
		{'hrsh7th/nvim-cmp'},         
		{'hrsh7th/cmp-nvim-lsp'},     
		{'hrsh7th/cmp-buffer'},       
		{'hrsh7th/cmp-path'},         
		{'saadparwaiz1/cmp_luasnip'}, 
		{'hrsh7th/cmp-nvim-lua'},     
		{'L3MON4D3/LuaSnip'},             
		{'rafamadriz/friendly-snippets'}, 
	  }
	}
end)

vim.cmd("colorscheme moonfly")
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})
lsp.nvim_workspace()
lsp.setup()
