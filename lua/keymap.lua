vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader><leader>", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })


vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts)

vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run Code Lens" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
