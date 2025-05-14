return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "query",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "rust",
      "go",
      "lua",
      "python",
      "cmake",
      "bash",
      "javascript",
      "json",
    },
    sync_install = false,
    highlight = { -- enable highlighting for all file types
      enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    },
    indent = { -- indentation based on treesitter for the |=| operator.
      enable = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
