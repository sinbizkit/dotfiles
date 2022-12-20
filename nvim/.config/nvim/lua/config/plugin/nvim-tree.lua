local has_nvim_tree, nvim_tree = pcall(require, "nvim-tree")
if not has_nvim_tree then
  return
end

nvim_tree.setup {
  view = {
    width = 40,
    number = false,
    signcolumn = "no",
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
}
