return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPre', 'BufNewFile'},
  main = 'ibl',
  config = function()
    ibl = require('ibl')

    local highlight = {
      "ModeMsg",
    }

    vim.opt.list = true
    vim.opt.listchars = {
      tab = '┆ ',
      trail = '•',
      nbsp = '␣',
    }

    ibl.setup {
      indent = {
        char = '┆',
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        highlight = highlight
      },
    }
  end
}
