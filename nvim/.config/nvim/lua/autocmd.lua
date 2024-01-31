vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  group = vim.api.nvim_create_augroup("sb-open-buffer-cursor", { clear = true }),
  pattern = "*",
  command = 'silent! normal! g`"zv',
})
