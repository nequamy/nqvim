-- =============================================================================
-- settings/treesitter.lua — синтаксические деревья для используемых языков
-- =============================================================================
-- Здесь только парсеры и базовая подсветка: textobjects намеренно даёт mini.ai.
return {
	-- Список покрывает конфиг, Rust, Python и фронтенд-стек.
	ensure_installed = {
		"lua",
		"toml",
		"javascript",
		"typescript",
		"json",
		"yaml",
		"markdown",
		"bash",
		"python",
		"rust",
		"html",
		"css",
		"regex",
		"vue",
		"tsx",
		"scss",
		"jsdoc",
		"jsonc",
		"matlab",
	},

	highlight = {
		enable = true,
		-- Не смешивать старую regex-подсветку с Tree-sitter.
		additional_vim_regex_highlighting = false,
	},
	-- Tree-sitter использует структуру кода для отступов там, где это поддерживается парсером.
	indent = { enable = true },
}
