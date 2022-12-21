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

local km = require "sinbizkit.keymap"
km.map("n", "<F6>", "<Cmd>NvimTreeToggle<CR>")
km.map("n", "<Leader><F6>", "<Cmd>NvimTreeFindFile<CR>")
