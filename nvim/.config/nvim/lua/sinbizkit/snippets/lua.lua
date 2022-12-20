local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.s
local i = ls.i
local f = ls.f
local rep = require("luasnip.extras").rep

return {
  s(
    "req",
    fmt([[local {} = require "{}"]], {
      f(function(args)
        local splitted = vim.split(args[1][1], ".", { plain = true })
        return splitted[#splitted]:gsub("-", "_")
      end, { 1 }),
      i(1),
    })
  ),
  s(
    "pc",
    fmt([[local has_{}, {} = pcall(require, "{}")]], {
      f(function(args)
        local splitted = vim.split(args[1][1], ".", { plain = true })
        return splitted[#splitted]:gsub("-", "_")
      end, { 1 }),
      rep(1),
      i(1),
    })
  ),
}
