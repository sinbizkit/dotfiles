local has_catppuccin, catppuccin = pcall(require, "catppuccin")
if not has_catppuccin then
  return
end

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
catppuccin.setup()
vim.cmd [[ colorscheme catppuccin ]]
