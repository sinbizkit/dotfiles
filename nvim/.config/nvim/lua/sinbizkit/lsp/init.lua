vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("sb-lsp-mappings", {}),
  callback = function(args)
    require("sinbizkit.lsp.mappings").map_buf()
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})
