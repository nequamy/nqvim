-- =============================================================================
-- settings/lualine.lua — компактная статусная строка
-- =============================================================================
-- Слева: режим, Git и имя файла. Справа: диагностика и значок типа файла.
return {
	options = {
		theme = "auto",
		-- Без декоративных разделителей: строка остаётся спокойной на прозрачном фоне.
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- Одна строка на весь Neovim, а не отдельная в каждом окне.
		globalstatus = true,
		-- Picker — вспомогательное окно; он не должен делать файл «неактивным».
		ignore_focus = {
			"snacks_picker_list",
			"snacks_picker_input",
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				-- N, I, V и т.д. занимают минимум места, но режим всегда виден.
				fmt = function(mode)
					return mode:sub(1, 1)
				end,
			},
		},
		lualine_b = { "branch", "diff" }, -- текущая ветка и краткая сводка изменений
		lualine_c = {
			{
				"filename",
				-- Показывать путь относительно cwd, чтобы различать одинаковые имена файлов.
				path = 1,
				symbols = { modified = " ", readonly = " ", unnamed = "[No Name]" },
			},
		},
		lualine_x = {
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
			},
			-- Значок формата файла без текста: название уже подсказывает синтаксис в буфере.
			{ "filetype", icon_only = true },
		},
		lualine_y = {},
		lualine_z = {},
	},
}
