local km = require "sinbizkit.keymap"

return {
  map_buf = function()
    -- s - show.
    km.buf_map("n", "<Leader>sh", vim.lsp.buf.hover)
    km.buf_map("n", "<Leader>si", vim.lsp.buf.signature_help)
    km.buf_map("n", "<Leader>sd", vim.diagnostic.open_float)

    -- g - go.
    km.buf_map("n", "<Leader>gD", vim.lsp.buf.declaration)
    km.buf_map("n", "<Leader>gI", vim.lsp.buf.implementation)
    km.buf_map("n", "<Leader>gn", vim.diagnostic.goto_next)
    km.buf_map("n", "<Leader>gp", vim.diagnostic.goto_prev)

    -- d - do
    km.buf_map("n", "<Leader>di", vim.lsp.buf.code_action)
    km.buf_map("n", "<Leader>dr", vim.lsp.buf.rename)
    km.buf_map({ "n", "v" }, "<Leader>df", vim.lsp.buf.format)

    -- lspconfig
    if pcall(require, "lspconfig") then
      km.buf_map("n", "<Leader>rl", function()
        vim.cmd [[ LspRestart ]]
        vim.notify("LSP servers are reloaded.", vim.log.levels.INFO, {
          title = "LspConfig",
          render = "compact",
        })
      end)
    end

    -- Telescope
    if pcall(require, "telescope") then
      local builtin = require "telescope.builtin"
      km.buf_map("n", "<Leader>gr", builtin.lsp_references)
      km.buf_map("n", "<Leader>gd", builtin.lsp_definitions)
      km.buf_map("n", "<Leader>gt", builtin.lsp_type_definitions)
      km.buf_map("n", "<Leader>gi", builtin.lsp_implementations)
      km.buf_map("n", "<Leader>ss", builtin.lsp_document_symbols)
      km.buf_map("n", "<Leader>sS", builtin.lsp_dynamic_workspace_symbols)
    end
  end,
}
