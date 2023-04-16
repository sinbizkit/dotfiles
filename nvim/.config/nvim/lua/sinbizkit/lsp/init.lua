vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("sb-lsp-mappings", {}),
  callback = function()
    require("sinbizkit.lsp.mappings").map_buf()
  end,
})
