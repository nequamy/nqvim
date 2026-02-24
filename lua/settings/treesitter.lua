return {
	ensure_installed = { "lua", "python", "rust", "html", "css" },

	highlight = {
		enable = true,
		additional_im_regex_highlighting = false,
	},
	indent = { enable = true },
	autotage = { enable = true },

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			kemaps = {
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
			spaw_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
}
