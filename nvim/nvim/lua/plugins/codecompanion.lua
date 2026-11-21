local M = {
  "olimorris/codecompanion.nvim",
  version = "^20.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion", "codecompanion_chat_input" }
    },
  },
}

-- To set up CodeCompanion, you need to provide local settings
-- for available models and their adapters.
local has_localsettings, local_settings = pcall(require, "sinbizkit.local.codecompanion")
if not has_localsettings then
  M.enabled = false
  return M
end

M.opts = local_settings.options()
M.opts.display = {
  chat = {
    window = {
      layout = "vertical", -- Can be "float", "vertical", "horizontal", "tab" or "buffer"
      position = "right",  -- Can be "left", "right", "top" or "bottom"
      width = 0.3,
    },
  },
}

function M.config(_, opts)
  local codecompanion = require "codecompanion"
  codecompanion.setup(opts)
  local km = require "sinbizkit.keymap"
  km.map({ "n", "v" }, "<Leader>ai", "<Cmd>CodeCompanionChat Toggle<CR>")
  km.map({ "n", "v" }, "<Leader>aa", "<Cmd>CodeCompanion<CR>")
end

return M
