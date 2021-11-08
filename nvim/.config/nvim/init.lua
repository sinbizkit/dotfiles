local opt = vim.opt
local fn  = vim.fn
local g   = vim.g

--------------------------------------------------------------------------------
-- General options.
--------------------------------------------------------------------------------
opt.compatible = false
opt.errorbells = false
opt.mouse = 'a'

opt.exrc = true
opt.secure = true

-- Disable data-loss-safety stuff. In any case an vcs will help.
opt.swapfile = false
opt.writebackup = false
opt.backup = false

opt.autoread = true
opt.mapleader = ';'

if fn.has('nvim') then
  g.loaded_ruby_provider = false
end

--------------------------------------------------------------------------------
-- Plugins.
--------------------------------------------------------------------------------
filetype plugin indent on

--[[ call plug#begin('~/.config/nvim/plugged') ]]

--[[ Plug 'nvim-lua/popup.nvim' ]]
--[[ Plug 'nvim-lua/plenary.nvim' ]]

--[[ Plug 'dracula/vim', { 'as': 'dracula' } ]]
--[[ Plug 'kyazdani42/nvim-web-devicons' ]]
--[[ Plug 'nvim-lualine/lualine.nvim' ]]
--[[ Plug 'majutsushi/tagbar' ]]
--[[ Plug 'Yggdroot/indentLine' ]]
--[[ Plug 'simrat39/symbols-outline.nvim' ]]
--[[ Plug 'folke/trouble.nvim' ]]

--[[ Plug 'tpope/vim-fugitive' ]]
--[[ Plug 'lewis6991/gitsigns.nvim' ]]

--[[ Plug 'tpope/vim-surround' ]]
--[[ Plug 'phaazon/hop.nvim' ]]
--[[ Plug 'godlygeek/tabular' ]]

--[[ Plug 'scrooloose/nerdcommenter' ]]
--[[ Plug 'kyazdani42/nvim-tree.lua' ]]

--[[ Plug 'neovim/nvim-lspconfig' ]]
--[[ Plug 'hrsh7th/nvim-cmp' ]]
--[[ Plug 'hrsh7th/cmp-nvim-lsp' ]]
--[[ Plug 'hrsh7th/cmp-buffer' ]]
--[[ Plug 'hrsh7th/cmp-path' ]]
--[[ Plug 'ray-x/lsp_signature.nvim' ]]
--[[ Plug 'dense-analysis/ale' ]]
--[[ Plug 'SirVer/ultisnips' ]]

--[[ Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} ]]
--[[ Plug 'nvim-telescope/telescope.nvim' ]]

--[[ " Language specific. ]]
--[[ Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] } ]]
--[[ Plug 'rust-lang/rust.vim', { 'for': 'rust' } ]]
--[[ Plug 'simrat39/rust-tools.nvim' ]]
--[[ Plug 'peterhoeg/vim-qml', { 'for': 'qml' } ]]

--[[ call plug#end() ]]

--------------------------------------------------------------------------------
-- Appearance.
--------------------------------------------------------------------------------
if fn.has("termguicolors") then
  opt.termguicolors = true
end

--[[ set list lcs=tab:▸\ ,space:·    " Tab symbol. ]]
--[[ set cursorline                  " Highlighting that moves with the cursor. ]]
--[[ set noshowmode                  " Turn off the native mode indicator. ]]
--[[ set encoding=utf-8              " Default encoding. ]]
--[[ set foldmethod:syntax           " Syntax highlighting items specify folds. ]]
--[[ set foldlevel=3                 " Close folds with the higher level. ]]
--[[ set number                      " Print the linenumber in front of each line. ]]
--[[ set relativenumber              " Show the line number relative to the line. ]]
--[[ set showtabline=2               " Always show the line with tab page labels. ]]
--[[ set shortmess=atIc               " Remove all useless messages. ]]
--[[ set splitbelow                  " Splitting will put the new window below the current one. ]]
--[[ set pumheight=15                " Maximum number of items showed in a popup menu. ]]
--[[ set signcolumn=yes              " Always show the sign column. ]]

--[[ " This will show the popup menu even if there's only one match (menuone), ]]
--[[ " prevent automatic selection (noselect) and prevent automatic text injection ]]
--[[ " into the current line (noinsert). ]]
--[[ set completeopt=noinsert,menuone,noselect ]]
--[[ set laststatus=2 " The last window will always have a status line. ]]

--[[ " Theme. ]]
--[[ silent! colorscheme dracula ]]

--[[ """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" ]]
--[[ "" Global mappings. ]]
--[[ """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" ]]
--[[ " Split current window vertically. ]]
--[[ nnoremap ne :vsplit<CR> ]]
--[[ " Split current window horizontally. ]]
--[[ nnoremap no :split<CR> ]]
--[[ " Open new tab. ]]
--[[ nnoremap nt :tabnew<CR> ]]
--[[ " Remove trailing whitespaces ]]
--[[ nnoremap <Leader>ww :%s/\s\+$//<CR> ]]
--[[ " Panes navigation. ]]
--[[ nnoremap <C-J> <C-W><C-J> ]]
--[[ nnoremap <C-K> <C-W><C-K> ]]
--[[ nnoremap <C-L> <C-W><C-L> ]]
--[[ nnoremap <C-H> <C-W><C-H> ]]
--[[ " Tags. ]]
--[[ nnoremap <Leader>]n :tnext<CR> ]]
--[[ nnoremap <Leader>]p :tprevious<CR> ]]
--[[ " QuickFix. ]]
--[[ nnoremap <Leader>oq :copen<CR> ]]
--[[ nnoremap <Leader>nq :cnext<CR> ]]
--[[ nnoremap <Leader>pq :cprevious<CR> ]]
--[[ " LocationList. ]]
--[[ nnoremap <Leader>ol :lopen<CR> ]]
--[[ nnoremap <Leader>nl :lnext<CR> ]]
--[[ nnoremap <Leader>pl :lprevious<CR> ]]
--[[ " Change the behavior of the <Enter> key when the popup menu is visible. In that ]]
--[[ " case the Enter key will simply select the highlighted menu item, just as <C-Y> does. ]]
--[[ inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" ]]
--[[ " Use <TAB> to select the popup menu: ]]
--[[ inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>" ]]
--[[ inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" ]]

