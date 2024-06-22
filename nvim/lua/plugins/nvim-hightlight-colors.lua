return {
	'brenoprata10/nvim-highlight-colors',
	event = { 'BufReadPre', 'BufNewFile'},
	config = function()
		require('nvim-highlight-colors').setup({
			render = 'background',
			virtual_symbol_position = 'inline',
			virtual_symbol_prefix = '',
			virtual_symbol_suffix = ' ',
			virtual_symbol = '●'
		})
	end,
}
