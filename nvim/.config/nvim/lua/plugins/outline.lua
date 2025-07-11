local M = {
  "hedyhli/outline.nvim",
  keys = "<F5>",
}

M.opts = {
  outline_window = {
    position = "right",
    width = 30,
    relative_width = true,
    show_relative_numbers = true,
    show_cursorline = true,
    hide_cursor = false,
  },
  outline_items = {
    show_symbol_details = true,
  },
  preview_window = {
    auto_preview = false,
  },
}

function M.config(_, opts)
  local km = require "sinbizkit.keymap"
  km.map("n", "<F5>", "<Cmd>Outline<CR>", { desc = "Toggle Symbols Outline" })
  require("outline").setup(opts)
end

return M
