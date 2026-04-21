return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPre', 'BufNewFile'},
  main = 'ibl',
  config = function()
    ibl = require('ibl')

    local highlight = {
      "ModeMsg",
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
