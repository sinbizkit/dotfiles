local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local s = ls.s
local i = ls.i
local t = ls.t
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
local git = require "sinbizkit.git"

---Dictionary mapping a built-in Go type to its zero value.
local default_values = {
  -- basic Go types.
  bool = false,

  -- ints.
  int = "0",
  int8 = "0",
  int16 = "0",
  int32 = "0",
  int64 = "0",
  uint = "0",
  uint8 = "0",
  uint16 = "0",
  uint32 = "0",
  uint64 = "0",
  uintptr = "0",
  byte = "0", -- alias for uint8
  rune = "0", -- alias for int32

  -- doubles
  float32 = "0.0",
  float64 = "0.0",

  -- etc.
  string = '""',
  error = function(_, info)
    return t(info.err_name)
  end,

  -- reference types
  [function(text)
    -- pointers.
    if string.find(text, "*", 1, true) ~= nil then
      return true
    end
    -- slices
    if string.match(text, "^%[%]") ~= nil then
      return true
    end
    -- maps
    if string.match(text, "^map%[[_%w]+%]") ~= nil then
      return true
    end
    -- channels
    if string.match(text, "%f[%w_]chan%f[^%w_]") then
      return true
    end
    return false
  end] = "nil",
}

---Transforms the text info a snippet Node.
local function transform(text, info)
  local function condition_matches(condition, ...)
    -- It is implied that the condition can be either a string or a functor.
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  -- Looking for an applicable default value iterating through the keys.
  for condition, result in pairs(default_values) do
    if condition_matches(condition, text, info) then
      -- If the condition's handler type is a plain string - use it for
      -- constructing simple TextNode...
      if type(result) == "string" then
        return t(result)
      else
        -- ...Assume that it is a callable handler otherwise.
        return result and result(text, info)
      end
    end
  end

  return t(text .. "{}")
end

---Dictionary of various TSNode::types used in Go as a return value expression
---with corresponding transforming handlers.
local handlers = {
  --- func Name(...) (a, b, c, d)
  parameter_list = function(node, info)
    local result = {}
    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local child = node:named_child(idx)
      local type_node = child:field("type")[1]
      table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t { ", " })
      end
    end
    return result
  end,
  --- func Name(...) bool/int/MyStruct
  type_identifier = function(node, info)
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end,
  --- func Name(...) pb.Message
  qualified_type = function(node, info)
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end
}

---Computes the return types of the current function where the cursor is located, and returns a table of snippets corresponding to each of them.
local function retvals_snips_dict(info)
  -- Types of target nodes.
  local func_node_types = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
  }

  -- Get a current node under the cursor and looking up the TSTree for a TSNode
  -- with a suitable type.
  local node = vim.treesitter.get_node()
  while node ~= nil do
    if func_node_types[node:type()] then
      break
    end
    node = node:parent()
  end

  -- Return an InsertNode if no match.
  if not node then
    vim.notify("Not inside a function", vim.log.levels.ERROR, {
      title = "LuaSnip",
      render = "compact",
    })
    return i(nil, "return_value")
  end

  local query = assert(vim.treesitter.query.get("go", "outerfunc"), "No query")
  for _, capture in query:iter_captures(node, 0) do
    local handler = handlers[capture:type()]
    if handler then
      return handler(capture, info)
    end
  end
  return i(1, "return_value")
end

--- Returns a DynamicNode with nested snippets constructed based on the return
--- value(s) of the function or method where the cursor is located.
local function retvals_snip(args)
  return sn(
    nil,
    retvals_snips_dict {
        index = 0,
        err_name = args[1][1],
        func_name = args[2][1],
    }
  )
end

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
  s(
    "fn",
    fmta(
      [[
      func <fn_name>(<params>) <ret> {
        <code>
      }
      ]],
      {
        fn_name = i(1, "FunctionName"),
        params = i(2),
        ret = i(3),
        code = i(0),
      }
    )
  ),
  s(
    "mfn",
    fmta(
      [[
      func (<recv>) <fn_name>(<params>) <ret> {
        <code>
      }
      ]],
      {
        recv = i(1),
        fn_name = i(2, "FunctionName"),
        params = i(3),
        ret = i(4),
        code = i(0),
      }
    )
  ),
  s(
    "ife",
    fmta(
      [[
      <val>, <err> := <f>(<args>)
      if <err_rep> != nil {
        return <result>
      }
      <fin>
      ]],
      {
        val = i(1),
        err = i(2, "err"),
        f = i(3),
        args = i(4),
        err_rep = rep(2),
        result = d(5, retvals_snip, { 2, 3 }),
        fin = i(0),
      }
    )
  ),
}
