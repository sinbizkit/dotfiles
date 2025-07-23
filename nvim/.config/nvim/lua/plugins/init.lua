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
        timeout = 10000, -- set timeout for 10 seconds.
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
    lazy = true,
    opts = {},
    keys = {
      {
        "-",
        mode = { "n", "v" },
        "<Cmd>Oil<CR>",
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
    },
  },

  "tpope/vim-surround",

  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    opts = { "css" },
    keys = {
      { "<Leader>sc", modes = { "n" }, "<Cmd>ColorizerToggle<CR>" },
    },
  },
}
