local M = {
  settings = {
    gopls = {
      semanticTokens = true,
      usePlaceholders = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        functionTypeParameters = true,
        parameterNames = true,
        constantValues = true,
        rangeVariableTypes = true,
      },
    },
  },
}

return M
