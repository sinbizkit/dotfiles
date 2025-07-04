local M = {
  "nvim-telescope/telescope.nvim",
  -- TODO(ivan.berdnikov@kaspersky.com: 29/05/25) change the next release after 0.1.8.
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  priority = 100,
}

M.opts = {
  defaults = {
    prompt_prefix = "  ",
    selection_caret = "➤ ",
    path_display = { "truncate" },
  },
  extensions = {
    fzf = {},
  },
}

function M.config(_, opts)
  local telescope = require "telescope"
  telescope.setup(opts)

  -------------------------------------------------------------------------------
  -- Extensions.
  -------------------------------------------------------------------------------
  telescope.load_extension "fzf"

  -------------------------------------------------------------------------------
  -- Keymaps.
  -------------------------------------------------------------------------------
  local vis_selection = function()
    local _, ls, cs = unpack(vim.fn.getpos "v") -- visual selection start
    local _, le, ce = unpack(vim.fn.getpos ".") -- visual selection end
    return table.concat(vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {}))
  end

  local builtin = require "telescope.builtin"
  local km = require "sinbizkit.keymap"
  -- s - show
  km.map("n", "<Leader>sb", builtin.buffers)
  km.map("n", "<Leader>sr", builtin.registers)
  km.map("n", "<Leader>sj", builtin.jumplist)
  km.map("n", "<Leader>sm", builtin.marks)
  km.map("n", "<Leader>st", builtin.resume)
  -- f- find
  km.map("n", "<Leader>t", builtin.find_files)
  km.map("n", "<Leader>fG", function()
    builtin.live_grep { path_display = { "shorten" } }
  end)
  km.map("v", "<Leader>fG", function()
    builtin.grep_string {
      search = vis_selection(),
      word_match = "-w",
      path_display = { "truncate" },
    }
  end)
  km.map("n", "<Leader>fg", builtin.current_buffer_fuzzy_find)
  km.map("v", "<Leader>fg", function()
    builtin.current_buffer_fuzzy_find { default_text = vis_selection() }
  end)
  km.map("n", "<Leader>fh", builtin.help_tags)
  km.map("n", "<Leader>fm", builtin.man_pages)
  -- h- git
  km.map("n", "<Leader>ht", builtin.git_status)

  km.map("n", "<Leader>v", require("sinbizkit.telescope.vimconf_picker").find_vimconf)
end

return M
