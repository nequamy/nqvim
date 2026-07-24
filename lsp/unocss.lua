-- unocss — completion утилит UnoCSS для HTML, Vue, JavaScript и TypeScript.
-- Сервер запускается только в проекте с конфигурацией UnoCSS, поэтому `.git` не является маркером.
return {
	cmd = { "unocss-language-server", "--stdio" },
	filetypes = { "html", "css", "vue", "javascript", "typescript" },
	root_markers = { "uno.config.ts", "uno.config.js", "unocss.config.ts", "unocss.config.js" },
}
