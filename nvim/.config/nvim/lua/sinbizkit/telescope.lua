local M = {}

-- Search vim config files.
M.find_vimconf = function(opts)
	opts = opts or {
		prompt_title = 'NeoVim Config'
	}

	local path = vim.api.nvim_get_runtime_file("init.lua", false)
	if #path ~= 1 then
		error("Config directory not found.")
	end
	path = vim.fn.fnamemodify(path[1], ":p:h")

	opts.cwd = path
	opts.search_dirs = { path }
	opts.file_ignore_patterns = {
		'plugged/',
	}
	require('telescope.builtin').find_files(opts)
end

return M
