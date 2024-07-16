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
	use('paulo-granthon/hyper.nvim')
	use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-jdtls'
  use 'nvim-lua/plenary.nvim'
	use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'},}
	use 'lewis6991/gitsigns.nvim'
	use 'romgrk/barbar.nvim'
end)

-- Enable syntax highlighting and set colorscheme
vim.cmd('syntax enable')
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd([[ colorscheme hyper ]])

-- Set number and relative number
vim.cmd [[
    set number
    set relativenumber
]]
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- Key Maps
vim.api.nvim_set_keymap('n', '9', 'o<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '(', 'O<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>]', ':bnext <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>[', ':bprevious <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { silent = true })
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { silent = true })
vim.api.nvim_exec([[
  augroup CustomYankToClipboard
    autocmd!
    autocmd FileType * vnoremap <silent> <leader>y "+y
  augroup END
]], false)

-- Set tabstop and shiftwidth
vim.cmd [[
    set tabstop=2
    set shiftwidth=2
]]

-- Configure Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "python", "java", "javascript" }, -- Only use parsers that are maintained
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  -- Add other modules and settings here
}


-- Configure Telescope
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-b>"] = actions.file_vsplit,
            },
            n = {
                ["<C-b>"] = actions.file_vsplit,
            },
        }
    },
}

-- Key mappings for Telescope commands
vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require(\'telescope.builtin\').live_grep()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':lua require(\'telescope.builtin\').buffers()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':lua require(\'telescope.builtin\').help_tags()<CR>', { silent = true })

-- Define key mapping for opening Telescope's find_files
vim.api.nvim_set_keymap('n', '<leader>ff', ':lua require\'telescope.builtin\'.find_files(require(\'telescope.themes\').get_dropdown({ previewer = false }))<CR>', { silent = true })

-- Define key mapping for opening Telescope's live_grep
vim.api.nvim_set_keymap('n', '<C-t>', ':Telescope live_grep<CR>', { silent = true })



-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

dofile(vim.fn.stdpath('config') .. '/barba.lua')

