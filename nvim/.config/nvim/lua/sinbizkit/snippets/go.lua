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

---Returns a list of type names declared in the current buffer.
---@return TSNode?
---@nodiscard
local function buffer_typenames()
  local node = vim.treesitter.get_node()
  local tree = node and node:tree()
  local root = tree and tree:root()
  if not root then
    return
  end

  local query = assert(vim.treesitter.query.get("go", "typenames"), "No query")
  local result = {}
  for _, capture in query:iter_captures(root, 0) do
    table.insert(result, vim.treesitter.get_node_text(capture, 0))
  end
  return result
end

---Returns a list of Nodes applicable for types declared in the current buffer.
---@nodiscard
local function buffer_typename_nodes()
  local names = buffer_typenames()
  if not names or #names == 0 then
    return { i(nil, "Type") }
  end

  local result = {}
  for _, name in ipairs(names) do
    table.insert(result, i(nil, name))
    table.insert(result, i(nil, "*" .. name))
  end
  return result
end

--- Returns the first parent whose type is one of the callable - method, function
--- or closure.
---@returns TSNode?
---@nodiscard
local function outer_function_node()
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
      return node
    end
    node = node:parent()
  end
end

---Returns true if the current node has `source_file` type.
---@returns boolean
---@nodiscard
local function source_file_scope()
  local node = vim.treesitter.get_node()
  return node and node:type() == "source_file"
end

local default_values = {
  ---Dictionary mapping a built-in Go type to its zero value.
  -- basic Go types.
  bool = "false",

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
    info.index = info.index + 1
    return i(info.index, info.err_name or "nil")
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
---@param text string
---@param info table
---@return any
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
        if info.modifiable then
          info.index = info.index + 1
          return i(info.index, result)
        end
        return t(result)
      else
        -- ...Assume that it is a callable handler otherwise.
        return result and result(text, info)
      end
    end
  end

  return t(text .. "{}")
end

---Returns the current function return-value node where the cursor is located.
---@return TSNode?
---@nodiscard
local function retval_node()
  local node = outer_function_node()
  -- Return an nil if no match.
  if not node then
    return nil
  end

  local query = assert(vim.treesitter.query.get("go", "outerfunc"), "No query")
  for _, capture in query:iter_captures(node, 0, node:start(), node:end_(), { max_start_depth = 1 }) do
    if capture:has_error() then
      return nil
    end
    return capture
  end
end

---Computes the return types of the current function where the cursor is located,
---and returns a table of snippets corresponding to each of them.
---@param info table
---@return table?
local function retvals_snips_dict(info)
  local node = retval_node()
  -- Return an nil if no match.
  if not node then
    return nil
  end

  if node:type() ~= "parameter_list" then
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end

  local result = {}
  local count = node:named_child_count()
  for idx = 0, count - 1 do
    local child = node:named_child(idx)
    ---@diagnostic disable-next-line:need-check-nil
    local type_node = child:field("type")[1]
    table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
    if idx ~= count - 1 then
      table.insert(result, t { ", " })
    end
  end
  return result
end

---Returns a TSNode list for function return values.
local function fn_retvals_snip()
  local snips = retvals_snips_dict {
    index = 0,
    modifable = true,
  }
  if snips then
    table.insert(snips, 1, t "return ")
  else
    snips = t "return"
  end
  return sn(nil, snips)
end

--- Returns a DynamicNode with nested snippets constructed based on the return
--- value(s) of the function or method where the cursor is located.
local function ife_retvals_snip(args)
  local snips = retvals_snips_dict {
    index = 0,
    err_name = args[1] and args[1][1] or "",
    modifable = false,
  }
  snips = snips or i(1, "")
  return sn(nil, snips)
end

local function ts_fn_node()
  -- Closure if the cursor is in a function local scope.
  if outer_function_node() ~= nil then
    return sn(
      1,
      fmta(
        [[
        <name> := func(<params>) <ret> {
          <finish>
        }
        ]],
        {
          name = i(1, "f"),
          params = i(2),
          ret = i(3),
          finish = i(4),
        }
      )
    )
  end

  -- Global function otherwise.
  return sn(
    nil,
    fmta(
      [[
      func <fn_name>(<params>) <ret> {
        <finish>
      }
      ]],
      {
        fn_name = i(1, "FName"),
        params = i(2),
        ret = i(3),
        finish = i(4),
      }
    )
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
  s({
    trig = "fn",
    condition = function()
      return source_file_scope() or outer_function_node() ~= nil
    end,
    show_condition = function()
      return source_file_scope() or outer_function_node() ~= nil
    end,
  }, d(1, ts_fn_node)),
  s(
    {
      trig = "mfn",
      condition = source_file_scope,
      show_condition = source_file_scope,
    },
    fmta(
      [[
      func (<recv_name> <recv_type>) <fn_name>(<params>) <ret> {
      	<code>
      }
      ]],
      {
        recv_type = d(1, function()
          return sn(nil, c(1, buffer_typename_nodes()))
        end),
        recv_name = i(2, "rname"),
        fn_name = i(3, "FunctionName"),
        params = i(4),
        ret = i(5),
        code = i(0),
      }
    )
  ),
  --- Insert dynamic node with function/method/closure return zero-values.
  s({
    trig = "ret",
    condition = function()
      return outer_function_node() ~= nil
    end,
    show_condition = function()
      return outer_function_node() ~= nil
    end,
  }, d(1, fn_retvals_snip)),
  s(
    {
      trig = "ife",
      condition = function()
        return outer_function_node() ~= nil
      end,
      show_condition = function()
        return outer_function_node() ~= nil
      end,
    },
    fmta(
      [[
      if <err> != nil {
      	return <result><fin>
      }
      ]],
      {
        err = i(1, "err"),
        result = d(2, ife_retvals_snip, { 1 }),
        fin = i(0),
      }
    )
  ),
  s(
    {
      trig = "ifi",
      condition = function()
        return outer_function_node() ~= nil
      end,
      show_condition = function()
        return outer_function_node() ~= nil
      end,
    },
    fmta(
      [[
      if <err> := <f>(<args>); <err_rep> != nil {
      	return <result><fin>
      }
      ]],
      {
        err = i(1, "err"),
        f = i(2, "Func"),
        args = i(3),
        err_rep = rep(1),
        result = d(4, ife_retvals_snip, { 1 }),
        fin = i(0),
      }
    )
  ),
}
