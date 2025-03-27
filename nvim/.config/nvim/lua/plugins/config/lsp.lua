local lspconfig = require('lspconfig');

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable autocomplete for versions that support it
  -- if vim.version().minor >= 11 then
  --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  -- end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', 'ge', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gqq', vim.diagnostic.setqflist, bufopts)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'grd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'grf', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, bufopts)

  -- AutoCommands
  local ph_lsp_augroup = vim.api.nvim_create_augroup("PH_LSP", { clear = false })
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

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    }
  },
})

-- Setting up the `lua-language-server` with the lua-dev plugin
---@diagnostic disable-next-line: missing-fields
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
  lspconfig = {
    cmd = { "lua-language-server" },
    on_attach = on_attach,
    capabilities = capabilities,
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
  capabilities = capabilities,
  filetypes = { 'apex' },
  apex_jar_path = os.getenv('APEX_LSP_PATH') .. '/apex-jorje-lsp.jar',
  apex_enable_semantic_errors = false,       -- Whether to allow Apex Language Server to surface semantic errors
  apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
}

lspconfig['denols'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
}

lspconfig['ts_ls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("package.json"),
  single_file_support = false,
}

lspconfig['elixirls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'elixir-ls' },
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'rust_analyzer',
  'gopls',
  'lua_ls',
  'clangd',
  'biome',
  'gleam',
  'elmls',
  -- 'tailwindcss',
  'html',
  'eslint',
  'pyright',
  'jsonls',
  'ocamllsp',
  'jdtls',
  'lwc_ls',
  'zls',
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
