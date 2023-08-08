local M = {
  "tpope/vim-fugitive",
}

function M.config()
  local km = require "sinbizkit.keymap"
  km.map("n", "<Leader>ha", ":Git blame<CR>") -- git commit author
end

return M
