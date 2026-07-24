-- =============================================================================
-- plugins.lua — все плагины и их конфигурация
-- =============================================================================
-- Используем встроенный менеджер пакетов Neovim 0.12 — vim.pack.
-- vim.pack.add({ { src = "..." } }) — скачивает и подключает плагин.
-- Плагины хранятся в ~/.local/share/nvim/site/pack/
--
-- ВАЖНО: порядок загрузки имеет значение!
-- =============================================================================

-- =============================================================================
-- 1. Цветовая схема Kanagawa
-- =============================================================================
-- Цветовая схема. Настраивается и применяется в init.lua.
vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim", name = "kanagawa.nvim" },
})

-- =============================================================================
-- 2. Mason — менеджер LSP серверов, линтеров и форматтеров
-- =============================================================================
-- Mason позволяет устанавливать и обновлять инструменты разработки:
--   :Mason        — открыть UI со списком доступных инструментов
--   :MasonInstall lua-language-server  — установить конкретный инструмент
-- Установленные бинарники доступны в ~/.local/share/nvim/mason/bin/
vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup({})

-- =============================================================================
-- 3. Lualine — статусная строка
-- =============================================================================
-- Заменяет стандартную строку состояния Neovim на красивую и информативную.
-- Конфигурация в settings/lualine.lua
vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup(require("settings.lualine"))

-- =============================================================================
-- 4. Blink.cmp — автодополнение и подсказки сигнатур
-- =============================================================================

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
	{ src = "https://github.com/saghen/blink.lib", name = "blink.lib" },
})
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
	keymap = { preset = "super-tab" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		menu = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
		},
		documentation = {
			window = {
				border = "rounded",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			},
		},
	},
	signature = {
		enabled = true,
		window = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpSignatureHelpCursorLine,Search:None",
		},
	},
})

-- =============================================================================
-- 5. Treesitter — синтаксический анализатор на основе AST
-- =============================================================================
-- Строит дерево синтаксиса для точной подсветки и умной навигации по коду.
-- Конфигурация в settings/treesitter.lua
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
})
require("nvim-treesitter").setup(require("settings.treesitter"))

-- =============================================================================
-- 6. which-key — подсказки горячих клавиш
-- =============================================================================
-- При нажатии <leader> и паузе показывает popup со всеми доступными биндингами.
-- Помогает не забывать сочетания клавиш и объясняет что они делают.
-- timeoutlen в config.lua (400 мс) определяет как быстро появляется popup.
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})
require("which-key").setup(require("settings.which_key"))

-- Описания групп клавиш для which-key.
-- Это добавляет читаемые названия для групп <leader>e, <leader>c и т.д.
require("which-key").add({
	{ "<leader>/", desc = "live grep" },
	{ "<leader><leader>", desc = "find files" },
	{ "<leader>c", group = "code" },
	{ "<leader>g", group = "git" },
})

-- =============================================================================
-- 7. mini.icons — иконки файлов
-- =============================================================================
-- Иконки для типов файлов в Snacks, Lualine и других плагинах.
-- Требует шрифт с иконками: Nerd Fonts (https://www.nerdfonts.com/)
-- Рекомендуется: JetBrainsMono Nerd Font или FiraCode Nerd Font
vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.icons", name = "mini.icons" },
})
require("mini.icons").setup()

-- =============================================================================
-- 8. Общие зависимости UI-плагинов
-- =============================================================================
-- Зависимости:
--   plenary.nvim — библиотека утилит (async, файловые операции и т.д.)
--   nui.nvim     — библиотека UI компонентов (popup, split и т.д.)
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim", name = "nui.nvim" },
})

-- =============================================================================
-- 9. rustaceanvim — расширенная поддержка Rust
-- =============================================================================
-- Лучшая интеграция с rust-analyzer чем стандартный LSP:
--   • Кнопки "▶ Run" / "🐛 Debug" над тестами и main()
--   • Просмотр MIR (Mid-level IR) и HIR
--   • Expand macros — развернуть макрос в реальный код
--   • Open Cargo.toml для текущего крейта
-- Настраивается через vim.g.rustaceanvim (не через setup()).
-- clippy вместо check — более строгие lint правила при сохранении.
vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim", name = "rustaceanvim" },
})

local snack_executor = {
	execute_command = function(command, args, cwd, opts)
		opts = opts or {}

		local terminal = require("snacks.terminal")
		local cmd = vim.list_extend({ command }, args or {})

		local old_terminal = terminal.get(cmd, {
			cwd = cwd,
			env = opts.env,
			create = false,
		})

		if old_terminal then
			old_terminal:close()
		end

		terminal.open(cmd, {
			cwd = cwd,
			env = opts.env,
			interactive = false,
			auto_close = false,
			win = {
				title = " Rust ",
				title_pos = "center",
				width = 0.8,
				height = 0.6,
			},
		})
	end,
}

vim.g.rustaceanvim = {
	tools = {
		code_actions = {
			ui_select_fallback = true, -- использовать vim.ui.select (его отображает Snacks Picker)
		},
		executor = snack_executor,
		test_executor = snack_executor,
		crate_test_executor = snack_executor,
	},
	server = {
		default_settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
					run = { enable = true }, -- кнопка Run
					debug = { enable = true }, -- кнопка Debug
					implementations = { enable = true }, -- список реализаций трейта
					references = {
						adt = { enable = true }, -- ссылки на типы данных
						enumVariant = { enable = true }, -- ссылки на варианты enum
						method = { enable = true }, -- ссылки на методы
						trait = { enable = true }, -- ссылки на трейты
					},
				},
				checkOnSave = true, -- запускать проверку при сохранении
				check = {
					command = "clippy", -- использовать clippy вместо cargo check
				},
			},
		},
	},
}

-- =============================================================================
-- 10. gitsigns.nvim — git индикаторы в редакторе
-- =============================================================================
-- Показывает изменения прямо в колонке знаков:
--   │ — добавленная строка (зелёный)
--   │ — изменённая строка (жёлтый)
--   _ — удалённая строка (красный снизу)
--   ‾ — удалённая строка (красный сверху)
-- Также поддерживает: blame, hunk preview, stage/reset hunk и многое другое.
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns.nvim" },
})
require("gitsigns").setup({
	current_line_blame = false, -- git blame на текущей строке (по умолчанию выкл.)
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- =============================================================================
-- 11. crates.nvim — помощник для Cargo.toml
-- =============================================================================
-- При редактировании Cargo.toml показывает:
--   • Последние версии крейтов прямо в файле (inline hints)
--   • Устаревшие зависимости
--   • Список доступных features
-- Команды: :Crates update — обновить версии
vim.pack.add({
	{ src = "https://github.com/saecki/crates.nvim", name = "crates.nvim" },
})
require("crates").setup()

-- =============================================================================
-- 12. noice.nvim — улучшенный UI для сообщений и командной строки
-- =============================================================================
-- Переделывает три части стандартного UI Neovim:
--   • Командную строку (:) — в компактный popup снизу слева
--   • Сообщения — в уведомления (notify) в углу
--   • LSP progress — в компактное всплывающее окно
vim.pack.add({
	{ src = "https://github.com/folke/noice.nvim", name = "noice.nvim" },
})
require("noice").setup({
	messages = {
		enabled = true, -- включить перехват сообщений
	},
	views = {
		mini = {
			position = {
				row = -2,
			},
		},
		cmdline_popup = {
			position = {
				row = -3,
				col = 2,
			},
			size = {
				min_width = 40,
				width = "auto",
				height = "auto",
			},
		},
	},
	lsp = {
		-- Переопределяем стандартные функции для красивого рендера markdown в LSP hover.
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = false, -- строка поиска / внизу (как в стандартном Neovim)
		command_palette = false, -- командная строка : в красивом popup
		long_message_to_split = false, -- длинные сообщения в split (отключено — мешало :checkhealth)
		lsp_doc_border = true, -- рамка для LSP документации
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				kind = "progress",
			},
			opts = {
				skip = true,
			},
		},
		{
			filter = {
				event = "msg_show",
				kind = { "shell_out", "shell_err" },
			},
			view = "popup",
			opts = {
				title = "Shell output",
			},
		},
	},
})

-- =============================================================================
-- 13. conform.nvim — форматирование кода
-- =============================================================================
-- Запускает форматтеры автоматически при сохранении файла.
-- Форматтеры настраиваются по типу файла:
--   lua    — stylua (установить: cargo install stylua)
--   python — ruff format (установить: pip install ruff или через Mason)
--   rust   — rustfmt (входит в состав rustup)
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" }, -- rustfmt или LSP если недоступен
		vue = { "prettier" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500, -- максимальное время форматирования (мс)
		lsp_format = "fallback", -- использовать LSP форматирование если conform форматтер не найден
	},
})

-- =============================================================================
-- 14. nvim-ts-autotag.nvim — автозакрытие и переименование HTML/Vue/JSX-тегов
-- =============================================================================
-- Работает с HTML, Vue и JSX/TSX; автоматически закрывает тег и обновляет пару при переименовании.

vim.pack.add({
	{ src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
})
require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = true,
	},
})

-- =============================================================================
-- 15. snacks.nvim — набор интегрированных инструментов для Neovim
-- =============================================================================

vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim", name = "snacks" },
})
require("snacks").setup(require("settings.snacks"))

-- =============================================================================
-- 16. mini.nvim — небольшие модули для редактирования
-- =============================================================================
vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pairs", name = "mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround", name = "mini.surround" },
	{ src = "https://github.com/echasnovski/mini.ai", name = "mini.ai" },
})
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()
