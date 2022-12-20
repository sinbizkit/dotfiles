local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
  return
end

luasnip.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
}

local path = vim.api.nvim_get_runtime_file("init.lua", false)
if #path ~= 1 then
  error "Config directory not found."
end

path = vim.fn.fnamemodify(path[1], ":p:h")
path = vim.fn.join({ path, "lua/sinbizkit/snippets" }, "/")
local from_lua = require "luasnip.loaders.from_lua"
from_lua.load { paths = path }
