return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'williamboman/mason.nvim',
		{ 'antosha417/nvim-lsp-file-operations', config = true },
		{ 'folke/neodev.nvim', opts = {} },
	},
	config = function()
		local lspconfig = require('lspconfig')
		local mason_lspconfig = require('mason-lspconfig')
		local cmp_nvim_lsp = require('cmp_nvim_lsp')

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local settings = {
			pylsp = {
				pylsp = {
					plugins = {
						flake8 = { enabled = true },
						pycodestyle = {
							enabled = false,
							maxLineLength = 120,
						},
					},
				},
			},
		}

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					settings = settings[server_name],
				})
			end,
		})
	end,
}
