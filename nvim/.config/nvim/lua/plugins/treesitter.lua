return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "cpp",
        "rust",
        "go",
        "lua",
        "python",
        "cmake",
        "javascript",
      },
      highlight = { -- enable highlighting for all file types
        enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      separator = "―",
    },
  },
}
