local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
  return
end

-------------------------------------------------------------------------------
-- Common.
-------------------------------------------------------------------------------
luasnip.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
}

-------------------------------------------------------------------------------
-- Find and load snippets.
-------------------------------------------------------------------------------
local path = vim.api.nvim_get_runtime_file("init.lua", false)
if #path ~= 1 then
  error "Config directory not found."
end

path = vim.fn.fnamemodify(path[1], ":p:h")
path = vim.fn.join({ path, "lua/sinbizkit/snippets" }, "/")
local from_lua = require "luasnip.loaders.from_lua"
from_lua.load { paths = path }

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------
local km = require "sinbizkit.keymap"
km.map("i", "<C-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end)

km.map("i", "<C-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

km.map("i", "<C-l>", function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end)

-- Snippets reload.
km.map("n", "<Leader>rs", function()
  local luasnip_path = vim.api.nvim_get_runtime_file("lua/config/plugin/luasnip.lua", false)
  if #luasnip_path ~= 1 then
    error "Snippet file not found."
    return
  end
  vim.cmd("source " .. luasnip_path[1])
  print "Snippets are reloaded."
end)
