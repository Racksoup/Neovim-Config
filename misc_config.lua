-- Set number and relative number
vim.cmd [[
	set breakindent
	set linebreak	
	set number
	set tabstop=2
	set shiftwidth=2
	set expandtab
]]

-- fix indent new line issue
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.cmd("filetype plugin indent on")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Nvim-Tree
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 35,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      resize_window = false,
    },
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

-- treesitter fold
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- Optional: start with everything unfolded
vim.o.foldlevel = 99

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

vim.g.barbar_auto_setup = false
require("barbar").setup({
  auto_hide = false,
  hide = {
    inactive = true,
  },
  maximum_padding = 0,
  minimum_padding = 0,
  maximum_length = 30,
  minimum_length = 0,
  icons = {
    buffer_index = true,
    buffer_number = false,
    button = '',
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      custom_colors = true,
      enabled = false,
    },
    separator = {left = '▎', right = ''},
    separator_at_end = true,
    modified = {button = ' ●'},
    pinned = {button = ' *', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×', buffer_index = true},
    visible = {modified = {buffer_number = false}},
  },
})
vim.api.nvim_create_autocmd("BufModifiedSet", {
  callback = function(args)
    if vim.bo[args.buf].modified then
      vim.cmd("BufferPin")
    end
  end,
})
