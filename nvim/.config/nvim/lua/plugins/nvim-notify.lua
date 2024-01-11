return {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 3000,
    stages = "static",
  },
  config = function(_, opts)
    local notify = require "notify"
    vim.notify = notify
    notify.setup(opts)
  end,
}
