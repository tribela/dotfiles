return {
	'yetone/avante.nvim',
	enabled = true,
	event = 'VeryLazy',
	lazy = false,
	opts = {
		provider = 'copilot',
		-- provider = 'claude',
		mappings = {
			submit = {
				insert = '<cr>',
			}
		}
	},
	build = ':AvanteBuild',
	dependencies = {
		'stevearc/dressing.nvim',
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
		-- Optional
		'zbirenbaum/copilot.lua',
		-- 'echasnovski/mini.icons',
	},
}
