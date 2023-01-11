local has_tokyonight, tokyonight = pcall(require, "tokyonight")
if not has_tokyonight then
  return
end

vim.cmd [[ colorscheme tokyonight-moon ]]
