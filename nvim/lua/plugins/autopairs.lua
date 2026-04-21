return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	config = function()
		local autopairs = require('nvim-autopairs')
		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { 'string' }, -- Don't add pairs in lua string
				javascript = { 'template_string' },
			},
		})
	end,
}
