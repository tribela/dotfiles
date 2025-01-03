return {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
	},
	lazy = true,
	config = function()
		local mason = require('mason')
		local mason_lspconfig = require('mason-lspconfig')
		local mason_tool_installer = require('mason-tool-installer')

		mason.setup({
			ui = {
				icons = {
					package_installed = '✔',
					package_pending = '➡',
					package_uninstall = '✖',
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				'bashls',
				'ts_ls',
				'lua_ls',
				'html',
				'pylsp',
				'clangd',
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				'shellcheck',
				'flake8',
				'mypy',
				'pyright',
				'clang-format',
			},
		})
	end
}
