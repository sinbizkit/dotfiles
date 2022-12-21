local has_null_ls, null_ls = pcall(require, "null-ls")
if not has_null_ls then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
  },
}
