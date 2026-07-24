-- emmet_language_server — раскрытие Emmet-аббревиатур (Mason: `emmet-language-server`).
-- Например, `div.card>ul>li*3` превращается в готовую разметку через completion.
-- В обычных JavaScript/TypeScript он намеренно выключен: там предложения Emmet чаще мешают.
return {
	cmd = { "emmet-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"less",
		"vue",
		"javascriptreact",
		"typescriptreact",
	},
}
