local M = {
  "stevearc/conform.nvim",
  version = "9.*",
  lazy = true,
  keys = {
    {
      "<Leader>df",
      mode = { "n", "v" },
      function()
        local conform = require "conform"
        conform.format { lsp_format = "fallback" }
      end,
    },
  },
}

M.opts = {
  formatters_by_ft = {
    cpp = { "clang-format" },
    go = { "gofmt" },
    lua = { "stylua" },
    sql = { "sql_formatter" },
  },
}

return M
