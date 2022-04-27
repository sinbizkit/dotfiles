vim.cmd [[ filetype plugin indent on ]]

require 'packer'.startup({
	function(use)
		use('wbthomason/packer.nvim')

		use 'nvim-lua/popup.nvim'

		use 'EdenEast/nightfox.nvim'
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}

		use 'majutsushi/tagbar'

		use 'simrat39/symbols-outline.nvim'
		use 'tpope/vim-fugitive'
		use {
			'lewis6991/gitsigns.nvim',
			requires = 'nvim-lua/plenary.nvim'
		}

		use 'tpope/vim-surround'
		use {
			'phaazon/hop.nvim',
			branch = 'v1', -- optional but strongly recommended
			config = function() require 'hop'.setup() end
		}

		use 'scrooloose/nerdcommenter'
		use {
			'kyazdani42/nvim-tree.lua',
			requires = 'kyazdani42/nvim-web-devicons',
		}

		use 'neovim/nvim-lspconfig'
		use {
			'hrsh7th/nvim-cmp',
			requires = {
				{ 'saadparwaiz1/cmp_luasnip' },
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-buffer' },
				{ 'hrsh7th/cmp-path' },
				{ 'onsails/lspkind-nvim' },
			},
		}

		use {
			'ray-x/lsp_signature.nvim',
			config = function() require 'lsp_signature'.setup() end
		}
		use 'dense-analysis/ale'
		use 'L3MON4D3/LuaSnip'

		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate'
		}
		use {
			'nvim-telescope/telescope.nvim',
			requires = 'nvim-lua/plenary.nvim'
		}

		-- {{{ Language specific.
		use {
			'rust-lang/rust.vim',
			ft = 'rust',
		}
		use {
			'simrat39/rust-tools.nvim',
			ft = 'rust',
			config = function() require 'rust-tools'.setup() end
		}
		-- }}}

	end,
	-- display packer dialouge in the center in a floating window
	config = {
		display = {
			open_fn = require('packer.util').float,
		},
	},
})
