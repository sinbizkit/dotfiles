local M = {
  "tpope/vim-fugitive",
}

local function toggle_fugitive()
  local bufn = vim.fn.bufnr "^fugitive:"
  local winid = vim.fn.bufwinid(bufn)
  if bufn == -1 or winid == -1 then
    vim.cmd ":Git"
    return
  end
  vim.api.nvim_win_close(winid, false)
end

function M.config()
  local km = require "sinbizkit.keymap"
  km.map("n", "<Leader>G", toggle_fugitive) -- toggle fugitive main window
  km.map("n", "<Leader>ha", ":Git blame<CR>") -- git commit author
  km.map("v", "<Leader>ha", ":'<,'>Git blame<CR>") -- git commit author
end

return M
