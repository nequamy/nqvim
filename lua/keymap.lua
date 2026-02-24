-- =============================================================================
-- keymap.lua — все горячие клавиши
-- =============================================================================
-- Все биндинги сгруппированы по назначению.
-- Лидер-клавиша: Space (задаётся в config.lua)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Файловый менеджер Neo-tree
-- -----------------------------------------------------------------------------

-- <leader>e — открыть/закрыть боковую панель с файлами
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- -----------------------------------------------------------------------------
-- Fuzzy Finder (fzf-lua) — быстрый поиск файлов и текста
-- -----------------------------------------------------------------------------

local fzf = require("fzf-lua")

-- <leader><leader> — найти файл по имени (как Ctrl+P в VSCode)
vim.keymap.set("n", "<leader><leader>", fzf.files)

-- <leader>/ — поиск текста по всему проекту (live grep)
vim.keymap.set("n", "<leader>/", fzf.live_grep)

-- -----------------------------------------------------------------------------
-- LSP навигация — прыжки по коду
-- -----------------------------------------------------------------------------

-- gd — перейти к определению (где объявлена функция/переменная/тип)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })

-- gr — показать все места использования символа
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })

-- K — показать документацию к символу под курсором (hover)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

-- gi — перейти к реализации интерфейса/абстрактного метода
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })

-- gt — перейти к типу переменной под курсором
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Type definition" })

-- -----------------------------------------------------------------------------
-- LSP действия над кодом
-- -----------------------------------------------------------------------------

-- <leader>ca — code actions: быстрые исправления, рефакторинги предложенные LSP
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- <leader>rn — переименовать символ во всём проекте (rename)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- <leader>cl — запустить code lens (например, кнопки "Run" / "Debug" в Rust)
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run Code Lens" })

-- <leader>fo — форматировать файл через conform.nvim (stylua, ruff, rustfmt)
vim.keymap.set("n", "<leader>fo", function()
	require("conform").format({ async = true })
end, { desc = "Format" })

-- -----------------------------------------------------------------------------
-- Навигация по диагностике (ошибки и предупреждения LSP)
-- -----------------------------------------------------------------------------

-- ]d — прыгнуть к следующей ошибке/предупреждению
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

-- [d — прыгнуть к предыдущей ошибке/предупреждению
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

-- <leader>d — показать детали диагностики под курсором в float-окне
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- <leader>xx — открыть/закрыть Trouble (список всех ошибок проекта)
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })

-- -----------------------------------------------------------------------------
-- Навигация по окнам (сплиты)
-- -----------------------------------------------------------------------------

-- Ctrl+h/j/k/l — переключаться между сплитами без нажатия Ctrl+W
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- -----------------------------------------------------------------------------
-- Навигация по буферам
-- -----------------------------------------------------------------------------

-- ]b / [b — следующий / предыдущий буфер
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

-- <leader>bd — закрыть текущий буфер (без закрытия окна/сплита)
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- -----------------------------------------------------------------------------
-- Разное
-- -----------------------------------------------------------------------------

-- Escape — убрать подсветку поиска (после /pattern нажми Esc чтобы убрать синие highlights)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
