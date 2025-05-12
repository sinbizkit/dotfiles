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
    keep_roots = false,
    link_roots = false,
    link_children = true,
    exit_roots = true,
    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
  }

  -------------------------------------------------------------------------------
  -- Find and load snippets.
  -------------------------------------------------------------------------------
  local function load_snippets()
    local paths = vim.api.nvim_get_runtime_file("init.lua", false)
    if #paths ~= 1 then
      error "Config directory not found."
    end

    local path = vim.fn.fnamemodify(paths[1], ":p:h")
    path = vim.fn.join({ path, "lua/sinbizkit/snippets" }, "/")
    require("luasnip.loaders.from_lua").load { paths = path }
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

  km.map({ "i", "v" }, "<C-l>", function()
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
