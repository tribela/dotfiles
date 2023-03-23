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
})

local keymap = vim.keymap.set

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", {silent = true})

keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {silent = true})
keymap("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", {silent = true})

keymap("n", "<C-]>", "<cmd>Lspsaga hover_doc<CR>", {silent = true})

keymap("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent = true})
keymap("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent = true})

keymap("n", "gs", "<cmd>Lspsaga signature_help<CR>", {silent = true})

keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", {silent = true})
keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", {silent = true})

keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {silent = true})
keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', {silent = true})
