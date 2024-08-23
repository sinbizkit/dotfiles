local opt = vim.opt_local

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Set default values to the terminal buffer on opening",
  group = vim.api.nvim_create_augroup("sb-term-open", { clear = true }),
  callback = function()
    opt.number = false
    opt.relativenumber = false
    opt.scrolloff = 0

    vim.bo.filetype = "terminal"
  end,
})

-- Easily hit escape in terminal mode.
local km = require "sinbizkit.keymap"
km.map("t", "<Esc>", "<C-\\><C-n>")

-- Open a terminal at the bottom of the screen.
km.map("n", "<Leader>ot", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
  vim.cmd "startinsert"
end)
