local M = {}

-- Search vim config files.
M.find_vimconf = function(opts)
	local opts = opts or {
		prompt_title = 'NeoVim Config'
	}
	opts.cwd = '~/.config/nvim'
	opts.search_dirs = { '~/.config/nvim' }
	require('telescope.builtin').find_files(opts)
end

return M
