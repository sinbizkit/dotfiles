local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local f = ls.f
local t = ls.t
local c = ls.choice_node
local git = require "sinbizkit.git"

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

  s(
    "todo",
    fmt("-- {type}({email}: {date}) {descr}", {
      type = c(1, {
        t "TODO",
        t "FIXME",
        t "NOTE",
      }),
      email = f(git.user_email),
      date = f(function()
        return os.date "%d/%m/%y"
      end),
      descr = i(0, "description"),
    })
  ),
}
