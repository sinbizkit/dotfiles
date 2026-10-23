local M = {
  "folke/trouble.nvim",
  lazy = true,
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<Leader>sd",
      mode = "n",
      "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<Leader>sD",
      mode = "n",
      "<cmd>Trouble diagnostics toggle focus=false<cr>",
      desc = "Diagnostics (Trouble)",
    },
  },
}

return M
