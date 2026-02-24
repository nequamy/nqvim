-- =============================================================================
-- lsp/lua_ls.lua — конфигурация Lua Language Server
-- =============================================================================
-- Обеспечивает LSP поддержку для Lua файлов, в первую очередь для конфигов Neovim.
-- Установка: :MasonInstall lua-language-server
-- =============================================================================

return {
	cmd = { 'lua-language-server' }, -- команда запуска сервера

	filetypes = { 'lua' }, -- активировать только для .lua файлов

	-- Маркеры корня проекта: LSP ищет эти файлы вверх по дереву директорий.
	-- Когда файл найден — его директория становится "корнем проекта".
	root_markers = {
		'.luarc.json',   -- конфиг lua-language-server
		'.luarc.jsonc',  -- конфиг lua-language-server (с комментариями)
		'.luacheckrc',   -- конфиг luacheck линтера
		'.stylua.toml',  -- конфиг stylua форматтера
		'stylua.toml',   -- конфиг stylua форматтера (без точки)
		'selene.toml',   -- конфиг selene линтера
		'selene.yml',    -- конфиг selene линтера (YAML)
		'.git',          -- корень git репозитория
	},

	settings = {
		Lua = {
			runtime = {
				-- Версия Lua: Neovim использует LuaJIT (совместим с Lua 5.4).
				version = "Lua 5.4",
			},
			completion = {
				enable = true, -- включить автодополнение Lua-специфичных API
			},
			diagnostics = {
				enable = true,
				-- Сказать lua_ls что "vim" — глобальная переменная (не ошибка "undefined global").
				-- Без этого весь init.lua был бы красным от ошибок "undefined global 'vim'".
				globals = { "vim" },
			},
			workspace = {
				-- Добавить путь к runtime файлам Neovim для автодополнения API.
				-- Это позволяет получать подсказки для vim.api.*, vim.lsp.*, vim.opt.* и т.д.
				library = { vim.env.VIMRUNTIME },
				-- Не предлагать настроить workspace для сторонних библиотек.
				-- Без этого lua_ls показывает надоедливый popup "configure your environment".
				checkThirdParty = false,
			},
		},
	},
}
