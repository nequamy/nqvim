vim.g._start_time = vim.fn.reltime()

require("config")
require("plugins")
require("keymap")
require("lsp")
require("autocmd")

require("gruvbox").setup({
	transparent_mode = true,
})
vim.cmd.colorscheme "gruvbox"
