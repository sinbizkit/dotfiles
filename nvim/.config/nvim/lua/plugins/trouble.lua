local M = {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
}

M.keys = {
  {
    "<Leader>sd",
    "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)",
  },
}

return M
