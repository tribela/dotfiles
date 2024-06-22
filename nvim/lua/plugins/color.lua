return {
  {
    'hachy/eva01.vim',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme eva01')
    end,
  },
  { 'edeneast/nightfox.nvim', event = 'VeryLazy' },
  { 'NLKNguyen/papercolor-theme', event = 'VeryLazy' },
}
