local M = {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "2.*",
  build = "make install_jsregexp",
}

function M.config()
  local luasnip = require "luasnip"

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
  local load_snippets = function()
    local path = vim.api.nvim_get_runtime_file("init.lua", false)
    if #path ~= 1 then
      error "Config directory not found."
    end

    path = vim.fn.fnamemodify(path[1], ":p:h")
    path = vim.fn.join({ path, "lua/sinbizkit/snippets" }, "/")
    local from_lua = require "luasnip.loaders.from_lua"
    from_lua.load { paths = path }
  end
  load_snippets()

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
    load_snippets()
    vim.notify("Snippets are reloaded.", vim.log.levels.INFO, {
      title = "LuaSnip",
      render = "compact",
    })
  end)
end

return M
