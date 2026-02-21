vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd.cd(arg)
		end
	end,
})


-- highlight yank selected text
local ag = vim.api.nvim_create_augroup

local highlight_group = ag('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

-- Autosave
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertLeave' }, {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
			vim.lsp.buf.format({ async = false })
		end
	end,
})

