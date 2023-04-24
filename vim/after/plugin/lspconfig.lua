if vim.g.lspconfig == nil then
  return
end

local nvim_lsp = require('lspconfig')

-- Completion

vim.o.completeopt = 'menu,menuone,noselect'

-- Handler to attach LSP keymappings to buffers using LSP
local on_attach = function(client, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
end


local server_configs = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  },
  pyright = {},
  tsserver = {},
}


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = server_configs[lsp].settings,
    cmd = server_configs[lsp].cmd,
  }
end
