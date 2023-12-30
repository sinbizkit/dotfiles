local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local t = ls.t
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
local git = require "sinbizkit.git"

return {
  s(
    "li",
    fmt(
      [[
      //
      //  File: {}
      //  Created by Ivan Berdnikov on {}
      //
	    ]],
      {
        f(function()
          return vim.fn.expand "%:t"
        end),
        f(function()
          return os.date "%d/%m/%Y"
        end),
      }
    )
  ),
  s(
    "todo",
    fmt("//{type}({email}: {date}) {descr}", {
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
