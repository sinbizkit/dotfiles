local has_lualine, lualine = pcall(require, "lualine")
if not has_lualine then
  return
end

lualine.setup {
  options = {
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
