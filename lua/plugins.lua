-- 1 Theme For Neovim
vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" }
})

-- 2 Mason Plugin For LSP-servers
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({})

-- 3 Lualine Neovim
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup()

-- 4 Fuzzy Finder Plugin
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require('fzf-lua.actions')
require("fzf-lua").setup({
	winopts = { backdrop = 85 },
	keymap = {
		builtin = {
			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-p>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-a"] = "toggle-all",
			["ctrl-t"] = "first",
			["ctrl-g"] = "last",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
		}
	},
	actions = {
		files = {
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-n"] = actions.toggle_ignore,
			["ctrl-h"] = actions.toggle_hidden,
			["enter"]  = actions.file_edit_or_qf,
		}
	}
})

-- 5 Nvim CMP Plugin
vim.pack.add({
	{ src = "https://github.com/hrsh7th/nvim-cmp",     name = "nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer",   name = "cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path",     name = "cmp-path" },
})

require('cmp').setup({
	require("lua.settings.cmp")
})
require('cmp').setup.cmdline({ '/', '?' }, {
	mapping = require('cmp').mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
require('cmp').setup.cmdline(':', {
	mapping = require('cmp').mapping.preset.cmdline(),
	sources = {
		{ name = 'path' }
	},
	{
		{ name = 'cmdline' }
	}
})

-- 6 Treesitter Plugin
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",             name = "nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },
})
require("nvim-treesitter").setup({
	require("lua.settings.treesitter")
})

-- 7 Smart Comments Plugin
vim.pack.add({
	{ src = "https://github.com/numToStr/Comment.nvim", name = "Comment.nvim" },
})
require("Comment").setup({
	padding = true,
	sticky = true,
	ignore = nil,
})

-- 8 Working With Enviroment Plugin
vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround", name = "nvim-surround" },
})
require("nvim-surround").setup({
	surrounds = {
		["("] = { add = { "(", ")" } },
		["{"] = { add = { "{", "}" } },
		["["] = { add = { "[", "]" } },
		['"'] = { add = { '"', '"' } },
		["'"] = { add = { "'", "'" } },
		["`"] = { add = { "`", "`" } },
	},
})

-- 9 Auto Pairs Plugin
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs", name = "nvim-autopairs" },
})
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
	check_ts = true,
	fast_wrap = {},
})

-- 10 Which Key Helper Plugin
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})
require("which-key").setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enable = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},

	win = {
		border = "rounded",
	},

	layout = {
		spacing = 6,
		align = "left",
	},

	show_help = true,
})
-- 11 Dev Icons For Better UI
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
})

-- 12 Neo Tree File Explorer
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim",       name = "plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim",        name = "nui.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", name = "neo-tree.nvim" },
})

require("neo-tree").setup({
	require("lua.settings.otree")
})

-- 13 Rustaceanvim Plugin For Better UI-utils them rust-analyzer
vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim", name = "rustaceanvim" },
})
vim.g.rustaceanvim = {
	tools = {
		code_actions = {
			ui_select_fallback = true,
		},
	},
	server = {
		default_settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
					run = { enable = true },
					debug = { enable = true },
					implementations = { enable = true },
					references = {
						adt = { enable = true },
						enumVariant = { enable = true },
						method = { enable = true },
						trait = { enable = true },
					},
				},
				checkOnSave = true,
				check = {
					command = "clippy",
				},
			},
		},
	},
}

-- 14 Dashboard For Start Window in neovim
vim.pack.add({
	{ src = "https://github.com/nvimdev/dashboard-nvim", name = "dashboard-nvim" },
})
local logo = {
	" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ███╗██╗   ██╗",
	" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔══██╗████╗ ████║╚██╗ ██╔╝",
	" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████║██╔████╔██║ ╚████╔╝ ",
	" ██║╚██╗██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══██║██║╚██╔╝██║  ╚██╔╝  ",
	" ██║ ╚████║███████╗╚██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║   ██║   ",
	" ╚═╝  ╚═══╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ",
	"",
	" [ nequamy ]",
	"",
}

local function make_header()
	local content_height = #logo + 5 * 2 + 2
	local pad = math.max(0, math.floor((vim.o.lines - content_height) / 2))
	local header = {}
	for _ = 1, pad do
		table.insert(header, "")
	end
	for _, line in ipairs(logo) do
		table.insert(header, line)
	end
	return header
end

require("dashboard").setup({
	theme = "doom",
	config = {
		header = make_header(),
		vertical_center = true,
		center = {
			{ icon = "  ", icon_hl = "DashboardIcon", desc = "Find File           ", desc_hl = "DashboardDesc", key = "f", key_hl = "DashboardKey", key_format = " [%s]", action = "FzfLua files" },
			{ icon = "  ", icon_hl = "DashboardIcon", desc = "Recent Files        ", desc_hl = "DashboardDesc", key = "r", key_hl = "DashboardKey", key_format = " [%s]", action = "FzfLua oldfiles" },
			{ icon = "  ", icon_hl = "DashboardIcon", desc = "Live Grep           ", desc_hl = "DashboardDesc", key = "g", key_hl = "DashboardKey", key_format = " [%s]", action = "FzfLua live_grep" },
			{ icon = "  ", icon_hl = "DashboardIcon", desc = "Config              ", desc_hl = "DashboardDesc", key = "c", key_hl = "DashboardKey", key_format = " [%s]", action = "edit ~/.config/nvim/init.lua" },
			{ icon = "  ", icon_hl = "DashboardIcon", desc = "Quit                ", desc_hl = "DashboardDesc", key = "q", key_hl = "DashboardKey", key_format = " [%s]", action = "quit" },
		},
		footer = function()
			local ms = vim.fn.reltimefloat(vim.fn.reltime(vim.g._start_time)) * 1000
			return { "", "⚡ Neovim loaded in " .. string.format("%.2f", ms) .. " ms" }
		end,
	},
})

-- 15 Trouble - pretty errors from LSP
vim.pack.add({
	{ src = "https://github.com/folke/trouble.nvim", name = "trouble.nvim" },
})
require("trouble").setup({
	auto_close = true,
	focus = true,
})

-- 16 Gitsigns - git inside line
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns.nvim" },
})
require("gitsigns").setup({
	current_line_blame = true,
	signs = {
		add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
	}
})

-- 17 Crates for cargo
vim.pack.add({
	{ src = "https://github.com/saecki/crates.nvim", name = "crates.nvim" },
})
require("crates").setup()

-- 18 Compiler explorer for looking assembly code
vim.pack.add({
	{ src = "https://github.com/krady21/compiler-explorer.nvim", name = "compiler-explorer" },
})
require("compiler-explorer").setup()

-- 19 Venv selector for python development
vim.pack.add({
	{ src = "https://github.com/linux-cultist/venv-selector.nvim", name = "venv-selector.nvim" }
})
require("venv-selector").setup()

-- 20 Noise For Better UI Expirience
vim.pack.add({
	{ src = "https://github.com/folke/noice.nvim", name = "noise.nvim" },
    { src = "https://github.com/rcarriga/nvim-notify", name = "nvim-notify" },
})
require("notify").setup({
	background_colour = "#000000"
})
require("noice").setup({
	messages = {
		enabled = true,
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
})

-- 21 TODO Comments Highlighting
vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" }
})
require("todo-comments").setup()

