-- =============================================================================
-- lsp.lua — настройка Language Server Protocol
-- =============================================================================
-- LSP даёт IDE-функции: автодополнение, переходы к определению, диагностика,
-- рефакторинг, документация и многое другое.
--
-- Конфиги отдельных серверов лежат в lsp/ директории:
--   lsp/lua_ls.lua  — Lua (для написания конфигов Neovim)
--   lsp/ruff.lua    — Python (быстрый линтер и форматтер)
--   lsp/ty.lua      — Python (type checker от Astral, альтернатива pyright)
--
-- rust-analyzer подключен через rustaceanvim (plugins.lua) — он лучше
-- интегрируется с cargo.
-- =============================================================================

-- Общие capabilities от Blink для всех серверов из `lsp/`.
-- Они сообщают серверу, какие виды completion-предложений умеет отрисовать клиент.
-- Конфиг `*` глубоко объединяется с каждым сервером, поэтому его локальные поля сохраняются.
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Включаем LSP-серверы. Neovim 0.11+ читает именованные конфиги из `lsp/`.
-- Каждый сервер должен быть установлен в системе (через Mason или вручную).
vim.lsp.enable({
	"lua_ls", -- Lua Language Server (установить: mason → lua-language-server)
	"ty", -- Ty — type checker для Python от Astral
	"ruff", -- Ruff — молниеносный Python линтер/форматтер
	"vtsls", -- TypeScript + Vue через @vue/typescript-plugin
	"vue_ls", -- Vue SFC (template/style), hybrid mode
	"eslint", -- ESLint через LSP
	"unocss", -- UnoCSS автодополнение утилит
	"cssls", -- CSS/SCSS/LESS (Mason: css-lsp)
	"html", -- HTML (Mason: html-lsp)
	"emmet_language_server", -- Emmet-аббревиатуры (Mason: emmet-language-server)
})

-- Настройка отображения диагностики (ошибки, предупреждения, подсказки).
vim.diagnostic.config({
	-- Виртуальный текст справа от строки кода.
	-- prefix "● " — маркер перед текстом ошибки.
	virtual_text = {
		prefix = "● ",
	},

	-- Иконки в колонке знаков (signcolumn) слева от номеров строк.
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ", -- красная иконка ошибки
			[vim.diagnostic.severity.WARN] = " ", -- жёлтая иконка предупреждения
			[vim.diagnostic.severity.INFO] = " ", -- синяя иконка информации
			[vim.diagnostic.severity.HINT] = "󰌵 ", -- иконка подсказки
		},
	},

	-- Подчёркивать проблемные места в коде.
	underline = true,

	-- Не обновлять диагностику в режиме вставки — меньше мерцания при наборе.
	update_in_insert = false,

	-- Сортировать по severity: ошибки выше предупреждений.
	severity_sort = true,

	-- Настройка float-окна для <leader>d (показать детали диагностики).
	float = {
		border = "rounded", -- скруглённая рамка
		source = true, -- показывать источник (например, "ruff" или "lua_ls")
	},
})

-- Code Lens — интерактивные аннотации над кодом, в Rust это Run/Debug у тестов.
vim.lsp.codelens.enable(true)

-- Inlay hints — подсказки типов и имён параметров прямо в коде.
vim.lsp.inlay_hint.enable(true)
