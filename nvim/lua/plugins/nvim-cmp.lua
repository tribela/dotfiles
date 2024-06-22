return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			completion = {
				completeopt = 'menu,menuone,preview,noselect',
			},
			mapping = cmp.mapping.preset.insert({
		    ['<C-k>'] = cmp.mapping.select_prev_item(),
		    ['<C-j>'] = cmp.mapping.select_next_item(),
		    ['<C-f>'] = cmp.mapping.scroll_docs(4),
		    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		    -- ['<C-space>'] = cmp.mapping.complete(),
		    ['<cr>'] = cmp.mapping.confirm({ select = false }),
			}),
		  sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
		    { name = 'buffer' },
		    { name = 'path' },
			}),
		})
	end
}
