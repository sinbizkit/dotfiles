local M = {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  version = "1.*",
  opts_extend = { "sources.default" },
}

M.opts = {
  keymap = { preset = "enter" },
  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    list = { selection = { preselect = true, auto_insert = true } },
    documentation = { auto_show = true },
    ghost_text = { enabled = false },
  },

  snippets = { preset = "luasnip" },
  sources = {
    default = { "snippets", "lsp", "path", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
}

return M
