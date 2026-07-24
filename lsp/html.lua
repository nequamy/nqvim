-- html — языковой сервер HTML из пакета Mason `html-lsp`.
-- Даёт completion тегов и атрибутов, диагностику и форматирование разметки.
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
	init_options = {
		provideFormatter = true,
		-- Подсказки для CSS/JS внутри <style>/<script> прямо в .html.
		embeddedLanguages = { css = true, javascript = true },
	},
}
