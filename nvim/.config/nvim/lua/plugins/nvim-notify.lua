local M = {
  "rcarriga/nvim-notify",
}

M.opts = {
  timeout = 3000,
  stages = "static",
}

M.config = function(_, opts)
  local notify = require "notify"
  vim.notify = notify
  notify.setup(opts)
end

return M
