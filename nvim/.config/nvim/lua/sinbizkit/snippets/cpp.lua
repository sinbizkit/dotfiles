local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local rep = require("luasnip.extras").rep

return {
	s("sinc", fmt(
		[[
		#include <{}>
		]], { i(1) })
	),
	s("inc", fmt(
		[[
		#include "{}"
		]], { i(1) })
	),
}
