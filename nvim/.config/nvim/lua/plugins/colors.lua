return {
  {
    'bradcush/nvim-base16',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme base16-black-metal-immortal')
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
