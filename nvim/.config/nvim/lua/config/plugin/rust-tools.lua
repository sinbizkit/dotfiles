local has_rust_tools, rust_tools = pcall(require, "rust-tools")
if not has_rust_tools then
  return
end

rust_tools.setup {
  server = {
    standalone = true,
    on_attach = function()
      require("keymap").map_lsp_keys()
    end,
  },
}
