local M = {
  "neovim/nvim-lspconfig",
  dependecies = { "saghen/blink.cmp" },
}

function M.config()
  local km = require "sinbizkit.keymap"
  km.buf_map("n", "<Leader>rl", function()
    vim.cmd [[ lsp restart ]]
    vim.notify("LSP servers are reloaded.", vim.log.levels.INFO, {
      title = "LspConfig",
      render = "compact",
    })
  end)
end

return M
