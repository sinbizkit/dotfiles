local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  return
end

-- Init options for pickers the preview.
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
    preview_cutoff = 40,
  },
  path_display = { "smart", "truncate" },
  fname_width = 50,
  trim_text = true,
}

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
    help_tags = preview_picker_opts,
    lsp_references = preview_picker_opts,
    lsp_document_symbols = preview_picker_opts,
    lsp_dynamic_workspace_symbols = preview_picker_opts,
    lsp_definitions = preview_picker_opts,
    lsp_implementations = preview_picker_opts,
  },
}
