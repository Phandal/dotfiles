local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'folke/lazy.nvim',                           -- Plugin Manager
  'projekt0n/github-nvim-theme',               -- Github Theme
  'shaunsingh/nord.nvim',                      -- Nord Theme
  'ellisonleao/gruvbox.nvim',                  -- Gruvbox Lua Theme
  'https://github.com/sainnhe/everforest',     -- Everforest Lua Theme
  'nvim-tree/nvim-web-devicons',               -- Pretty Dev Icons
  'j-hui/fidget.nvim',                         -- LSP Server Progress
  {
    'nvim-telescope/telescope.nvim',           -- Fuzzy Finder
    dependencies = { 'nvim-lua/plenary.nvim' } -- Dependency Plugin
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim', -- Native faster fzf for telescope
    build = 'make'
  },
  'lewis6991/gitsigns.nvim',           -- Git integration
  {
    'nvim-treesitter/nvim-treesitter', -- Syntax highlighting using TreeSitter
    build = ':TSUpdate'
  },
  'windwp/nvim-autopairs',               -- Automatically adds closing bracket
  'lukas-reineke/indent-blankline.nvim', -- Shows a symbol for indents
  'onsails/lspkind.nvim',                -- Shows pictograms in completion menu
  'neovim/nvim-lspconfig',               -- Base set of LSP configs
  'folke/neodev.nvim',                   -- Add functionality to lua server
  {
    'L3MON4D3/LuaSnip',                  -- Snippet Plugin
    lazy = false,
    build = 'make install_jsregexp',
  },
  'nanotee/luv-vimdocs',                         -- libuv docs in Neovim
  { dir = '~/Development/suitecloud.nvim/main' } -- Custom Work in progress
})
