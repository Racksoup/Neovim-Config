local op = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Map '4' to work like the leader key
vim.api.nvim_set_keymap('n', '4', '<Leader>', { noremap = true })
vim.api.nvim_set_keymap('v', '4', '<Leader>', { noremap = true })
vim.api.nvim_set_keymap('x', '4', '<Leader>', { noremap = true })
map('n', '9', 'o<Esc>', op) -- normal mode - insert line below
map('n', '(', 'O<Esc>', op) -- normal mode - insert line above
map('n', '<leader>e', ':NvimTreeToggle <CR>', op) -- open / close file explorer
map('n', '3', ':NvimTreeFocus <CR>', op) -- open / focus file explorer
map('n', '<leader>]', ':bnext <CR>', op) -- cycle buffers next
map('n', '<leader>[', ':bprevious <CR>', op) -- cycle buffers previous
map('n', '<C-j>', '<C-w>j', op) -- move to split below
map('n', '<C-k>', '<C-w>k', op) -- move to split above
map('n', '<C-h>', '<C-w>h', op) -- move to split on left
map('n', '<C-l>', '<C-w>l', op) -- move to split on right
map('n', '<C-u>', '<C-u>zz', op) -- moves window half up, centers cursor
map('n', '<C-d>', '<C-d>zz', op) -- moves window half down, centers cursor
-- Key mappings for Telescope commands
map('n', '<leader>ff', ':lua require\'telescope.builtin\'.find_files(require(\'telescope.themes\').get_dropdown({ previewer = false }))<CR>', op) -- search
map('n', '<leader>fg', ':lua require(\'telescope.builtin\').live_grep()<CR>', op) -- grep
map('n', '<leader>fb', ':lua require(\'telescope.builtin\').buffers()<CR>', op) -- buffers
map('n', '<leader>fh', ':lua require(\'telescope.builtin\').help_tags()<CR>', op) -- tags
-- Copy to clipboard (Ctrl+C in visual mode)
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
-- Cut to clipboard (Ctrl+X in visual mode)
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', { noremap = true, silent = true })
-- Paste from clipboard (Ctrl+V in normal and visual mode)
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })
-- Paste in insert mode (Ctrl+V in insert mode)
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })
-- BarBar
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', op)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', op)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', op)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', op)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', op)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', op)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', op)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', op)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', op)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', op)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', op)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', op)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', op)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', op)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', op)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', op)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-g>', '<Cmd>BufferPick<CR>', op)
-- Sort automatically by...
map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', op)
map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', op)
map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', op)
map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', op)
map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', op)
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- color picker
map('n', '<leader>cp', '<cmd>PickColor<cr>', op) 
map('i', '<leader>cp', '<cmd>PickColorInsert<cr>', op) 
