return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"
      local modules = { "cpp", "rust", "go", "lua", "python", "cmake", "javascript" }

      configs.setup {
        -- ensure_installed can be "all" or a list of languages { "python", "javascript" }
        ensure_installed = modules,
        highlight = { -- enable highlighting for all file types
          enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      separator = "―",
    },
  },
}
