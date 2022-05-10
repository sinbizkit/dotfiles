require("rust-tools").setup {
  server = {
    standalone = true,
    on_attach = function()
      require("keymap").map_lsp_keys()
    end,
  },
}
