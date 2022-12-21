local M = {}

M.user_email = function()
  local def_value = "i.berdnikov"
  local handle = io.popen "git config --get user.email"
  if handle == nil then
    return def_value
  end
  local result = handle:read "*a"
  handle:close()
  result = string.gsub(result, "\n", "")
  return #result > 0 and result or def_value
end

return M
