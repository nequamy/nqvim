return {
	ensure_installed = {
		"lua",
		"toml",
		"javascript",
		"typescript",
		"json",
		"yaml",
		"markdown",
		"bash",
		"python",
		"rust",
		"html",
		"css",
		"regex",
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
			include_surrounding_whitespace = false,
		},

		move = {
			enable = true,
			set_jumps = true,
		},

		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
}
