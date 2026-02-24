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
--   lsp/              — конфиги отдельных LSP серверов (lua_ls, ruff, ty, buf_ls)
-- =============================================================================

-- Включаем кэш байткода Lua — ускоряет запуск на ~15–20 мс.
-- Neovim компилирует .lua файлы в байткод и сохраняет в ~/.cache/nvim/luac/
-- При повторном запуске загружает готовый байткод вместо парсинга исходников.
vim.loader.enable()

-- Отключаем неиспользуемые провайдеры языков программирования.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Запоминаем время старта для отображения в дашборде (плагин dashboard-nvim).
vim.g._start_time = vim.fn.reltime()

-- Загружаем модули конфигурации по порядку.
-- Порядок важен: config (опции) → plugins (плагины с setup) → keymap (биндинги) → lsp → autocmd
require("config") -- базовые настройки vim.opt
require("plugins") -- плагины через vim.pack.add() + их setup()
require("keymap") -- все горячие клавиши
require("lsp") -- настройки LSP, диагностики, inlay hints
require("autocmd") -- автосохранение, подсветка yanked текста и прочее

-- Настройка цветовой схемы Gruvbox.
-- transparent_mode = true — фон становится прозрачным
require("gruvbox").setup({
	transparent_mode = true,
})
vim.cmd.colorscheme("gruvbox")
