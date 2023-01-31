local core_modules = {
  "options",
  -- Load keybindings and the editor options.
  "mappings",
  -- Load all plugins.
  "plugin",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
