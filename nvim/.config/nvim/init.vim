""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible          " Be iMproved (nvim is always nocompatible).
set mouse:a               " Enable the use of the mouse.
set noerrorbells          " No beeps.
set exrc                  " Allow loading local executing local rc files.

" Disable data-loss-safety stuff. In any case an vcs will help.
set noswapfile            " Don't use a swapfile for the buffer.
set nowritebackup         " Do not make a backup file.
set nobackup

set autoread " Automatically reread without asking me anything.
let mapleader=";" " Change <Leader> key to a more convenient.

if (has('nvim'))
  let g:loaded_ruby_provider = 0          " Disable ruby support
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plugins.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on  " Enable loading the plugin and indent files for specific file types.

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'simrat39/symbols-outline.nvim'
Plug 'folke/trouble.nvim'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'
Plug 'godlygeek/tabular'

Plug 'scrooloose/nerdcommenter'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/lsp_signature.nvim'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'

" Language specific.
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'simrat39/rust-tools.nvim'
Plug 'peterhoeg/vim-qml', { 'for': 'qml' }


call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Appearance.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorify line-width restriction marker.
let &colorcolumn=join(range(105, 999),",")
highlight SignColumn guibg=#333233
highlight ColorColumn ctermbg=234

" Colorize ExtraWhiteSpace
highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd BufRead,BufNew * match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/
" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave *  match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/
autocmd InsertEnter * match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/
autocmd TermOpen * setlocal nonumber norelativenumber

" Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

set list lcs=tab:▸\ ,space:·    " Tab symbol.
set cursorline                  " Highlighting that moves with the cursor.
set noshowmode                  " Turn off the native mode indicator.
set encoding=utf-8              " Default encoding.
set foldmethod:syntax           " Syntax highlighting items specify folds.
set foldlevel=3                 " Close folds with the higher level.
set number                      " Print the linenumber in front of each line.
set relativenumber              " Show the line number relative to the line.
set showtabline=2               " Always show the line with tab page labels.
set shortmess=atIc               " Remove all useless messages.
set splitbelow                  " Splitting will put the new window below the current one.
set pumheight=15                " Maximum number of items showed in a popup menu.
set signcolumn=yes              " Always show the sign column.

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect
set laststatus=2 " The last window will always have a status line.

" Theme.
silent! colorscheme dracula

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Global mappings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split current window vertically.
nnoremap ne :vsplit<CR>
" Split current window horizontally.
nnoremap no :split<CR>
" Open new tab.
nnoremap nt :tabnew<CR>
" Remove trailing whitespaces
nnoremap <Leader>ww :%s/\s\+$//<CR>
" Panes navigation.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Tags.
nnoremap <Leader>]n :tnext<CR>
nnoremap <Leader>]p :tprevious<CR>
" QuickFix.
nnoremap <Leader>oq :copen<CR>
nnoremap <Leader>nq :cnext<CR>
nnoremap <Leader>pq :cprevious<CR>
" LocationList.
nnoremap <Leader>ol :lopen<CR>
nnoremap <Leader>nl :lnext<CR>
nnoremap <Leader>pl :lprevious<CR>
" Change the behavior of the <Enter> key when the popup menu is visible. In that
" case the Enter key will simply select the highlighted menu item, just as <C-Y> does.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

