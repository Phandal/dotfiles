return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = "│"
      }
    },
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
    end,
    keys = {
      { "<C-K>", [[<CMD>lua require("luasnip").expand()<CR>]], mode = { 'i', 's' }, noremap = true },
      { "<C-J>", [[<CMD>lua require("luasnip").jump(-1)<CR>]], mode = { 'i', 's' }, noremap = true },
      { "<C-L>", [[<CMD>lua require("luasnip").jump(1)<CR>]],  mode = { 'i', 's' }, noremap = true },
    }
  }
}
