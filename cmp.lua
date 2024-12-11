local lspkind = require("lspkind")
local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
		{ name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- because we are using the vsnip cmp plugin
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Remove the Enter mapping to prevent confirmation
    ['<CR>'] = cmp.mapping(function(fallback)
      fallback()  -- Perform the default <CR> action without confirming completion
    end),
    -- Add Shift-Enter mapping for confirming completion
    ['<S-CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- tab does normal stuff 
    ['<Tab>'] = function(fallback)
      fallback()
    end,
    -- shift-q selects up through auto-complete 
    ['<S-q>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- shift-tab selects down through auto-complete
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
 	formatting = {
 		format = lspkind.cmp_format({
 			mode = 'symbol_text',
 			maxwidth = 50,
 			ellipsis_char = '...',
 			before = function (_, vim_item)
 				return vim_item
 			end
 		})
 	},
}


