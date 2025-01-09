local g = vim.g
local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

-- Options
opt.autowrite = true
opt.background = "dark"
opt.backup = false
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect,noinsert,preview"
opt.cursorline = true
opt.expandtab = true
opt.fillchars = { eob = " ", vert = "│" }
opt.grepprg = "rg --vimgrep"
opt.guicursor =
"n-v-c-sm:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = 'split'
opt.incsearch = true
opt.laststatus = 3
opt.list = true
opt.listchars = opt.listchars + 'trail:·, tab:  '
-- opt.listchars = opt.listchars + 'eol:󱞥, trail:·, tab:  '
opt.mouse = "a"
opt.number = true
opt.path = opt.path + "**"
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = "filnxtToOFc"
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.syntax = "on"
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 300
opt.wildignorecase = true
opt.wildmenu = true
opt.wildoptions = "fuzzy,pum"
opt.wrap = false

-- Global variables
g.mapleader = " "
g.maplocalleader = [[\]]

-- File Browser Specific
g.netrw_banner = 1
g.netrw_liststyle = 0
-- g.netrw_browse_split = 4

-- Custom Highlights
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Cursorline" })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Cursorline" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Folded" })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Folded" })

-- Autocommands
local ph_term_augroup = vim.api.nvim_create_augroup("PH_TERM", { clear = true })
autocmd("TermOpen", { pattern = "*", group = ph_term_augroup, command = "lua vim.opt.number = false" })
autocmd("TermOpen", { pattern = "*", group = ph_term_augroup, command = "lua vim.opt.relativenumber = false" })
autocmd("TermOpen", { pattern = "*", group = ph_term_augroup, command = "lua vim.opt.signcolumn = 'no'" })
autocmd("TermOpen", { pattern = "*", group = ph_term_augroup, command = "startinsert" })

local ph_preview_augroup = vim.api.nvim_create_augroup("PH_PREVIEW", { clear = true })
autocmd("BufWinEnter",
  {
    pattern = "*",
    group = ph_preview_augroup,
    command =
    "lua if vim.wo.previewwindow then vim.wo.wrap = true; vim.wo.linebreak = true end"
  })
autocmd("CompleteDone", { pattern = "*", group = ph_preview_augroup, command = "pclose" })

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
