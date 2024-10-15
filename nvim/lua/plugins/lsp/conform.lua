return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')
        conform.setup {
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_after_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 500,
            }
        }

        vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
            conform.format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
