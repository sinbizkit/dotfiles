require 'nvim-tree'.setup {
	view = {
		width = 40,
		number = false,
		signcolumn = "no",
		relativenumber = true,
		mappings = {
			custom_only = false,
			list = {}
		}
	},
	git = {
		enable = true,
		ignore = false,
	},
}
