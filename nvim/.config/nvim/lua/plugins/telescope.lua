return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'nvim-telescope/telescope-fzf-native.nvim' },
    opts = {
      defaults = {
        -- Default configuration for telescope goes here:
        winblend = 0,
        prompt_prefix = "󰍉 ",
        selection_caret = "󰜴 ",
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        layout_strategy = 'horizontal',
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--no-ignore"
        },
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
            ["<ESC>"] = "close",
          }
        }
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
          no_ignore = true,
          hidden = false,
        }
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        fzf = {}
      },
    },
    keys = {
      { "<Leader>bs", [[<CMD>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]], mode = 'n', noremap = true },
      { "<Leader>ff", [[<CMD>lua require("telescope.builtin").find_files()<CR>]], mode = 'n', noremap = true },
      { "<Leader>fg", [[<CMD>lua require("telescope.builtin").live_grep()<CR>]], mode = 'n', noremap = true },
      { "<Leader>fb", [[<CMD>lua require("telescope.builtin").buffers()<CR>]], mode = 'n', noremap = true },
      { "<Leader>fh", [[<CMD>lua require("telescope.builtin").help_tags()<CR>]], mode = 'n', noremap = true },
      { "<Leader>ls", [[<CMD>lua require("telescope.builtin").git_status()<CR>]], mode = 'n', noremap = true },
      { "<Leader>lt", [[<CMD>lua require("telescope.builtin").lsp_document_symbols()<CR>]], mode = 'n', noremap = true },
      { "<Leader>li", [[<CMD>lua require("telescope.builtin").lsp_implementations()<CR>]], mode = 'n', noremap = true },
      { "<Leader>ld", [[<CMD>lua require("telescope.builtin").lsp_definitions()<CR>]], mode = 'n', noremap = true },
      { "<Leader>lr", [[<CMD>lua require("telescope.builtin").lsp_references()<CR>]], mode = 'n', noremap = true },
      { "<Leader>lp", [[<CMD>lua require("telescope.builtin").diagnostics()<CR>]], mode = 'n', noremap = true },
    }
  },
}
