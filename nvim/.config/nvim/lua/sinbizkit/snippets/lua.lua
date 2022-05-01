local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local f = ls.f

return {
	s("req",
		fmt([[local {} = require("{}")]], {
			f(function(args)
				local splitted = vim.split(args[1][1], ".", { plain = true })
				return splitted[#splitted]
			end, { 1 }),
			i(1),
		})
	),
}

