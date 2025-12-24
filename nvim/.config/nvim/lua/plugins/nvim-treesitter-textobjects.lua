local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  branch = "main",
}

M.opts = {
  textobjects = {
    select = {
      lookahead = true, -- Automatically jump forward to textobjs.
    },
    move = {
      set_jumps = true, -- whether to set jumps in the jumplist.
    },
  },
}

function M.config(_, opts)
  require("nvim-treesitter-textobjects").setup(opts)

  local km = require "sinbizkit.keymap"

  -- Select.
  local sel = require("nvim-treesitter-textobjects.select")
  km.map({ "x", "o" }, "ac", function()
    sel.select_textobject("@class.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "ic", function()
    sel.select_textobject("@class.inner", "textobjects")
  end)
  km.map({ "x", "o" }, "af", function()
    sel.select_textobject("@function.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "if", function()
    sel.select_textobject("@function.inner", "textobjects")
  end)
  km.map({ "x", "o" }, "al", function()
    sel.select_textobject("@loop.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "il", function()
    sel.select_textobject("@loop.inner", "textobjects")
  end)
  km.map({ "x", "o" }, "ai", function()
    sel.select_textobject("@conditional.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "ii", function()
    sel.select_textobject("@conditional.inner", "textobjects")
  end)
  km.map({ "x", "o" }, "ao", function()
    sel.select_textobject("@comment.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "io", function()
    sel.select_textobject("@comment.inner", "textobjects")
  end)
  km.map({ "x", "o" }, "ab", function()
    sel.select_textobject("@block.outer", "textobjects")
  end)
  km.map({ "x", "o" }, "ib", function()
    sel.select_textobject("@block.inner", "textobjects")
  end)

  -- Move/jump
  local mov = require "nvim-treesitter-textobjects.move"
  km.map({ "n", "x", "o" }, "]f", function()
    mov.goto_next_start("@function.outer", "textobjects")
  end)
  km.map({ "n", "x", "o" }, "]F", function()
    mov.goto_next_end("@function.outer", "textobjects")
  end)
  km.map({ "n", "x", "o" }, "[f", function()
    mov.goto_previous_start("@function.outer", "textobjects")
  end)
  km.map({ "n", "x", "o" }, "[F", function()
    mov.goto_previous_end("@function.outer", "textobjects")
  end)
end

return M
