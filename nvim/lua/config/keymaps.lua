vim.g.mapleader = ' '

local keymap = vim.keymap
local autocmd = vim.api.nvim_create_autocmd

keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')

keymap.set('n', '<down>', '<C-e>')
keymap.set('n', '<up>', '<C-y>')

keymap.set('n', '<cr>', 'o<esc>')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')
keymap.set('v', 'H', '^')
keymap.set('v', 'L', '$')

keymap.set('n', '<leader>/', ':nohls<cr>')
keymap.set('n', "<leader>'", ':syntax sync fromstart<cr>')
keymap.set('n', '<leader><space>', 'i_<esc>r')

keymap.set('n', '<leader>y', 'gg"+yG``')
keymap.set('v', '<leader>y', '"+y')
keymap.set('n', '<leader>p', '"+p')
keymap.set('v', '<leader>p', '"+p')
keymap.set('n', '<leader>g', 'gg=G``:%s/\\s\\+$//<cr>``')

keymap.set('ca', 'W', ':w !sudo % >/dev/null')
keymap.set('i', '<C-e>', '<C-r>=strftime("%Y-%m-%d %H:%M:%S %z")<cr>')

local set_spell = function()
  vim.
  keymap.set('n', '<C-]>', '1z=``')
end

autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.md",
  callback = set_spell
})
autocmd({ 'FileType'}, {
  pattern = 'gitcommit',
  callback = set_spell,
})
