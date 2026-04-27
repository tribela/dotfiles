return {
	{
		-- Expand a/i key
		'nvim-mini/mini.ai',
		event = { 'BufReadPost', 'BufNewFile' },
		config = true,
	},
	{
		'nvim-mini/mini.completion',
		event = 'InsertEnter',
		opts = {
			process_dot = true,
			fallback_action = function()
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local before_cursor = line:sub(1, col)
				local current_word = before_cursor:match('%S*$')
				if current_word:find('/') then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-f>', true, true, true), 'n', true)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n', true)
				end
			end,
		},
		config = function(_, opts)
			require('mini.completion').setup(opts)
			vim.api.nvim_create_autocmd('InsertCharPre', {
				callback = function()
					if vim.v.char == '/' then
						vim.schedule(function()
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-f>', true, true, true), 'n', true)
						end)
					end
				end,
			})
		end,
	},
}
