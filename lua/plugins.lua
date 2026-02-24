-- =============================================================================
-- plugins.lua — все плагины и их конфигурация
-- =============================================================================
-- Используем встроенный менеджер пакетов Neovim 0.12 — vim.pack.
-- vim.pack.add({ { src = "..." } }) — скачивает и подключает плагин.
-- Плагины хранятся в ~/.local/share/nvim/site/pack/
--
-- ВАЖНО: порядок загрузки имеет значение!
-- lspkind должен быть ДО nvim-cmp, т.к. settings/cmp.lua делает require("lspkind")
-- =============================================================================

-- =============================================================================
-- 1. Цветовая схема Gruvbox
-- =============================================================================
-- Тёплая ретро-схема. Настраивается и применяется в init.lua.
vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
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
-- 4. lspkind — иконки типов в меню автодополнения
-- =============================================================================
-- ВНИМАНИЕ: этот блок должен быть ДО nvim-cmp (#5)!
-- lspkind добавляет иконки (функция, метод, класс, поле и т.д.) в меню cmp.
-- settings/cmp.lua делает require("lspkind") — если загрузить после, будет ошибка.
vim.pack.add({
	{ src = "https://github.com/onsails/lspkind.nvim", name = "lspkind.nvim" },
})

-- =============================================================================
-- 5. fzf-lua — нечёткий поиск файлов и текста
-- =============================================================================
-- Быстрый и мощный fuzzy finder. Используется для:
--   <leader><leader> — поиск файлов
--   <leader>/        — live grep по проекту
-- Требует: fzf, rg (ripgrep), bat (для превью)
-- Конфигурация в settings/fzf.lua
vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

require("fzf-lua").setup(require("settings.fzf"))

-- =============================================================================
-- 6. nvim-cmp — движок автодополнения
-- =============================================================================
-- Сам по себе cmp — только движок. Источники подсказок подключаются через плагины:
--   cmp-nvim-lsp — подсказки от LSP серверов (самые умные)
--   cmp-buffer   — слова из открытых буферов
--   cmp-path     — пути файловой системы (после /)
--   cmp-cmdline  — дополнение в командной строке Neovim (:)
-- Конфигурация в settings/cmp.lua
vim.pack.add({
	{ src = "https://github.com/hrsh7th/nvim-cmp", name = "nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer", name = "cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path", name = "cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline", name = "cmp-cmdline" },
})

-- Основное автодополнение (LSP, буфер, пути).
require("cmp").setup(require("settings.cmp"))

-- Дополнение при поиске / и ? (из текущего буфера).
require("cmp").setup.cmdline({ "/", "?" }, {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Дополнение в командной строке : (пути + команды).
require("cmp").setup.cmdline(":", {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = {
		{ name = "path" },
		{ name = "cmdline" },
	},
})

-- =============================================================================
-- 7. Treesitter — синтаксический анализатор на основе AST
-- =============================================================================
-- Строит дерево синтаксиса для точной подсветки и умной навигации по коду.
-- nvim-treesitter-textobjects — добавляет текстовые объекты af/if/ac/ic/aa/ia
-- (см. settings/treesitter.lua для биндингов)
-- Конфигурация в settings/treesitter.lua
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", name = "nvim-treesitter-textobjects" },
})
require("nvim-treesitter").setup(require("settings.treesitter"))

-- =============================================================================
-- 8. nvim-surround — обёртывание текста в скобки/кавычки
-- =============================================================================
-- Позволяет добавлять, менять и удалять "обёртки" вокруг текста.
-- Примеры (слово под курсором: hello):
--   ysiw( — обернуть в скобки: (hello)
--   ysiw" — обернуть в кавычки: "hello"
--   cs"'  — заменить " на ':  'hello'
--   ds"   — удалить кавычки:   hello
--   VS{   — обернуть строку в фигурные скобки
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

-- =============================================================================
-- 9. nvim-autopairs — автоматическое закрытие скобок
-- =============================================================================
-- При вводе ( автоматически добавляет ) и ставит курсор между ними.
-- check_ts = true — использует Treesitter для умного определения контекста
--   (не закрывает скобки в строках и комментариях где не нужно)
-- enable_check_bracket_line = false — не проверять есть ли уже закрывающая скобка
--   на той же строке (может мешать при редактировании)
-- fast_wrap — позволяет нажать <M-e> чтобы перенести закрывающую скобку
vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs", name = "nvim-autopairs" },
})
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
	check_ts = true,
	fast_wrap = {},
})

-- =============================================================================
-- 10. which-key — подсказки горячих клавиш
-- =============================================================================
-- При нажатии <leader> и паузе показывает popup со всеми доступными биндингами.
-- Помогает не забывать сочетания клавиш и объясняет что они делают.
-- timeoutlen в config.lua (400 мс) определяет как быстро появляется popup.
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim", name = "which-key.nvim" },
})
require("which-key").setup({
	plugins = {
		marks = true, -- показывать метки (marks) при нажатии '
		registers = true, -- показывать регистры при нажатии " или @
		spelling = {
			enable = true,
			suggestions = 20, -- количество вариантов исправления орфографии
		},
		presets = {
			-- Встроенные подсказки для стандартных команд Neovim
			operators = true, -- операторы: d, c, y и т.д.
			motions = true, -- движения: w, e, b, f и т.д.
			text_objects = true, -- текстовые объекты: iw, aw, i" и т.д.
			windows = true, -- <C-w> команды
			nav = true, -- навигация: [, ]
			z = true, -- z команды: ze, zz, zt и т.д.
			g = true, -- g команды: gd, gr, gi и т.д.
		},
	},

	win = {
		border = "rounded", -- скруглённые рамки popup
	},

	layout = {
		spacing = 6, -- расстояние между колонками
		align = "left", -- выравнивание текста
	},

	show_help = true, -- показывать строку помощи в нижней части popup
})

-- Описания групп клавиш для which-key.
-- Это добавляет читаемые названия для групп <leader>e, <leader>c и т.д.
require("which-key").add({
	{ "<leader>/", desc = "live grep" },
	{ "<leader><leader>", desc = "find files" },
	{ "<leader>e", group = "explorer" },
	{ "<leader>c", group = "code" },
	{ "<leader>f", group = "lsp" },
})

-- =============================================================================
-- 11. nvim-web-devicons — иконки файлов
-- =============================================================================
-- Иконки для типов файлов в Neo-tree, lualine, fzf-lua и других плагинах.
-- Требует шрифт с иконками: Nerd Fonts (https://www.nerdfonts.com/)
-- Рекомендуется: JetBrainsMono Nerd Font или FiraCode Nerd Font
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
})

-- =============================================================================
-- 12. Neo-tree — файловый менеджер
-- =============================================================================
-- Боковая панель навигации по файлам с git статусом.
-- Открыть: <leader>e
-- Зависимости:
--   plenary.nvim — библиотека утилит (async, файловые операции и т.д.)
--   nui.nvim     — библиотека UI компонентов (popup, split и т.д.)
-- Конфигурация в settings/otree.lua
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim", name = "nui.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", name = "neo-tree.nvim" },
})

require("neo-tree").setup(require("settings.otree"))

-- =============================================================================
-- 13. rustaceanvim — расширенная поддержка Rust
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
vim.g.rustaceanvim = {
	tools = {
		code_actions = {
			ui_select_fallback = true, -- использовать vim.ui.select если нет Telescope/fzf
		},
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
-- 14. dashboard-nvim — стартовый экран
-- =============================================================================
-- Показывается при запуске nvim без файла.
-- Отображает ASCII-логотип, быстрые действия и время загрузки.
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

-- Центрирует логотип по вертикали в зависимости от высоты терминала.
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
			{
				icon = "  ",
				icon_hl = "DashboardIcon",
				desc = "Find File           ",
				desc_hl = "DashboardDesc",
				key = "f",
				key_hl = "DashboardKey",
				key_format = " [%s]",
				action = "FzfLua files",
			},
			{
				icon = "  ",
				icon_hl = "DashboardIcon",
				desc = "Recent Files        ",
				desc_hl = "DashboardDesc",
				key = "r",
				key_hl = "DashboardKey",
				key_format = " [%s]",
				action = "FzfLua oldfiles",
			},
			{
				icon = "  ",
				icon_hl = "DashboardIcon",
				desc = "Live Grep           ",
				desc_hl = "DashboardDesc",
				key = "g",
				key_hl = "DashboardKey",
				key_format = " [%s]",
				action = "FzfLua live_grep",
			},
			{
				icon = "  ",
				icon_hl = "DashboardIcon",
				desc = "Config              ",
				desc_hl = "DashboardDesc",
				key = "c",
				key_hl = "DashboardKey",
				key_format = " [%s]",
				action = "edit ~/.config/nvim/init.lua",
			},
			{
				icon = "  ",
				icon_hl = "DashboardIcon",
				desc = "Quit                ",
				desc_hl = "DashboardDesc",
				key = "q",
				key_hl = "DashboardKey",
				key_format = " [%s]",
				action = "quit",
			},
		},
		-- Время загрузки Neovim в миллисекундах (замеряется от vim.g._start_time из init.lua).
		footer = function()
			local ms = vim.fn.reltimefloat(vim.fn.reltime(vim.g._start_time)) * 1000
			return { "", "⚡ Neovim loaded in " .. string.format("%.2f", ms) .. " ms" }
		end,
	},
})

-- =============================================================================
-- 15. trouble.nvim — красивый список ошибок и предупреждений
-- =============================================================================
-- Открывает структурированный список всех диагностик проекта в отдельном окне.
-- Удобнее чем стандартный quickfix список.
-- Открыть: <leader>xx
-- auto_close = true — закрыть автоматически когда список пуст
-- focus = true     — фокус переходит в окно trouble при открытии
vim.pack.add({
	{ src = "https://github.com/folke/trouble.nvim", name = "trouble.nvim" },
})
require("trouble").setup({
	auto_close = true,
	focus = true,
})

-- =============================================================================
-- 16. gitsigns.nvim — git индикаторы в редакторе
-- =============================================================================
-- Показывает изменения прямо в colums знаков:
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
-- 17. crates.nvim — помощник для Cargo.toml
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
-- 18. compiler-explorer.nvim — просмотр ассемблерного кода
-- =============================================================================
-- Интеграция с godbolt.org — показывает скомпилированный ассемблер для кода.
-- :CECompile         — скомпилировать текущий файл и показать asm
-- :CECompileLive     — живой режим, asm обновляется при изменениях
-- Поддерживает Rust, C, C++ и другие языки.
vim.pack.add({
	{ src = "https://github.com/krady21/compiler-explorer.nvim", name = "compiler-explorer" },
})
require("compiler-explorer").setup()

-- =============================================================================
-- 19. noice.nvim — улучшенный UI для сообщений и командной строки
-- =============================================================================
-- Переделывает три части стандартного UI Neovim:
--   • Командную строку (:) — в popup в центре экрана
--   • Сообщения — в уведомления (notify) в углу
--   • LSP progress — в статусную строку
-- nvim-notify — backend для всплывающих уведомлений
vim.pack.add({
	{ src = "https://github.com/folke/noice.nvim", name = "noise.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify", name = "nvim-notify" },
})
require("notify").setup({
	background_colour = "#000000", -- цвет фона уведомлений (важно для transparent терминалов)
})
require("noice").setup({
	messages = {
		enabled = true, -- включить перехват сообщений
	},
	lsp = {
		-- Переопределяем стандартные функции для красивого рендера markdown в LSP hover.
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true, -- строка поиска / внизу (как в стандартном Neovim)
		command_palette = true, -- командная строка : в красивом popup
		long_message_to_split = false, -- длинные сообщения в split (отключено — мешало :checkhealth)
		lsp_doc_border = true, -- рамка для LSP документации
	},
	routes = {
		-- Длинный вывод shell команд (:!ls) открывать в split вместо notify popup.
		-- Без этого вывод :! команд "глотался" noice и не был виден.
		{ filter = { event = "msg_show", min_height = 2 }, view = "split" },
	},
})

-- =============================================================================
-- 20. todo-comments.nvim — подсветка TODO/FIXME/HACK/NOTE/WARN комментариев
-- =============================================================================
-- Подсвечивает специальные комментарии цветными иконками:
--   TODO:  — задача (синий)
--   FIXME: — нужно починить (красный)
--   HACK:  — временный костыль (оранжевый)
--   NOTE:  — заметка (зелёный)
--   WARN:  — предупреждение (жёлтый)
-- :TodoFzfLua — показать все TODO в проекте через fzf-lua
vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments.nvim" },
})
require("todo-comments").setup()

-- =============================================================================
-- 21. conform.nvim — форматирование кода
-- =============================================================================
-- Запускает форматтеры автоматически при сохранении файла.
-- Форматтеры настраиваются по типу файла:
--   lua    — stylua (установить: cargo install stylua)
--   python — ruff format (установить: pip install ruff или через Mason)
--   rust   — rustfmt (входит в состав rustup)
-- Ручное форматирование: <leader>fo
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		rust = { "rustfmt", lsp_format = "fallback" }, -- rustfmt или LSP если недоступен
	},
	format_on_save = {
		timeout_ms = 500, -- максимальное время форматирования (мс)
		lsp_format = "fallback", -- использовать LSP форматирование если conform форматтер не найден
	},
})

-- =============================================================================
-- 22. indent-blankline.nvim — визуальные направляющие отступов
-- =============================================================================
-- Рисует вертикальные линии │ по уровням отступа — помогает визуально
-- отслеживать вложенность блоков кода.
-- scope.enabled = true — подсвечивает текущий блок кода (функцию, цикл и т.д.)
vim.pack.add({
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim", name = "indent-blankline.nvim" },
})
require("ibl").setup({
	indent = { char = "│" }, -- символ для линии отступа
	scope = { enabled = true }, -- подсвечивать текущий scope
})
