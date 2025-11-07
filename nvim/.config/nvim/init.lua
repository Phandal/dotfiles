local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local set_key = vim.api.nvim_set_keymap

-- Options
opt.background = "dark"
opt.clipboard = "unnamedplus"
opt.completeopt = "fuzzy,menuone,noselect,noinsert,preview"
opt.cursorline = true
opt.expandtab = true
opt.fillchars = { eob = " " }
opt.guicursor =
"n-v-c-sm:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
opt.ignorecase = true
opt.inccommand = 'split'
opt.laststatus = 3
opt.list = true
opt.listchars:append('trail:·, tab:  ')
opt.mouse = "a"
opt.number = true
opt.path:append("**")
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = "ltToOFc"
opt.showmode = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.syntax = "on"
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 300
opt.wildignorecase = true
opt.wildoptions = "fuzzy,pum"
opt.wrap = false

-- Global Variables
g.mapleader = " "
g.maplocalleader = [[\]]
g.netrw_liststyle = 1

-- Autocommands
local ph_term_augroup = vim.api.nvim_create_augroup("PH_TERM", { clear = true })
autocmd("TermOpen", { pattern = "*", group = ph_term_augroup, command = "startinsert" })

local ph_preview_augroup = vim.api.nvim_create_augroup("PH_PREVIEW", { clear = true })
autocmd("BufWinEnter",
  {
    pattern = "*",
    group = ph_preview_augroup,
    command =
    "lua if vim.wo.previewwindow then vim.wo.wrap = true; vim.wo.linebreak = true end"
  })
-- autocmd("CompleteDone", { pattern = "*", group = ph_preview_augroup, command = "pclose" })

-- Neovide
if g.neovide then
  g.neovide_window_blurred = true
  g.neovide_floating_blurred_amount_x = 2.0
  g.neovide_floating_blurred_amount_y = 2.0
  g.neovide_scroll_animation_length = 0.1
  g.neovide_confirm_quit = true
  g.neovide_scale_factor = 0.9
  g.neovide_cursor_vfx_mode = "pixiedust"
end

-- FileTypes
vim.filetype.add({
  extension = {
    apex = "apex",
    cls = "apex",
    trigger = "apex",
  }
})

vim.filetype.add({
  extension = {
    soql = "soql",
  }
})

-- Key Mappings
local key_opts = { noremap = true }
set_key("n", "<ESC>", [[<CMD>nohlsearch<CR>]], key_opts);
set_key("t", "<ESC>", [[<C-\><C-n>]], key_opts)
set_key("n", "<Leader>tt", [[<CMD>10sp<CR><CMD>term<CR>]], key_opts)
set_key("n", "<Leader>tv", [[<CMD>vs<CR><CMD>term<CR>]], key_opts)
set_key("n", "<Leader>j", [[<CMD>cnext<CR>]], key_opts)
set_key("n", "<Leader>k", [[<CMD>cprev<CR>]], key_opts)
set_key("n", "<Leader>qo", [[<CMD>copen<CR>]], key_opts)
set_key("n", "<Leader>qc", [[<CMD>cclose<CR>]], key_opts)
set_key("n", "<LocalLeader>j", [[<CMD>lnext<CR>]], key_opts)
set_key("n", "<LocalLeader>k", [[<CMD>lprev<CR>]], key_opts)
set_key("n", "<LocalLeader>lo", [[<CMD>lopen<CR>]], key_opts)
set_key("n", "<LocalLeader>lc", [[<CMD>lclose<CR>]], key_opts)
set_key("n", "<C-n>", [[<CMD>Explore<CR>]], key_opts)
-- set_key("n", "<Leader>sd", [[<CMD>Suitecloud deploy<CR>]], key_opts)
-- set_key("n", "<Leader>sp", [[<CMD>Suitecloud preview<CR>]], key_opts)

-- LSP Setup
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('PH_LSP', {}),
  callback = function(args)
    local bufopts = { noremap = true, silent = true, buffer = args.buf }
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

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Hover on under Cursor
    if client:supports_method('textDocument/hover') then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = vim.api.nvim_create_augroup('PH_LSP', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = vim.api.nvim_create_augroup('PH_LSP', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('PH_LSP', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client.name == 'eslint' then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup('PH_LSP', { clear = false }),
        buffer = args.buf,
        command = "LspEslintFixAll"
      })
    end
  end,
})

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

vim.lsp.enable({
  'apex_ls',
  'ts_ls',
  'elixirls',
  'rust_analyzer',
  'gopls',
  'lua_ls',
  'clangd',
  'biome',
  'gleam',
  'cmake',
  'html',
  'eslint',
  'pyright',
  'jsonls',
  'ocamllsp',
  'jdtls',
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
