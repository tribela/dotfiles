return {
	'github/copilot.vim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		vim.g.copilot_filetypes = {
			gitcommit = true,
		}
	end,
}
