local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
  return
end

local has_luasnip, luasnip = pcall(require, "luasnip")
local lsp_expand
if has_luasnip then
  lsp_expand = function(args)
    luasnip.lsp_expand(args.body)
  end
end

local has_lspkind, lspkind = pcall(require, "lspkind")
local lspkind_format
if has_lspkind then
  lspkind_format = lspkind.cmp_format {
    with_text = true,
    maxwidth = 50,
    menu = { buffer = "[Buf]", nvim_lsp = "[LSP]", path = "[Path]" },
  }
end

cmp.setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  snippet = {
    expand = lsp_expand
  },
  formatting = {
    format = lspkind_format,
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
