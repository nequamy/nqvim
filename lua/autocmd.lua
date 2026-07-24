-- =============================================================================
-- autocmd.lua — автокоманды
-- =============================================================================
-- Автокоманды — это обработчики событий Neovim.
-- Они срабатывают при определённых действиях: открытие файла, сохранение,
-- переключение буфера, нажатие клавиш и т.д.
-- =============================================================================

-- При открытии Neovim с аргументом-директорией открываем Snacks Explorer в ней.
-- Пример: nvim ~/projects/myapp.
-- Ждём UIEnter: Dashboard успевает создать стартовое окно, затем рядом появляется Explorer.
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			local dir = vim.fn.fnamemodify(arg, ":p")

			-- Убираем имя буфера-директории, чтобы Snacks Dashboard занял стартовое окно.
			vim.api.nvim_buf_set_name(0, "")

			vim.api.nvim_create_autocmd("UIEnter", {
				once = true,
				callback = function()
					require("snacks").explorer({ cwd = dir })
				end,
			})
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
-- Срабатывает при двух событиях:
--   BufLeave   — при переключении на другой буфер
--   FocusLost  — при потере фокуса окном Neovim (переключение приложений)
--
-- Условия для сохранения:
--   vim.bo.modified  — файл имеет несохранённые изменения
--   vim.bo.buftype == "" — обычный файловый буфер (не quickfix, не terminal и т.д.)
--   vim.fn.expand("%") ~= "" — у буфера есть имя файла
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			-- `silent` скрывает обычное сообщение о записи, но не подавляет ошибку как `silent!`.
			vim.cmd("silent write")
		end
	end,
})

local noice_progress = vim.api.nvim_create_augroup("NoiceProgressTransparency", {
	clear = true,
})

-- Noice создаёт прогресс LSP в окнах с группой NoiceMini.
-- После создания делаем фон прозрачным, как у остальных всплывающих окон.
vim.api.nvim_create_autocmd("LspProgress", {
	group = noice_progress,
	callback = function()
		vim.schedule(function()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.wo[win].winhighlight:find("Normal:NoiceMini", 1, true) then
					vim.wo[win].winblend = 100
				end
			end
		end)
	end,
})
