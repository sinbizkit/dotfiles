local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  require("gitsigns").setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
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
      km.map("v", "<Leader>hh", function()
        gitsigns.reset_hunk { line ".", line "v" }
      end)
      km.map("n", "<Leader>hR", gitsigns.reset_buffer)
      -- Misc
      km.map("n", "<Leader>hu", gitsigns.undo_stage_hunk)
      km.map("n", "<Leader>hp", gitsigns.preview_hunk)
      km.map("n", "<Leader>hd", gitsigns.diffthis)
      km.map("n", "<Leader>hD", function()
        gitsigns.diffthis "~"
      end)
      km.map("n", "<Leader>hb", function()
        gitsigns.blame_line { full = true }
      end)
    end,
  }
end

return M
