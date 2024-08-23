local M = {}

-- Search vim config files.
function M.find_vimconf(opts)
  opts = opts or {
    prompt_title = "NeoVim Config",
  }

  local dirs = vim.api.nvim_get_runtime_file("init.lua", false)
  if #dirs ~= 1 then
    error "Config directory not found."
  end
  local path = vim.fn.fnamemodify(dirs[1], ":p:h")

  opts.cwd = path
  opts.search_dirs = { path }
  opts.file_ignore_patterns = {
    "plugged/",
  }
  require("telescope.builtin").find_files(opts)
end

return M
