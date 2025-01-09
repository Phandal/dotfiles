local lspconfig = require('lspconfig');

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist, opts)

-- Setup capabilities for nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'grd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>F', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, bufopts)

  -- AutoCommands
  local ph_lsp_augroup = vim.api.nvim_create_augroup("PH_LSP", { clear = true })
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold",
      { pattern = "<buffer>", group = ph_lsp_augroup, command = "lua vim.lsp.buf.document_highlight()" })
    vim.api.nvim_create_autocmd("CursorHoldI",
      { pattern = "<buffer>", group = ph_lsp_augroup, command = "lua vim.lsp.buf.document_highlight()" })
    vim.api.nvim_create_autocmd("CursorMoved",
      { pattern = "<buffer>", group = ph_lsp_augroup, command = "lua vim.lsp.buf.clear_references()" })
  end

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre",
      { buffer = bufnr, group = ph_lsp_augroup, command = "lua vim.lsp.buf.format()" });
  end

  if client.name == 'eslint' then
    vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, group = ph_lsp_augroup, command = "EslintFixAll" })
  end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setting up the `lua-language-server` with the lua-dev plugin
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    cmd = { "lua-language-server" },
    on_attach = on_attach,
    -- capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true)
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false
        }
      }
    }
  }
})

-- Apex Language Server
lspconfig['apex_ls'].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  filetypes = { 'apex' },
  apex_jar_path = os.getenv('APEX_LSP_PATH') .. '/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = false,       -- Whether to allow Apex Language Server to surface semantic errors
  apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
}

lspconfig['denols'].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
}

lspconfig['ts_ls'].setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false,
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'rust_analyzer',
  'gopls',
  'lua_ls',
  'clangd',
  -- 'tailwindcss',
  'html',
  'eslint',
  'pyright',
  'jsonls',
  'ocamllsp',
  'jdtls',
  'lwc_ls',
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    -- capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
