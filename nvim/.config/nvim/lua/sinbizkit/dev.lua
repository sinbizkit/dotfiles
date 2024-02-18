local M = {}

--- Test function that is used in the process of writing and testing
-- new functionality.
function M.test()
  vim.notify("Hello there! Let's build new stuff!", vim.log.levels.INFO, {
    title = "Dev",
    render = "compact",
  })
end

return M
