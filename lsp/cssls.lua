-- cssls — языковой сервер CSS/SCSS/LESS из пакета Mason `css-lsp`.
-- Даёт подсказки свойств, значений и диагностику в обычных стилевых файлах.
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	init_options = { provideFormatter = true },
	settings = {
		-- Без этого cssls подчёркивает @tailwind/@apply/@unocss как
		-- "unknown at-rule". "ignore" гасит ложную диагностику.
		css = { lint = { unknownAtRules = "ignore" } },
		scss = { lint = { unknownAtRules = "ignore" } },
		less = { lint = { unknownAtRules = "ignore" } },
	},
}
