vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set cmdheight=0")
vim.cmd("set autoindent")
vim.cmd("set noswapfile")
vim.cmd("syntax on")
vim.cmd("set termguicolors")
vim.cmd("set hidden")
vim.cmd("set nowrap")

local defaultop={noremap=true,silent=true}
local keymap=vim.api.nvim_set_keymap

vim.g.mapleader=" "
keymap("i","jj","<esc>",defaultop)
keymap("n","<leader>e",":Lexplore<CR><CR>",defaultop)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	"folke/which-key.nvim",
	"nvim-treesitter/nvim-treesitter",
	"bluz71/vim-moonfly-colors",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	"VonHeikemen/lsp-zero.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",     -- Required
	"hrsh7th/cmp-nvim-lsp", -- Required
	"L3MON4D3/LuaSnip",
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	}
})
vim.cmd("colorscheme moonfly")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("telescope").setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
		}
	}
}
require("telescope").load_extension "file_browser"
keymap("n","<leader>e",":Telescope file_browser<CR>",defaultop)


require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

local lsp = require('lsp-zero').preset({})
lsp.extend_cmp()
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
