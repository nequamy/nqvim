-- =============================================================================
-- autocmd.lua — автокоманды
-- =============================================================================
-- Автокоманды — это обработчики событий Neovim.
-- Они срабатывают при определённых действиях: открытие файла, сохранение,
-- переключение буфера, нажатие клавиш и т.д.
-- =============================================================================

-- При открытии Neovim с аргументом-директорией — перейти в неё.
-- Пример: nvim ~/projects/myapp → автоматически cd в ~/projects/myapp
-- Это нужно для корректной работы LSP (он ищет корень проекта от текущей директории)
-- и для fzf-lua (поиск файлов будет в нужной директории).
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd.cd(arg)
		end
	end,
})

-- Подсветка yanked (скопированного) текста.
-- При y/Y текст мигает, визуально подтверждая что скопировано.
-- timeout = 170 мс — время подсветки.
local ag = vim.api.nvim_create_augroup

local highlight_group = ag("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

-- Автосохранение файлов.
-- Срабатывает при трёх событиях:
--   BufLeave   — при переключении на другой буфер
--   FocusLost  — при потере фокуса окном Neovim (переключение приложений)
--   InsertLeave — при выходе из режима вставки
--
-- Условия для сохранения:
--   vim.bo.modified  — файл имеет несохранённые изменения
--   vim.bo.buftype == "" — обычный файловый буфер (не quickfix, не terminal и т.д.)
--   vim.fn.expand("%") ~= "" — у буфера есть имя файла
--
-- "silent! write" — сохранить без сообщений и без ошибок если файл readonly.
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})
