-- =============================================================================
-- keymap.lua — все горячие клавиши
-- =============================================================================
-- Все биндинги сгруппированы по назначению.
-- Лидер-клавиша: Space (задаётся в config.lua)
-- =============================================================================
local Snacks = require("snacks")

-- Навигация по проекту и рабочие окна Snacks.
vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Explorer" })

-- <leader><leader> — найти файл по имени (как Ctrl+P в VSCode)
vim.keymap.set("n", "<leader><leader>", function()
	Snacks.picker.files()
end, { desc = "Find files" })

-- <leader>/ — поиск текста по всему проекту (live grep)
vim.keymap.set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })

vim.keymap.set({ "n", "t" }, "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle terminal" })

vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Scratch" })

vim.keymap.set("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification history" })

-- LSP-списки показываем через Snacks Picker, а не во встроенном quickfix-окне.
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References" })

vim.keymap.set("n", "<leader>ci", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Implementations" })

-- -----------------------------------------------------------------------------
-- LSP навигация — прыжки по коду
-- -----------------------------------------------------------------------------

-- gd — перейти к определению (где объявлена функция/переменная/тип)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })

-- K — показать документацию к символу под курсором (hover)
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

-- -----------------------------------------------------------------------------
-- LSP действия над кодом
-- -----------------------------------------------------------------------------

-- <leader>ca — code actions: исправления и рефакторинги, предложенные LSP
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- <leader>cr — переименовать символ во всём проекте (rename)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

-- <leader>cl — запустить code lens (например, кнопки "Run" / "Debug" в Rust)
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run Code Lens" })

-- <leader>d — показать детали диагностики под курсором в float-окне
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- -----------------------------------------------------------------------------
-- Разное
-- -----------------------------------------------------------------------------

-- Escape — убрать подсветку результатов последнего поиска `/`.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
