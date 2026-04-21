return {
	{
		-- Expand a/i key
		'nvim-mini/mini.ai',
		event = 'VeryLazy',
		config = true,
	},
	{
		'nvim-mini/mini.pairs',
		event = 'InsertEnter',
		config = function()
			require('mini.pairs').setup()
		end,
	},
	{
		'nvim-mini/mini.surround',
		config = function()
			require('mini.surround').setup()
		end,
	}
}
