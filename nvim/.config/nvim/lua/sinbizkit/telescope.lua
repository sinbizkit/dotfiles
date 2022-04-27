local M = {}

-- Search vim config files.
M.find_vimconf = function(opts)
	opts = opts or {
		prompt_title = 'NeoVim Config'
	}
	opts.cwd = '~/.config/nvim'
	opts.search_dirs = { '~/.config/nvim' }
	opts.file_ignore_patterns = {
		'plugged/',
	}
	require('telescope.builtin').find_files(opts)
end

return M
