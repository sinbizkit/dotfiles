local has_nvim_web_devicons, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not has_nvim_web_devicons then
  return
end

nvim_web_devicons.setup {}
