local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

opt.autochdir = true
opt.modeline = true
opt.modelines = 5
opt.syntax = 'on'
opt.number = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.virtualedit = 'onemore'

opt.background = 'dark'
opt.signcolumn = 'yes'

opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

local set_spell = function()
  opt.spell = true
  opt.spelllang = opt.spelllang + 'cjk'
end

autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.md",
  callback = set_spell
})
autocmd({ 'FileType'}, {
  pattern = 'gitcommit',
  callback = set_spell,
})

if vim.g.neovide then
  vim.g.neovide_transparency = 0.6
  vim.o.guifont = 'Comic Mono,Source Code Pro:h16'
  vim.g.neovide_cursor_vfx_mode = 'pixiedust'
  vim.cmd('color nightfox')
end
