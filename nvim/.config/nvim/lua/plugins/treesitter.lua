return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function() 
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(opts)
          if vim.treesitter.language.add(opts.match) then
            vim.treesitter.start(opts.buf, opts.match)
          end
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
      })
      require('nvim-treesitter').install('unstable')
    end,
  }
}
