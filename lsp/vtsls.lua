-- vtsls — TypeScript/JavaScript-сервер; для Vue он использует TypeScript-плагин Vue.
-- Путь строится от `$HOME` и ожидает, что `vue-language-server` установлен через Mason.
local vue_plugin_path =
	vim.fn.expand("$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server")

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	-- Маркеры вычисляются для каждого буфера и разделяют корни разных фронтенд-проектов.
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		vtsls = {
			tsserver = {
				-- Без этого плагина vtsls не понимает TypeScript-часть `.vue`-файлов.
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_plugin_path,
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
		typescript = {
			format = {
				indentSize = 4,
				tabSize = 4,
				convertTabsToSpaces = true,
			},
		},
		javascript = {
			format = {
				indentSize = 4,
				tabSize = 4,
				convertTabsToSpaces = true,
			},
		},
	},
}
