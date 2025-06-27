local M = {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

M.opts = {
  ensure_installed = { "clangd", "gopls", "lua_ls", },
}

return M
