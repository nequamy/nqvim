vim.loader.enable()

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

vim.g._start_time             = vim.fn.reltime()

require("config")
require("plugins")
require("keymap")
require("lsp")
require("autocmd")

require("gruvbox").setup({
	transparent_mode = true,
})
vim.cmd.colorscheme "gruvbox"
