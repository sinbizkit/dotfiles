local M = {
  "nvimtools/none-ls.nvim",
  ft = "lua",
  dependecies = { "nvim-lua/plenary.nvim" },
}

M.opts = function(_, opts)
  local null_ls = require "null-ls"
  opts.sources = { null_ls.builtins.formatting.stylua }
end

return M
