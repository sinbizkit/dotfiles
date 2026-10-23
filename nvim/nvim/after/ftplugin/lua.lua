local km = require "sinbizkit.keymap"
km.buf_map("n", "<Space>x", function()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.cmd [[ .lua ]]
  vim.notify(string.format("Code executed (%d)", row), vim.log.levels.INFO, {
    title = "Lua",
    render = "compact",
  })
end)
km.buf_map("v", "<Leader>x", ":lua<CR>")
km.buf_map("v", "<Space>x", function()
  -- Exit visual mode.
  vim.cmd [[execute "normal! \<Esc>"]]
  -- Get the visual selection line numbers.
  local start_row, end_row = vim.fn.line "'<", vim.fn.line "'>"
  vim.cmd { cmd = "lua", range = { start_row, end_row } }
  vim.notify(string.format("Code executed (%d..%d)", start_row, end_row), vim.log.levels.INFO, {
    title = "Lua",
    render = "compact",
  })
end)
