local M = {
  "ray-x/lsp_signature.nvim",
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("sb-lsp_signature", {}),
  callback = function (args)
    if not (args.data and args.data.client_id) then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require"lsp_signature".on_attach(client, args.buf)
  end,
})

return M
