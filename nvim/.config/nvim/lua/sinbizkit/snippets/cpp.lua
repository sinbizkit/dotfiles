local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local t = ls.t
local c = ls.choice_node
local r = ls.restore_node
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
      //  File: {}
      //  Created by Ivan Berdnikov on {}
      //
      {}]],
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
        sn(nil, { t '"', r(1, "header", i(1)), t'"' }),
        sn(nil, { t '<', r(1, "header", i(1)), t'>' }),
      }),
  }),

  s(
    "once",
    c(1, {
      sn(nil, { t { "#pragma once", "" }, i(1) }),
      fmt(
        [[
        #ifndef {guard}
        #define {guard_rep}

        {content}

        #endif
        ]],
        {
          guard = d(1, function()
            return sn(nil, t(string.upper(string.gsub(vim.fn.expand "%:t", "%.", "_"))))
          end),
          guard_rep = rep(1),
          content = i(2),
        }
      ),
    })
  ),

  s(
    "cmh",
    c(1, {
      fmt(
        [[
      //------------------------------------------------------------------------------
      // {}
      //------------------------------------------------------------------------------
      ]],
        { i(1) }
      ),
      fmt(
        [[
      //-------------------------------
      // {}
      //-------------------------------
      ]],
        { i(1) }
      ),
    })
  ),

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
      fmt(
        [[
        namespace {name} {{

        {content}

        }} // namespace {name_rep}
        ]],
        {
          name = i(1),
          content = i(2),
          name_rep = rep(1),
        }
      ),
      -- anonymous namespace
      sn(nil, {
        t { "namespace { ", "", "" },
        i(1),
        t { "", "", "} // anonymous namespace" },
      }),
    }),
  }),

  s(
    "cl",
    fmt(
      [[
      class {name} {{
      public:
        {content}
      }};
      ]],
      { name = i(1, "Name"), content = i(0) }
    )
  ),

  s(
    "st",
    fmt(
      [[
      struct {name} {{
        {content}
      }};
      ]],
      { name = i(1, "Name"), content = i(0) }
    )
  ),

  s(
    "en",
    fmt(
      [[
      {enum_type} {enum_name} {{
      {enum_content}
      }};
      ]],
      {
        enum_type = c(1, {
          t "enum",
          t "enum class",
        }),
        enum_name = i(2, "Name"),
        enum_content = i(0),
      }
    )
  ),

  s(
    "ctor",
    fmt([[ {name}::{name_rep}({params}) {body}]], {
      name = d(1, function()
        return sn(nil, i(1, vim.fn.expand "%:t:r"))
      end),
      name_rep = rep(1),
      params = i(2),
      body = c(3, {
        sn(1, {
          t { "{", "\t" },
          i(1),
          t { "", "}" },
        }),
        t "= default;",
      }),
    })
  ),

  s(
    "dtor",
    fmt([[ {name}::~{name_rep}() {body}]], {
      name = d(1, function()
        return sn(nil, i(1, vim.fn.expand "%:t:r"))
      end),
      name_rep = rep(1),
      body = c(2, {
        sn(1, {
          t { "{", "\t" },
          i(1),
          t { "", "}" },
        }),
        t "= default;",
      }),
    })
  ),

  s(
    "fn",
    fmt(
      [[
      {ret} {name}({params}) {{
        {content}
      }}
      ]],
      {
        ret = i(3, "void"),
        name = i(1, "name"),
        params = i(2),
        content = i(0),
      }
    )
  ),

  s(
    "mfn",
    fmt(
      [[ 
      {ret} {cl_name}::{name}({params}) {cv_qual}{{
        {content}
      }}
      ]],
      {
        ret = i(5, "void"),
        cl_name = d(1, function()
          return sn(nil, i(1, vim.fn.expand "%:t:r"))
        end),
        name = i(2, "name"),
        params = i(3),
        cv_qual = i(4),
        content = i(0),
      }
    )
  ),

  s(
    "main",
    fmt(
      [[
      int main(int argc, char *argv[]) {{
        {}
      }}
      ]],
      { i(1) }
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

  s("cfe", t "// clang-format on"),
  s("cfd", t "// clang-format off"),
}
