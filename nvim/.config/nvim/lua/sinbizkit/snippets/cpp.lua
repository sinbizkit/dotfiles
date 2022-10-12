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

local git_user_email = function()
  local def_value = "i.berdnikov"
  local handle = io.popen "git config --get user.email"
  if handle == nil then
    return def_value
  end
  local result = handle:read "*a"
  handle:close()
  result = string.gsub(result, "\n", "")
  return #result > 0 and result or def_value
end

return {
  s(
    "li",
    fmt(
      [[
//  File: {}
//  Created by Ivan Berdnikov on {}
//
{}
]],
      {
        f(function()
          return vim.fn.expand "%:t"
        end),
        f(function()
          return os.date "%d/%m/%Y"
        end),
        i(0),
      }
    )
  ),

  s("inc", {
    t "#include ",
    c(1, {
      fmt([[<{}>]], { i(1) }),
      fmt([["{}"]], { i(1) }),
    }),
  }),

  s(
    "once",
    c(1, {
      sn(nil, { t { "#pragma once", "" }, i(1) }),
      sn(nil, {
        t "#ifndef ",
        d(1, function()
          return sn(nil, t(string.upper(string.gsub(vim.fn.expand "%:t", "%.", "_"))))
        end),
        t { "", "#define	" },
        rep(1),
        t { "", "", "" },
        i(2),
        t { "", "", "#endif" },
      }),
    })
  ),

  s(
    "for",
    { t "for (size_t i = 0, size = ", i(1, "arr"), t { ".size(); i < size; ++i) {", "\t" }, i(0), t { "", "}" } }
  ),

  s("foe", { t "for (const auto &val: ", i(1, "arr"), t { ") {", "\t" }, i(0), t { "", "}" } }),

  s("foi", {
    t "for (auto it = std::begin(",
    i(1, "arr"),
    t "), e = std::end(",
    rep(1),
    t { "); it != e; ++it) {", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("if", { t "if (", i(1), t { ") {", "\t" }, i(0), t { "", "}" } }),

  s("cast", {
    c(1, {
      fmt([[static_cast<{}>({})]], { i(1), i(2) }),
      fmt([[dynamic_cast<{}>({})]], { i(1), i(2) }),
      fmt([[reinterpret_cast<{}>({})]], { i(1), i(2) }),
    }),
  }),

  s("vec", fmt([[std::vector<{}> {} ]], { i(1), i(2) })),

  s(
    "map",
    c(1, {
      fmt([[std::map<{}, {}> {};]], { i(1), i(2), i(3) }),
      fmt([[std::unordered_map<{}, {}> {};]], { i(1), i(2), i(3) }),
    })
  ),

  s("ns", {
    c(1, {
      -- named namespace
      sn(nil, {
        t "namespace ",
        i(1),
        t { " {", "", "" },
        i(2),
        t { "", "", "} // namespace " },
        rep(1),
      }),
      -- anonymous namespace
      sn(nil, {
        t { "namespace { ", "", "" },
        i(1),
        t { "", "", "} // anonymous namespace" },
      }),
    }),
  }),

  s("sw", {
    t "switch(",
    i(1),
    t ") {",
    t { "", "case " },
    i(2),
    t { ": ", "" },
    i(0),
    t "break;",
    t { "", "default: break;" },
    t { "", "}" },
  }),

  s("cl", {
    t "class ",
    i(1, "ClassName "),
    c(2, {
      sn(nil, {
        t ": public ",
        i(1, "ParentName"),
      }),
      t "",
    }),
    t { " {", "" },
    t { "public:", "\t" },
    i(0),
    t { "", "};" },
  }),

  s("st", {
    t "struct ",
    i(1, "StructName "),
    t { " {", "" },
    t { "\t" },
    i(0),
    t { "", "};" },
  }),

  s("ctor", {
    d(1, function()
      return sn(nil, i(1, vim.fn.expand "%:t:r"))
    end),
    t "::",
    rep(1),
    t "()",
    c(2, {
      sn(nil, {
        t { " {", "\t" },
        i(1),
        t { "", "}" },
      }),
      t " = default;",
    }),
  }),

  s("dtor", {
    d(1, function()
      return sn(nil, i(1, vim.fn.expand "%:t:r"))
    end),
    t "::~",
    rep(1),
    t "()",
    c(2, {
      sn(nil, {
        t { " {", "\t" },
        i(1),
        t { "", "}" },
      }),
      t " = default;",
    }),
  }),

  s("fun", {
    i(3, "void"),
    t " ",
    i(1, "function"),
    t "(",
    i(2),
    t { ") {", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("mfun", {
    i(5, "void"),
    t " ",
    d(1, function()
      return sn(nil, i(1, vim.fn.expand "%:t:r"))
    end),
    t "::",
    i(2, "function"),
    t "(",
    i(3),
    t ") ",
    i(4),
    t { " {", "\t" },
    i(0),
    t { "", "}" },
  }),

  s("main", {
    t { "int main(int argc, char *argv[]) {", "\t" },
    i(0),
    t { "", "}" },
  }),

  s(
    "todo",
    fmt("//{}({}: {}) {}", {
      c(1, {
        i(nil, "TODO"),
        i(nil, "FIXME"),
        i(nil, "NOTE"),
      }),
      f(function()
        return git_user_email()
      end),
      f(function()
        return os.date "%d/%m/%y"
      end),
      i(0, "description"),
    })
  ),

  s("cfe", t "// clang-format on"),
  s("cfd", t "// clang-format off"),
}
