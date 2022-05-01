local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local rep = require("luasnip.extras").rep

return {
	s({ trig = "sincc", name = "system include directive" }, fmt(
		[[
		#include <{}>
		]], { i(1) })
	),
	s({ trig = "inc", name = "include directive" }, fmt(
		[[
		#include "{}"
		]], { i(1) })
	),
	s({ trig = "main", name = "main function template" }, fmt(
		[[
		int main(int argc, char *argv[]) {{
			{}
		}}
		]], { i(0) })
	),
}
