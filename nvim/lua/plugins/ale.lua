return {
	'dense-analysis/ale',
	config = function()
		local g = vim.g
		local keymap = vim.keymap

		g.ale_completion_enabled = 1
		g.ale_use_neovim_diagnostics_api = 1

		keymap.set('n', '[x', '<Plug>(ale_previous_wrap)')
		keymap.set('n', ']x', '<Plug>(ale_next_wrap)')
	end,
}
