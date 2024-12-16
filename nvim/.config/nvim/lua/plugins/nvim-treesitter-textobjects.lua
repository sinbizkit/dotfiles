return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  opts = {
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobjs.
        keymaps = {
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["ao"] = "@comment.outer",
          ["io"] = "@comment.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist.
        goto_next_start = {
          ["]f"] = "@function.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
