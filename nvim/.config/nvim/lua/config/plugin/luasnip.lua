local ls = require "luasnip"
ls.config.set_config {
  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  ext_base_prio = 300,
  ext_prio_increase = 1,
}

local path = vim.api.nvim_get_runtime_file("init.lua", false)
if #path ~= 1 then
  error "Config directory not found."
end

path = vim.fn.fnamemodify(path[1], ":p:h")
path = vim.fn.join({ path, "lua/sinbizkit/snippets" }, "/")
local from_lua = require "luasnip.loaders.from_lua"
from_lua.load { paths = path }
