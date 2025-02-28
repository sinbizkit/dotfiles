return {

  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      view = {
        adaptive_size = true,
        number = false,
        signcolumn = "no",
        relativenumber = true,
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
    keys = { "<F6>", "<Leader><F6>" },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      local km = require "sinbizkit.keymap"
      km.map("n", "<F6>", "<Cmd>NvimTreeToggle<CR>")
      km.map("n", "<Leader><F6>", "<Cmd>NvimTreeFindFile<CR>")
    end,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function(_, opts)
      require("oil").setup(opts)
      local km = require "sinbizkit.keymap"
      km.map("n", "-", "<Cmd>Oil<CR>")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "filename" }, { "diff" } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = {
          { "diagnostics", sources = { "nvim_diagnostic" } },
          { "progress" },
        },
        lualine_z = { "location" },
      },

      tabline = {
        lualine_a = {
          {
            "tabs",
            max_length = vim.o.columns,
            mode = 2,
          },
        },
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = { enabled = true },
        char = { enabled = true },
      },
    },
    keys = {
      {
        "<Leader>j",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
      },
      {
        "<Leader>J",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
      },
    },
  },

  "tpope/vim-surround",

  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        ---Line-comment toggle keymap
        line = "<Leader>cc",
        ---Block-comment toggle keymap
        block = "<Leader>bc",
      },
      opleader = {
        ---Line-comment keymap
        line = "<Leader>c",
        ---Block-comment keymap
        block = "<Leader>b",
      },
    },
  },

  {
    "simrat39/symbols-outline.nvim",
    opts = {
      auto_preview = false,
      position = "right",
      relative_width = true,
      width = 25,
      show_relative_numbers = true,
      show_symbol_details = false,
    },
    keys = "<F5>",
    config = function(_, opts)
      require("symbols-outline").setup(opts)
      local km = require "sinbizkit.keymap"
      km.map("n", "<F5>", "<Cmd>SymbolsOutline<CR>")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    opts = { "css" },
    keys = { "<Leader>sc" },
    config = function(_, opts)
      require("colorizer").setup(opts)
      local km = require "sinbizkit.keymap"
      km.map("n", "<Leader>sc", "<Cmd>ColorizerToggle<CR>")
    end,
  },
}
