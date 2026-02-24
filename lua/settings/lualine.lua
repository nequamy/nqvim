return {
	options = {
		theme = "gruvbox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{ "filename", path = 1 },
		},
		lualine_x = {
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
			},
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
}
