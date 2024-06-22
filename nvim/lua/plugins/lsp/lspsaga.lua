return {
	'nvimdev/lspsaga.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		-- 'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require('lspsaga').setup({
			error_sign = 'E',
			warn_sign = 'W',
			hint_sign = 'H',
			infor_sign = 'I',
			code_action_icon = '',
			code_action_prompt = {
				enabled = true,
				sign = false,
				virtual_text = true,
			},
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				kind = {
					['File']={  '', 'Tag' },
					['Module']={  '', 'Exception' },
					['Namespace']={  '', 'Include' },
					['Package']={  '', 'Label' },
					['Class']={  '', 'Include' },
					['Method']={  '', 'Function' },
					['Property']={  '', '@property' },
					['Field']={  ' ', '@field' },
					['Constructor']={  '', '@constructor' },
					['Enum']={  '', '@number' },
					['Interface']={  '', 'Type' },
					['Function']={  '', 'Function' },
					['Variable']={  '', '@variable' },
					['Constant']={  '', 'Constant' },
					['String']={  '', 'String' },
					['Number']={  '', 'Number' },
					['Boolean']={  '', 'Boolean' },
					['Array']={  '', 'Type' },
					['Object']={  '', 'Type' },
					['Key']={  '', '' },
					['Null']={  '', 'Constant' },
					['EnumMember']={  '', 'Number' },
					['Struct']={  '', 'Type' },
					['Event']={  '', 'Constant' },
					['Operator']={  '', 'Operator' },
					['TypeParameter']={  '', 'Type' },
					-- ccls
					['TypeAlias']={  '', 'Type' },
					['Parameter']={  '', '@parameter' },
					['StaticMethod']={  '', 'Function' },
					['Macro']={  '', 'Macro' },
					-- for completion sb microsoft!!!
					['Text']={  '', 'String' },
					['Snippet']={  ' ', '@variable' },
					['Folder']={  ' ', '@parameter' },
					['Unit']={  '', 'Number' },
					['Value']={  '', '@variable' },
				},
			},
		})

		local keymap = vim.keymap
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

				keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
				keymap.set("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", opts)

				keymap.set("n", "<C-]>", "<cmd>Lspsaga hover_doc<CR>", opts)

				keymap.set("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
				keymap.set("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

				keymap.set("n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)

				keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
				keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
				keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)

				keymap.set('n', '[x', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
				keymap.set('n', ']x', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
			end,
		})
	end,
}
