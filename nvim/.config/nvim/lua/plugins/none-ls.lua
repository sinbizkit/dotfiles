return {
  {
    "nvimtools/none-ls.nvim",
    ft = "lua",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = { null_ls.builtins.formatting.stylua }
    end,
  },
}

