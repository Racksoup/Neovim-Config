-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Automatically install Packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path
  })
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
  package_root = vim.fn.stdpath('data')..'/site/pack',
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua',
})

-- Add your plugins
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- packer manages itself
  use 'nvim-lua/plenary.nvim'
  use 'ThePrimeagen/vim-be-good'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.6'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'Mofiqul/vscode.nvim'
  use 'zootedb0t/citruszest.nvim'

  -- Your other plugins
  use {'liminalminds/icecream.nvim', as = 'icecream'}
  use 'rebelot/kanagawa.nvim'
  use {'mfussenegger/nvim-jdtls', requires = {'mfussenegger/nvim-dap'}}
  use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}}
  use 'lewis6991/gitsigns.nvim'
  use 'romgrk/barbar.nvim'
  use 'dstein64/nvim-scrollview'
  use 'mrjones2014/smart-splits.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind.nvim'
  use 'rafamadriz/friendly-snippets'
  use {
    "ziontee113/color-picker.nvim",
    config = function()
      require("color-picker").setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" }, -- load only for markdown files
  })
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }
end)

-- Python config
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})


-- Load other config files
dofile(vim.fn.stdpath('config') .. '/misc_config.lua')
dofile(vim.fn.stdpath('config') .. '/keymap.lua')
dofile(vim.fn.stdpath('config') .. '/colors.lua')
dofile(vim.fn.stdpath('config') .. '/cmp.lua')

