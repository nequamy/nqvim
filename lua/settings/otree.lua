return {
	git_status_async = true,
	git_status_async_options = {
		batch_size = 1000,
		batch_delay = 10,
		max_lines = 10000,
	},

	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		async_directory_scan = "auto",
		scan_mode = "shallow",
	},

	window = {
		position = "left",
		width = 35,
	},

	default_component_configs = {
		git_status = {
			symbols = {
				added     = "✚",
				modified  = "",
				deleted   = "✖",
				renamed   = "󰁕",
				untracked = "",
				ignored   = "",
				unstaged  = "󰄱",
				staged    = "",
				conflict  = "",
			},
		},
	},
}
