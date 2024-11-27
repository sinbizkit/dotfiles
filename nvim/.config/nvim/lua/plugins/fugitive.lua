local M = {
  "tpope/vim-fugitive",
}

function M.config()
  local km = require "sinbizkit.keymap"
  km.map("n", "<Leader>G", ":Git<CR>") -- fugitive main window
  km.map("n", "<Leader>ha", ":Git blame<CR>") -- git commit author
  km.map("v", "<Leader>ha", ":'<,'>Git blame<CR>") -- git commit author
end

return M
