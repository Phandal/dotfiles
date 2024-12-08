local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

-- Options
opt.autowrite = true
opt.syntax = "on"
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.showmode = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.hidden = true
opt.backup = false
opt.updatetime = 300
opt.shortmess = "filnxtToOFc"
opt.signcolumn = "yes"
opt.termguicolors = true
opt.ignorecase = true
opt.completeopt = "menuone,noselect,noinsert,preview"
opt.background = "dark"
opt.laststatus = 3
opt.fillchars = { eob = " ", vert = "│" }
opt.cursorline = true
opt.list = true
-- opt.listchars = opt.listchars + 'eol:󱞥, trail:·, tab:  '
opt.listchars = opt.listchars + 'trail:·, tab:  '
opt.relativenumber = true
opt.guicursor =
"n-v-c-sm:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
opt.shiftround = true
opt.smartcase = true
opt.grepprg = "rg --vimgrep"
opt.path = opt.path + "**"
opt.wildmenu = true
opt.wildignorecase = true
opt.inccommand = 'split'

-- Global variables
g.mapleader = " "
g.maplocalleader = [[\]]

-- Custom Highlights
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Cursorline" })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Cursorline" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Folded" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Folded" })

-- Autocommands
autocmd("TermOpen", { pattern = "*", command = "lua vim.opt.number = false" })
autocmd("TermOpen", { pattern = "*", command = "lua vim.opt.relativenumber = false" })
autocmd("TermOpen", { pattern = "*", command = "lua vim.opt.signcolumn = 'no'" })
autocmd("TermOpen", { pattern = "*", command = "startinsert" })

-- Custom Commands

-- Neovide
if vim.g.neovide then
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blurred_amount_x = 2.0
  vim.g.neovide_floating_blurred_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_scale_factor = 0.9
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
