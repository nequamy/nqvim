-- =============================================================================
-- settings/snacks.lua — Dashboard, Explorer, Picker и компактные UI-инструменты
-- =============================================================================
-- Состояние старта: `nvim .` показывает только заголовок Dashboard,
-- а обычный `nvim` — заголовок и недавние проекты.
local initial_arg = vim.fn.argv(0)
local opened_directory = initial_arg ~= "" and vim.fn.isdirectory(initial_arg) == 1

-- После выбора проекта меняем cwd, открываем его дерево и обновляем Dashboard.
local function open_project(dir)
	opened_directory = true
	vim.fn.chdir(dir)
	require("snacks").explorer({ cwd = dir })
	require("snacks.dashboard").update()
end

return {
	-- Лёгкие визуальные эффекты и защита редактора от тяжёлых больших файлов.
	animate = { enabled = true },
	bigfile = {
		enabled = true,
		size = 1.5 * 1024 * 1024,
		setup = function(ctx)
			-- Для большого файла отключаем дорогие подсистемы только в его буфере.
			vim.cmd("syntax clear")
			vim.treesitter.stop(ctx.buf)
			vim.wo[0].foldmethod = "manual"
			vim.wo[0].foldexpr = ""

			vim.schedule(function()
				vim.lsp.inlay_hint.enable(false, { bufnr = ctx.buf })
				vim.lsp.document_color.enable(false, { bufnr = ctx.buf })
			end)

			vim.diagnostic.enable(false, { bufnr = ctx.buf })
			vim.b[ctx.buf].snacks_indent = false
		end,
	},
	dashboard = {
		enabled = true,
		preset = {
			header = [[
     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗ █████╗ ███╗   ███╗██╗   ██╗
     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██╔══██╗████╗ ████║╚██╗ ██╔╝
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║███████║██╔████╔██║ ╚████╔╝
   ██║╚██╗██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══██║██║╚██╔╝██║  ╚██╔╝
  ██║ ╚████║███████╗╚██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║   ██║
  ╚═╝  ╚═══╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝
	 [ nequamy ]
			]],
		},
		sections = function()
			-- При `nvim .` Explorer добавляется автокомандой; на Dashboard остаётся только логотип.
			if opened_directory then
				return {
					{ section = "header" },
				}
			end

			-- При простом `nvim` Dashboard — стартовая точка для перехода в недавний проект.
			return {
				{ section = "header" },
				{
					icon = " ",
					title = "Projects",
					section = "projects",
					indent = 2,
					padding = 1,
					limit = 10,
					action = open_project,
				},
			}
		end,
	},
	-- Оставляем только модули, которые реально используются в ежедневной работе.
	dim = { enabled = false },
	explorer = { enabled = true, replace_netrw = false },
	image = { enabled = true },
	input = { enabled = true },
	layout = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scratch = {
		-- Один Markdown TODO на рабочую директорию проекта; Git-ветка не создаёт отдельный список.
		enabled = true,
		name = "TODO",
		ft = "markdown",
		filekey = {
			cwd = true,
			branch = false,
			count = false,
		},
		win_by_ft = {
			markdown = {
				keys = {
					toggle_task = {
						-- В Scratch `<leader>x` переключает Markdown-чекбокс текущей строки.
						"<leader>x",
						function(self)
							local line = vim.api.nvim_get_current_line()

							vim.api.nvim_set_current_line(
								line:match("%[% %]") and line:gsub("%[% %]", "%[x%]", 1)
									or line:gsub("%[x%]", "%[ %]", 1)
							)
						end,
						desc = "Toggle task",
					},
				},
			},
		},
	},
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	toggle = { enabled = false },
	words = { enabled = false },
	zen = { enabled = false },
	lazygit = { enabled = true },

	picker = {
		-- Picker использует небольшое dropdown-окно вместо полноэкранного интерфейса.
		layout = {
			preset = "dropdown",
		},
		sources = {
			files = {
				-- Поиск файлов видит скрытые и игнорируемые файлы; их можно выключить прямо в Picker.
				hidden = true,
				ignored = true,
				win = {
					input = {
						keys = {
							["<S-h>"] = "toggle_hidden",
							["<S-i>"] = "toggle_ignored",
							["<S-f>"] = "toggle_follow",
							["<C-y>"] = { "yazi_copy_relative_path", mode = { "n", "i" } },
						},
					},
				},
				exclude = {
					"**/.git/*",
					"**/node_modules/*",
					"**/.yarn/cache/*",
					"**/.yarn/install*",
					"**/.yarn/releases/*",
					"**/.pnpm-store/*",
					"**/.idea/*",
					"**/.DS_Store",
					"**/.venv/**",
					"build/*",
					"coverage/*",
					"dist/*",
					"hodor-types/*",
					"**/target/*",
					"**/public/*",
					"**/.node-gyp/**",
					"**/claude/debug",
					"**/claude/file-history",
					"**/claude/plans",
					"**/claude/plugins",
					"**/claude/projects",
					"**/claude/session-env",
					"**/claude/shell-snapshots",
					"**/claude/statsig",
					"**/claude/telemetry",
					"**/claude/todos",
					"**/claude/history.jsonl",
					"**/claude/*cache*",
				},
			},
			grep = {
				-- Grep по умолчанию не сканирует скрытые и игнорируемые каталоги.
				hidden = false,
				ignored = false,
				win = {
					input = {
						keys = {
							["<S-h>"] = "toggle_hidden",
							["<S-i>"] = "toggle_ignored",
							["<S-j>"] = "toggle_follow",
						},
					},
				},
				exclude = {
					"**/.git/*",
					"**/node_modules/*",
					"**/.yarn/cache/*",
					"**/.yarn/install*",
					"**/.yarn/releases/*",
					"**/.pnpm-store/*",
					"**/.idea/*",
					"**/.DS_Store",
					"**/.venv/**",
					"build/*",
					"coverage/*",
					"dist/*",
					"hodor-types/*",
					"**/target/*",
					"**/public/*",
					"**/.node-gyp/**",
					"**/claude/debug",
					"**/claude/file-history",
					"**/claude/plans",
					"**/claude/plugins",
					"**/claude/projects",
					"**/claude/session-env",
					"**/claude/shell-snapshots",
					"**/claude/statsig",
					"**/claude/telemetry",
					"**/claude/todos",
					"**/claude/history.jsonl",
					"**/claude/*cache*",
				},
			},
			grep_buffers = {},
			explorer = {
				-- Постоянное дерево: не закрывается после перехода к файлу и следует за текущим буфером.
				hidden = true,
				ignored = true,
				supports_live = true,
				auto_close = false,
				diagnostics = true,
				diagnostics_open = false,
				focus = "list",
				follow_file = true,
				git_status = true,
				git_status_open = false,
				git_untracked = true,
				jump = { close = false },
				tree = true,
				watch = true,
				exclude = {
					"**/.git/*",
					"**/node_modules/*",
					"**/.yarn/cache/*",
					"**/.yarn/install*",
					"**/.yarn/releases/*",
					"**/.pnpm-store/*",
					"**/.idea/*",
					"**/.DS_Store",
					"**/.venv/**",
					"build/*",
					"coverage/*",
					"dist/*",
					"hodor-types/*",
					"**/target/*",
					"**/public/*",
					"**/.node-gyp/**",
					"**/claude/debug",
					"**/claude/file-history",
					"**/claude/plans",
					"**/claude/plugins",
					"**/claude/projects",
					"**/claude/session-env",
					"**/claude/shell-snapshots",
					"**/claude/statsig",
					"**/claude/telemetry",
					"**/claude/todos",
					"**/claude/history.jsonl",
					"**/claude/*cache*",
				},
			},
		},
	},

	styles = {
		-- Терминал — сплит снизу
		terminal = {
			position = "bottom",
			height = 0.35,
			border = "rounded",
			title = "  Terminal ",
			title_pos = "center",
			backdrop = { transparent = true, blend = 40 },
		},

		-- Lazygit — на весь экран
		lazygit = {
			position = "float",
			width = 0,
			height = 0,
			border = "rounded",
			title = "  Lazygit ",
			title_pos = "center",
		},

		-- Уведомления
		notification = {
			border = "rounded",
			zindex = 100,
			wo = {
				winblend = 0,
				wrap = true,
				conceallevel = 2,
			},
		},

		-- История уведомлений
		notification_history = {
			border = "rounded",
			width = 0.6,
			height = 0.6,
			title = "  Notification History ",
			title_pos = "center",
		},

		-- Input (переименование файлов и т.д.)
		input = {
			border = "rounded",
			width = 60,
			height = 1,
			row = 2,
			title_pos = "center",
		},

		-- Scratch буфер
		scratch = {
			width = 100,
			height = 30,
			border = "rounded",
			title = "  Scratch ",
			title_pos = "center",
			zindex = 20,
		},
	},
	-- Линии отступов только для текущей структурной области, без затемнения остального кода.
	indent = {
		enabled = true,
		char = "│",
		blank = " ",
		only_scope = true,
		only_current = false,
	},
}
