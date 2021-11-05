if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require('lspsaga')
saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
  code_action_icon = '',
  code_action_prompt = {
    enabled = true,
    sign = false,
    virtual_text = true,
  }
}
EOF

nnoremap <silent> gh <cmd>Lspsaga lsp_finder<CR>

nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent>K <cmd>Lspsaga hover_doc<CR>

nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent>gs <cmd>Lspsaga signature_help<CR>

nnoremap <silent>gr <cmd>Lspsaga rename<CR>
nnoremap <silent> gd <cmd>Lspsaga preview_definition<CR>
" nnoremap <silent> gD :Lspsaga definition<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>

nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent>[d <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>
nnoremap <silent>]d <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>
