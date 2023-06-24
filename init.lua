vim.cmd("set shiftwidth=4")
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
	},
	"VonHeikemen/lsp-zero.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"hrsh7th/nvim-cmp",     -- Required
	"hrsh7th/cmp-nvim-lsp", -- Required
	"L3MON4D3/LuaSnip",
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	"bluz71/nvim-linefly",
	"nvim-tree/nvim-web-devicons",
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
})
vim.cmd("colorscheme moonfly")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local wk=require("which-key")
wk.register({
	f = {
		name = "file",
		f = "Find File",
		g = "Live Grep",
		b = "Buffers",
		h = "Help Tags"
	},
}, { prefix = "<leader>" })

require("telescope").setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
		}
	}
}

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

require'nvim-web-devicons'.setup {
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		}
	};
	color_icons = true;
	default = true;
	strict = true;
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore"
		}
	};
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log"
		}
	};
}

local lsp = require('lsp-zero').preset({})
lsp.extend_cmp()
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = {buffer = event.buf}
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', '<leader>vD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', '<leader>vo', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', '<leader>vr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', '<leader>vs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', '<leader>va', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('n', '<leader>vl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
		vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
		vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) 
	end
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
