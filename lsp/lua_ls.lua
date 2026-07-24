-- =============================================================================
-- lsp/lua_ls.lua — конфигурация Lua Language Server
-- =============================================================================
-- Даёт LSP-поддержку Lua, в первую очередь для конфигов Neovim.
-- Установка: :MasonInstall lua-language-server
-- =============================================================================

return {
	cmd = { "lua-language-server" }, -- команда запуска сервера

	filetypes = { "lua" }, -- активировать только для .lua файлов

	-- Маркеры корня проекта: LSP ищет эти файлы вверх по дереву директорий.
	-- Когда файл найден — его директория становится "корнем проекта".
	root_markers = {
		".luarc.json", -- конфиг lua-language-server
		".luarc.jsonc", -- конфиг lua-language-server (с комментариями)
		".luacheckrc", -- конфиг luacheck линтера
		".stylua.toml", -- конфиг stylua форматтера
		"stylua.toml", -- конфиг stylua форматтера (без точки)
		"selene.toml", -- конфиг selene линтера
		"selene.yml", -- конфиг selene линтера (YAML)
		".git", -- корень git репозитория
	},

	settings = {
		Lua = {
			runtime = {
				-- Версия Lua, по правилам которой lua_ls анализирует текущий код.
				version = "Lua 5.4",
			},
			completion = {
				enable = true, -- включить автодополнение Lua-специфичных API
			},
			diagnostics = {
				enable = true,
				-- `vim` предоставляет Neovim, поэтому для lua_ls это допустимая глобальная переменная.
				globals = { "vim" },
			},
			workspace = {
				-- Runtime Neovim нужен для completion и документации `vim.api`, `vim.lsp`, `vim.opt`.
				library = { vim.env.VIMRUNTIME },
				-- Не предлагать отдельную настройку workspace для сторонних библиотек.
				checkThirdParty = false,
			},
		},
	},
}
