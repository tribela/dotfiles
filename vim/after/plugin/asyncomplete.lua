if not vim.g.asyncomplete_loaded then
  return
end

local keymap = vim.keymap.set

keymap('i', '<C-Space>', '<Plug>(asyncomplete_force_refresh)', { silent = true })
