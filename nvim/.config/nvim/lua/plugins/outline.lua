local M = {
  "hedyhli/outline.nvim",
  lazy = true,
  keys = {
    { "<F5>", mode = { "n" }, "<Cmd>Outline<CR>" },
  },
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

return M
