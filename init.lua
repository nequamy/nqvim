-- =============================================================================
-- init.lua — точка входа конфигурации Neovim
-- =============================================================================
-- Порядок загрузки важен: сначала оптимизации, потом плагины, потом тема.
-- Структура конфига:
--   init.lua          — этот файл, точка входа
--   lua/config.lua    — базовые настройки редактора (опции vim)
--   lua/plugins.lua   — все плагины и их конфигурация
--   lua/keymap.lua    — горячие клавиши
--   lua/lsp.lua       — настройка Language Server Protocol
--   lua/autocmd.lua   — автокоманды (автосохранение, подсветка yanked текста и т.д.)
--   lua/settings/     — отдельные файлы настроек для сложных плагинов
--   lsp/              — конфиги отдельных LSP серверов (lua_ls, ruff, ty и др.)
-- =============================================================================

-- Кэширует скомпилированный Lua-байткод и ускоряет повторный старт Neovim.
vim.loader.enable()

-- Отключаем встроенный FileExplorer/Netrw: директории открывает только Snacks Explorer.
-- Без этого `nvim .` может создать лишнее окно Netrw до запуска Dashboard.
pcall(vim.api.nvim_del_augroup_by_name, "FileExplorer")

-- Отключаем неиспользуемые провайдеры языков программирования.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Загружаем модули конфигурации по порядку.
-- Порядок важен: config (опции) → plugins (плагины с setup) → keymap (биндинги) → lsp → autocmd
require("config") -- базовые настройки vim.opt
require("plugins") -- плагины через vim.pack.add() + их setup()
require("keymap") -- все горячие клавиши
require("lsp") -- настройки LSP, диагностики, inlay hints
require("autocmd") -- автосохранение, подсветка yanked текста и прочее

-- Настройка цветовой схемы Kanagawa.
-- transparent = true — фон становится прозрачным.
require("kanagawa").setup({
	transparent = true,
	theme = "wave",
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
			wave = {
				ui = {
					float = {
						bg = "none",
						bg_border = "none",
					},
				},
			},
		},
	},
})
vim.cmd.colorscheme("kanagawa-wave")
