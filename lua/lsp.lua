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
--   lsp/buf_ls.lua  — Protobuf (для .proto файлов)
--
-- rust-analyzer подключен через rustaceanvim (plugins.lua) — он лучше
-- интегрируется с cargo.
-- =============================================================================

-- Включаем LSP серверы. Neovim 0.11+ умеет сам читать файлы из lsp/ директории.
-- Каждый сервер должен быть установлен в системе (через Mason или вручную).
vim.lsp.enable({
	"lua_ls", -- Lua Language Server (установить: mason → lua-language-server)
	"buf_ls", -- Buf LSP для Protobuf (установить: buf lsp serve)
	"ty", -- Ty — type checker для Python от Astral
	"ruff", -- Ruff — молниеносный Python линтер/форматтер
})

-- Настройка отображения диагностики (ошибки, предупреждения, подсказки).
vim.diagnostic.config({
	-- Виртуальный текст справа от строки кода.
	-- prefix "●" — маркер перед текстом ошибки.
	virtual_text = {
		prefix = "●",
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

-- Включить code lens глобально.
-- Code lens — кнопки/аннотации над функциями
vim.lsp.codelens.enable(true)

-- Включить inlay hints — подсказки типов прямо в коде.
vim.lsp.inlay_hint.enable(true)
