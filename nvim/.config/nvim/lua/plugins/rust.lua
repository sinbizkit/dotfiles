return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    opts = {
      server = {
        standalone = true,
        on_attach = function()
          require("sinbizkit.lsp.mappings").map_buf()
        end,
      },
    },
  },
}
