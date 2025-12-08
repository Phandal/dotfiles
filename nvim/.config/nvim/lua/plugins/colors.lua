return {
  {
    'bradcush/nvim-base16',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme base16-black-metal-immortal')
      vim.cmd('colorscheme base16-onedark')
      vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'Search' })
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme everforest')
    end,
  }
}
