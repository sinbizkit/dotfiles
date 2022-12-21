local M = {}

-- A handy shorthand for vim.api.nvim_set_keymap with reasonable default opts.
M.map = function(modes, bind, exec, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(modes, bind, exec, options)
end

-- A handy shorthand for vim.api.nvim_buf_set_keymap with reasonable default opts.
M.buf_map = function(mode, bind, exec, opts)
  local options = { noremap = true, silent = true, buffer = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, bind, exec, options)
end

return M
