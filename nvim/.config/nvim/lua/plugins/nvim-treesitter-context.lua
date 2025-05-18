local M = {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = true,
  opts = {
    multiline_threshold = 5,
    separator = "―",
  },
}

M.config = function(_, opts)
  local ctx = require "treesitter-context"

  local km = require "sinbizkit.keymap"
  km.map({ "n", "v" }, "<F3>", function()
    ctx.toggle()
    vim.notify(
      string.format("Context %s", ctx.enabled() and "enabled" or "disabled"),
      vim.log.levels.INFO,
      {
        title = "Treesitter",
        render = "compact",
      }
    )
  end)

  ctx.setup(opts)
end

return M
