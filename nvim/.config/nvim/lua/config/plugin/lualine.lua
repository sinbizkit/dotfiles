require("lualine").setup {
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      "progress",
    },
    lualine_z = { "location" },
  },
}
