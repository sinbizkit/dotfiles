local core_modules = {
  -- Load all plugins.
  "plugin",
  -- Load keybindings and the editor options.
  "options",
  "keymap",
  -- Load various configurations (plugins, lsp, ...)
  "config.plugin",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
