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

return {
  s(
    "cmh",
    fmt(
      [[
      # ============================================================================ #
      # {}
      # ============================================================================ #
	    ]],
      { i(1) }
    )
  ),
}
