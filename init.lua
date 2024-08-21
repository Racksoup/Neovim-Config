-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load plugins
vim.cmd [[call plug#begin('~/.local/share/nvim/plugged')]]
vim.cmd [[
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
		Plug 'Mofiqul/vscode.nvim'
		Plug 'zootedb0t/citruszest.nvim'
]]
vim.cmd [[call plug#end()]]

-- Automatically install Packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Auto-reload Neovim whenever you save the init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Packer configuration
packer.init({
  -- Packer can manage itself
  package_root = vim.fn.stdpath('data')..'/site/pack',
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua',
})

-- Add your plugins here
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
	use({ 'liminalminds/icecream.nvim', as = 'icecream' })
	use "rebelot/kanagawa.nvim"
  use {'mfussenegger/nvim-jdtls', requires = {'mfussenegger/nvim-dap'}}
  use 'nvim-lua/plenary.nvim'
	use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'},}
	use 'lewis6991/gitsigns.nvim'
	use 'romgrk/barbar.nvim'
	use 'dstein64/nvim-scrollview'
	use('mrjones2014/smart-splits.nvim')
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
	use 'onsails/lspkind.nvim'
	use 'rafamadriz/friendly-snippets'
	use ({"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	})
end)

-- Other Configs
dofile(vim.fn.stdpath('config') .. '/misc_config.lua')
dofile(vim.fn.stdpath('config') .. '/keymap.lua')
dofile(vim.fn.stdpath('config') .. '/barbar.lua')
dofile(vim.fn.stdpath('config') .. '/colors.lua')
dofile(vim.fn.stdpath('config') .. '/cmp.lua')
