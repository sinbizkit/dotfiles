local M = {}

function M.get_cur_buf_filename()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    return filepath
  end
  local filename = string.match(filepath, "/[%w-_.]+$")
  if filename == nil then
    return ""
  end
  return string.sub(filename, 2, #filename)
end

return M
