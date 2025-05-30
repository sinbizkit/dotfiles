local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

M.opts = {
  signs = {
    add = { text = "▌" },
    change = { text = "▌" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },

  on_attach = function()
    local gitsigns = package.loaded.gitsigns
    local km = require "sinbizkit.keymap"
    local line = vim.fn.line
    -- Stage
    km.map("n", "<Leader>hs", gitsigns.stage_hunk)
    km.map("v", "<Leader>hs", function()
      gitsigns.stage_hunk { line ".", line "v" }
    end)
    km.map("n", "<leader>hS", gitsigns.stage_buffer)
    -- Reset
    km.map("n", "<Leader>hr", gitsigns.reset_hunk)
    km.map("v", "<Leader>hr", function()
      gitsigns.reset_hunk { line ".", line "v" }
    end)
    km.map("n", "<Leader>hR", gitsigns.reset_buffer)
    -- Misc
    km.map("n", "<Leader>hu", gitsigns.undo_stage_hunk)
    km.map("n", "<Leader>hv", gitsigns.preview_hunk)
    km.map("n", "<Leader>hd", gitsigns.diffthis)
    km.map("n", "<Leader>hD", function()
      gitsigns.diffthis "~"
    end)
    km.map("n", "<Leader>hb", gitsigns.blame_line)
    km.map("n", "<Leader>hB", function()
      gitsigns.blame_line { full = true }
    end)
    -- Navigate
    km.map("n", "<Leader>hn", function()
      gitsigns.nav_hunk "next"
    end)
    km.map("n", "<Leader>hp", function()
      gitsigns.nav_hunk "prev"
    end)
  end,
}

return M
