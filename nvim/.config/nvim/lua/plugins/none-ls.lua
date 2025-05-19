local M = {
  "nvimtools/none-ls.nvim",
  ft = "lua",
}

M.opts = function(_, opts)
  local null_ls = require "null-ls"
  opts.sources = { null_ls.builtins.formatting.stylua }
end

return M
