local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

M.opts = {
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
    "sql",
    "cmake",
    "bash",
    "javascript",
    "json",
  },
  sync_install = false,
  highlight = { -- enable highlighting for all file types
    enable = true, -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
    ---@diagnostic disable-next-line: unused-local
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      ---@diagnostic disable-next-line: undefined-field
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end,
  },
  indent = { -- indentation based on treesitter for the |=| operator.
    enable = false,
  },
}

function M.config(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return M
