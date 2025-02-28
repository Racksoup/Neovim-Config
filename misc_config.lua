-- Set number and relative number
vim.cmd [[
	set breakindent
	set linebreak	
	set number
	set tabstop=2
	set shiftwidth=2
	set expandtab
]]

-- Nvim-Tree
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

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "python", "java", "javascript" }, 
  highlight = {
    enable = true,              
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like HTML tags
    max_file_lines = 1000, -- Disable for big files
  },
}

-- Telescope
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

-- Scrollbar
require('scrollview').setup({
  excluded_filetypes = {'nerdtree'},
  current_only = true,
	sticky = true,
  base = 'right',
  signs_on_startup = {'all'},
  diagnostics_severities = {vim.diagnostic.severity.ERROR}
})
