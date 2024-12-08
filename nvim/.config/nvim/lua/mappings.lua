local set_key = vim.api.nvim_set_keymap
local key_opts = { noremap = true, silent = true }

function SwapBackgroundColor()
  local currentBackground = vim.opt.background:get()
  local newBackground
  if (currentBackground == 'dark') then
    newBackground = 'light'
  else
    newBackground = 'dark'
  end
  vim.opt.background = newBackground
  print('Set background: ' .. newBackground)
end

-- General
set_key("n", "<F5>", [[<CMD>lua SwapBackgroundColor()<CR>]], key_opts)
set_key("n", "<ESC>", [[<CMD>nohlsearch<CR>]], key_opts);

-- Terminal Mode specific
set_key("t", "<ESC>", [[<C-\><C-n>]], key_opts)
set_key("n", "<Leader>tt", [[<CMD>10sp<CR><CMD>term<CR>]], key_opts)
set_key("n", "<Leader>tv", [[<CMD>vs<CR><CMD>term<CR>]], key_opts)

-- Quickfix specific
set_key("n", "<Leader>j", [[<CMD>cnext<CR>]], key_opts)
set_key("n", "<Leader>k", [[<CMD>cprev<CR>]], key_opts)

-- LocList specific
set_key("n", "<LocalLeader>j", [[<CMD>lnext<CR>]], key_opts)
set_key("n", "<LocalLeader>k", [[<CMD>lprev<CR>]], key_opts)

-- NvimTree specific
set_key("n", "<C-n>", [[<CMD>NvimTreeToggle<CR>]], key_opts)

-- Telescope specific
set_key("n", "<Leader>bs", [[<CMD>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]], key_opts)
set_key("n", "<Leader>ff", [[<CMD>lua require("telescope.builtin").find_files()<CR>]], key_opts)
set_key("n", "<Leader>fg", [[<CMD>lua require("telescope.builtin").live_grep()<CR>]], key_opts)
set_key("n", "<Leader>fb", [[<CMD>lua require("telescope.builtin").buffers()<CR>]], key_opts)
set_key("n", "<Leader>fh", [[<CMD>lua require("telescope.builtin").help_tags()<CR>]], key_opts)
set_key("n", "<Leader>ls", [[<CMD>lua require("telescope.builtin").git_status()<CR>]], key_opts)
set_key("n", "<Leader>lt", [[<CMD>lua require("telescope.builtin").lsp_document_symbols()<CR>]], key_opts)
set_key("n", "<Leader>li", [[<CMD>lua require("telescope.builtin").lsp_implementations()<CR>]], key_opts)
set_key("n", "<Leader>ld", [[<CMD>lua require("telescope.builtin").lsp_definitions()<CR>]], key_opts)
set_key("n", "<Leader>lr", [[<CMD>lua require("telescope.builtin").lsp_references()<CR>]], key_opts)
set_key("n", "<Leader>lp", [[<CMD>lua require("telescope.builtin").diagnostics()<CR>]], key_opts)

-- Suitecloud specific
set_key("n", "<Leader>sd", [[<CMD>Suitecloud deploy<CR>]], key_opts)
set_key("n", "<Leader>sp", [[<CMD>Suitecloud preview<CR>]], key_opts)
