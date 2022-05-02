local ls = require("luasnip")
ls.config.set_config({
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_base_prio = 300,
	ext_prio_increase = 1,
})

ls.cleanup()
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/sinbizkit/snippets/*.lua", true)) do
	local ft = vim.fn.fnamemodify(ft_path, ":t:r")
	ls.add_snippets(ft, loadfile(ft_path)())
end
