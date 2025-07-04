local km = require "sinbizkit.keymap"

local function map_lsp_keys()
  -- s - show.
  km.buf_map("n", "<Leader>sh", vim.lsp.buf.hover)
  km.buf_map("n", "<C-S>", vim.lsp.buf.signature_help)

  -- g - go.
  km.buf_map("n", "<Leader>gD", vim.lsp.buf.declaration)
  km.buf_map("n", "<Leader>gI", vim.lsp.buf.implementation)
  km.buf_map("n", "<Leader>gn", function()
    vim.diagnostic.jump { count = 1, float = true }
  end)
  km.buf_map("n", "<Leader>gp", function()
    vim.diagnostic.jump { count = -1, float = true }
  end)

  -- d - do
  km.buf_map("n", "<Leader>di", vim.lsp.buf.code_action)
  km.buf_map("n", "<Leader>dr", vim.lsp.buf.rename)

  -- inlay-hints
  km.buf_map("n", "<F4>", function()
    local enabled = vim.lsp.inlay_hint.is_enabled {}
    vim.notify(
      string.format("Inlay hints %s", enabled and "disabled" or "enabled"),
      vim.log.levels.INFO,
      {
        title = "LSP",
        render = "compact",
      }
    )
    vim.lsp.inlay_hint.enable(not enabled)
  end)

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
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("sb-lsp-mappings", {}),
  callback = function(args)
    if vim.opt.diff:get() then
      return
    end
    map_lsp_keys() -- map lsp-specific keymaps.
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})
