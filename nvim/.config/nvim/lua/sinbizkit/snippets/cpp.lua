local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local t = ls.t
local c = ls.choice_node
local rep = require("luasnip.extras").rep

return {
	s("inc", {
		t "#include ",
		c(1, {
			fmt([[<{}>]], { i(1) }),
			fmt([["{}"]], { i(1) }),
		}),
	}),

	s("for", {
		t "for (",
		c(1, {
			fmt([[auto i = 0, size = {}.size(); i < size; ++i]], { i(1, "arr") }),
			fmt([[const auto &val: {}]], { i(1, "arr") }),
			fmt([[auto it = {}.begin(), end = {}.end(); begin != end; ++it]], { i(1, "arr"), rep(1) }),
		}),
		t { ") {", "\t" },
		i(0), t { "", "}" },
	}),

	s("cast", {
		c(1, {
			fmt([[static_cast<{}>({})]], { i(1), i(2) }),
			fmt([[dynamic_cast<{}>({})]], { i(1), i(2) }),
			fmt([[reinterpret_cast<{}>({})]], { i(1), i(2) }),
		}),
	}),

	s("vec", fmt([[std::vector<{}> {} ]], { i(1), i(2) })),

	s("map", c(1, {
		fmt([[std::map<{}, {}> {} ]], { i(1), i(2), i(3) }),
		fmt([[std::unordered_map<{}, {}> {} ]], { i(1), i(2), i(3) }),
	})),

	s("ns", c(1, {
		fmt([[namespace {} {{ {} }} // namespace {}]], { i(1), i(0, "end"), rep(1) }),
		fmt([[namespace {{ {} }} // namespace]], { i(0) })
	})),

	s("sw", {
		t "switch(", i(1), t ") {",
		t({ "", "case " }), i(2), t({ ": ", "" }),
		i(0), t "break;",
		t({ "", "default: break;" }),
		t({ "", "}" })
	}),

	s("fun", {
		i(2, "void"), t " ", i(1, "function"), t({ " {", "\t" }),
		i(0), t({ "", "}" })
	}),

	s("main", {
		t { "int main(int argc, char *argv[]) {", "\t" },
		i(0),
		t { "", "}" },
	}),
}
