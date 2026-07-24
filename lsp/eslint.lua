-- eslint — диагностика и быстрые исправления JavaScript, TypeScript и Vue.
-- Flat config включён намеренно: проекты со старым `.eslintrc` этот сервер не подхватит.
return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	-- Отдельный корень для каждого JS/TS-проекта в одной сессии Neovim.
	root_markers = { "eslint.config.ts", "eslint.config.js", "package.json" },
	settings = {
		validate = "on",
		run = "ontype",
		useFlatConfig = true,
		experimental = {
			useFlatConfig = true,
		},
		workingDirectory = {
			directory = { mode = "location" },
		},
	},
	-- Обработчики служебных запросов ESLint, чтобы они показывались в UI Neovim предсказуемо.
	handlers = {
		["eslint/confirmESLintExecution"] = function()
			return 4
		end,
		["eslint/openDoc"] = function(_, result)
			if result then
				vim.ui.open(result.url)
			end
			return {}
		end,
		["eslint/probeFailed"] = function()
			vim.notify("ESLint probe failed", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("ESLint library not found", vim.log.levels.WARN)
			return {}
		end,
		["textDocument/diagnostic"] = function()
			return {}
		end,
	},
}
