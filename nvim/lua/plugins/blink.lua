return {
	'Saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',

	version = '*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'mono'
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		signature = {
			enabled = true,
			window = {
				show_documentation = true,
			},
			trigger = {
				enabled = true,
				show_on_insert = true,
			}
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			}
		}
	},
	opts_extend = { "sources.default" }
}
