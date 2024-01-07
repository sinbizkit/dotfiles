local M = {
  "rcarriga/nvim-notify"
}

function M.config()
  local notify = require "notify"
  vim.notify = notify
  notify.setup {
    timeout = 3000,
    stages = "static",
  }
end

return M
