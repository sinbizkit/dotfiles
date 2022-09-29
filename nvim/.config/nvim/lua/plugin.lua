vim.cmd [[ filetype plugin indent on ]]

require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"

    use "nvim-lua/popup.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }

    use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    use {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("symbols-outline").setup {
          auto_preview = false,
          position = "left",
          relative_width = true,
          width = 25,
          show_relative_numbers = true,
          show_symbol_details = false,
        }
      end,
    }
    use "tpope/vim-fugitive"
    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
    }

    use "tpope/vim-surround"
    use {
      "phaazon/hop.nvim",
      branch = "v1", -- optional but strongly recommended
      config = function()
        require("hop").setup()
      end,
    }

    use "numToStr/Comment.nvim"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
    }

    use "neovim/nvim-lspconfig"
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lua" },
        { "onsails/lspkind-nvim" },
      },
    }

    use {
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup()
      end,
    }
    use "jose-elias-alvarez/null-ls.nvim"
    use "L3MON4D3/LuaSnip"

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }

    use {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup {
          separator = "―",
        }
      end,
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = "nvim-lua/plenary.nvim",
    }

    -- {{{ Language specific.
    use "rust-lang/rust.vim"
    use "simrat39/rust-tools.nvim"
    -- }}}
  end,
  -- display packer dialouge in the center in a floating window
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}
