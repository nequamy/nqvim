-- vue_ls — сервер Vue SFC: шаблоны, стили и Vue-специфичная часть `.vue`-файлов.
-- TypeScript внутри SFC обрабатывает vtsls через плагин из `lsp/vtsls.lua`.
return {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	-- Те же маркеры, что у vtsls: оба сервера получают один корень проекта.
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = {
		vue = {
			-- Vue и vtsls работают совместно, а не пытаются дублировать TypeScript-анализ.
			hybridMode = true,
		},
	},
	settings = {
		html = {
			format = {
				indentInnerHtml = true,
				wrapLineLength = 120,
			},
		},
	},
}
