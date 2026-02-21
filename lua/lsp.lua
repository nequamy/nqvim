vim.lsp.enable({
	--"rust-analyzer",
	"lua_ls",
	"buf_ls",
	"ty",
	"ruff",
})

vim.diagnostic.config({ virtual_text = true })
vim.lsp.codelens.enable(true)
