-- Init options for pickers without the preview.
local wopreview_picker_opts = {
  theme = "dropdown",
  width = 0.8,
  prompt_title = "",
  prompt_prefix = "  ",
  previewer = false,
  layout_config = {
    width = 0.8,
  },
}

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = wopreview_picker_opts,
    buffers = wopreview_picker_opts,
  },
}
