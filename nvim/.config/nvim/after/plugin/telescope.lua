local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  return
end

-------------------------------------------------------------------------------
-- Keymaps.
-------------------------------------------------------------------------------
local builtin = require "telescope.builtin"
local km = require "sinbizkit.keymap"
-- s - show
km.map("n", "<Leader>sb", builtin.buffers)
km.map("n", "<Leader>sr", builtin.registers)
km.map("n", "<Leader>sj", builtin.jumplist)
km.map("n", "<Leader>sd", function()
  builtin.diagnostics { bufnr = 0 }
end)
km.map("n", "<Leader>st", builtin.resume)
-- f- find
km.map("n", "<Leader>t", builtin.find_files)
km.map("n", "<Leader>fg", function()
  builtin.live_grep { path_display = { "shorten" } }
end)
km.map("v", "<Leader>fg", function()
  local _, ls, cs = unpack(vim.fn.getpos "v") -- visual selection start
  local _, le, ce = unpack(vim.fn.getpos ".") -- visual selection end
  local st = table.concat(vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {}))
  builtin.grep_string { search = st, word_match = "-w", path_display = { "shorten" } }
end)
km.map("n", "<Leader>fb", builtin.current_buffer_fuzzy_find)
km.map("n", "<Leader>fk", builtin.keymaps)
km.map("n", "<Leader>fh", builtin.help_tags)

km.map("n", "<Leader>v", require("sinbizkit.telescope").find_vimconf)
-------------------------------------------------------------------------------
-- Pickers layout setup.
-------------------------------------------------------------------------------
local default_picker_opts = {
  theme = "dropdown",
  previewer = false,
  layout_config = {
    width = 0.87,
    height = 0.8,
  },
  path_display = { truncate = 2 },
}

local preview_picker_opts = {
  layout_strategy = "vertical",
  layout_config = {
    width = 0.87,
    height = 0.8,
    prompt_position = "bottom",
    preview_cutoff = 30,
  },
  path_display = { "smart", "truncate" },
  fname_width = 50,
  trim_text = true,
}

-------------------------------------------------------------------------------
-- Setup.
-------------------------------------------------------------------------------
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
    prompt_prefix = "  ",
    selection_caret = "➤ ",
    path_display = { "truncate" },
  },
  pickers = {
    find_files = default_picker_opts,
    buffers = default_picker_opts,
    diagnostics = preview_picker_opts,
    live_grep = preview_picker_opts,
    grep_string = preview_picker_opts,
    current_buffer_fuzzy_find = preview_picker_opts,
    jumplist = preview_picker_opts,
    help_tags = preview_picker_opts,
    lsp_references = preview_picker_opts,
    lsp_document_symbols = preview_picker_opts,
    lsp_dynamic_workspace_symbols = preview_picker_opts,
    lsp_definitions = preview_picker_opts,
    lsp_implementations = preview_picker_opts,
  },
}
