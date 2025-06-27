local M = {
  "stevearc/conform.nvim",
  version = "9.*",
}

M.opts = {
  formatters_by_ft = {
    cpp = { "clang-format" },
    go = { "gofmt" },
    lua = { "stylua" },
    sql = { "sql_formatter" },
  },
}

function M.config(_, opts)
  local conform = require "conform"
  conform.setup(opts)

  local km = require "sinbizkit.keymap"
  km.buf_map({ "n", "v" }, "<Leader>df", function()
    conform.format { lsp_format = "fallback" }
  end)
end

return M
