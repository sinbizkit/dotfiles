-- filetype plugin indent on

vim.cmd [[
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
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
]]


