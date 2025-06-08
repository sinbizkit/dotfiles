local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
}

M.opts = {
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { { "filename" }, { "diff" } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      { "progress" },
    },
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {
    lualine_a = {
      {
        "tabs",
        max_length = vim.o.columns,
        mode = 2,
      },
    },
  },
}

return M
