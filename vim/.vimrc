" Make sure the defaults loaded
source $VIMRUNTIME/defaults.vim

" Turning Things On
set autowrite
set autoread
set background=dark
set clipboard=unnamedplus
set completeopt=menuone,preview
set cursorline
set expandtab
set fillchars=eob:\ ,vert:│
set grepprg=rg\ --vimgrep
set guicursor=n-v-c-sm:block-blinkwait300-blinkon200-blinkoff150,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20
set guioptions=aegit
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:\ \ ,eol:󱞥,trail:·
set mouse=a
set number
set omnifunc=syntaxcomplete#Complete
set path+=**
set regexpengine=0
set relativenumber
set shiftwidth=2
set shortmess=filnxtToOFc
set signcolumn=yes
set smartcase
set smartindent
set splitbelow
set splitright
set tabstop=2
set termguicolors
set ttimeoutlen=50
set updatetime=300
set wildmenu
set wildoptions=fuzzy,pum
set wildignorecase

" Turning Things Off
set nobackup
set noshowmode
set nowrap

" Settings
let mapleader=" "
syntax enable
filetype plugin indent on

" Color Scheme Specific
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1
let g:nord_underline = 1
colorscheme everforest

" File Browser Specific
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Functions
function SwapBackground()
  if &background == "dark"
    let &background="light"
  else
    let &background="dark"
  endif
endfunction

function StatusLineMode()
  if &filetype ==# 'netrw'
    return 'NETRW'
  elseif &filetype ==# 'help'
    return 'HELP'
  else
    let statusline_mode_map = {
      \ 'n'      : 'NORMAL',
      \ 'i'      : 'INSERT',
      \ 'R'      : 'REPLACE',
      \ 'v'      : 'VISUAL',
      \ 'V'      : 'V-LINE',
      \ "\<C-v>" : 'V-BLOCK',
      \ 'c'      : 'COMMAND',
      \ 's'      : 'SELECT',
      \ 'S'      : 'S-LINE',
      \ "\<C-s>" : 'S-BLOCK',
      \ 't'      : 'TERMINAL'
      \ }
    return get(statusline_mode_map, mode())
  endif
endfunction

" KeyMaps
nnoremap <C-n> <CMD>20Lexplore<CR>
nnoremap <f5> <CMD>call SwapBackground()<CR>
nnoremap <Leader>ff <CMD>Files<CR>
nnoremap <Leader>fb <CMD>Buffers<CR>
nnoremap <Leader>fh <CMD>Help<CR>
nnoremap <Leader>j <CMD>cnext<CR>
nnoremap <Leader>k <CMD>cprev<CR>

" Commands

" AutoCommands

" FZF Settings
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.4, 'yoffset': 1.0 } }
if g:colors_name !=# 'gruvbox'
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
endif

" Mac Specific
if has('mac')
  let g:nord_italic_comments = 0
  set rtp+=/opt/homebrew/opt/fzf
  runtime ftplugin/man.vim
  set clipboard=unnamed
endif

