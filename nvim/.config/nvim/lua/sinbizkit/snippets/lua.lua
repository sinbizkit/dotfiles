local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local f = ls.f
local t = ls.t

-- compute required module name from module path.
local mod_name = function(args)
  local splitted = vim.split(args[1][1], ".", { plain = true })
  return splitted[#splitted]:gsub("-", "_")
end

return {
  -- `local <name> = require("<module-name>")`
  s(
    "req",
    fmt([[local {} = require "{}"]], {
      f(mod_name, { 1 }),
      i(1),
    })
  ),

  -- `local has_<name>, <name> = pcall(require, "<module-name>")`
  s(
    "pc",
    fmt([[local has_{}, {} = pcall(require, "{}")]], {
      f(mod_name, { 1 }),
      f(mod_name, { 1 }),
      i(1),
    })
  ),

  -- header.
  s(
    "cmh",
    fmt(
      [[
      -------------------------------------------------------------------------------
      -- {}
      -------------------------------------------------------------------------------
      ]],
      { i(1) }
    )
  ),

  -- footer.
  s("cmf", {
    t "-------------------------------------------------------------------------------",
  }),
}
