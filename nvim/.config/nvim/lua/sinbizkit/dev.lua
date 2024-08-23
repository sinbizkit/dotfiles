local M = {}

--- Test function that is used in the process of writing and testing
-- new functionality.
function M.test()
  local query = vim.treesitter.query.parse(
    "go",
    [[
    (type_declaration
      (type_spec
        name: (type_identifier) @type_name))
    ]]
  )
  local parser = vim.treesitter.get_parser(0, "go")
  local tree = parser:parse()[1]
  for id, node, metadata in query:iter_captures(tree:root()) do
    local row1, col1, row2, col2 = node:range()
    vim.notify(vim.api.nvim_buf_get_text(0, row1, col1, row2, col2, {}))
  end
end

return M
