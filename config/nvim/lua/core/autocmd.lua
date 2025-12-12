-- Two space indentation in specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "htmldjango", "typescriptreact", "javascriptreact", "jsx", "lua", "c", "cpp" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		vim.opt_local.autoindent = true -- optional
		vim.opt_local.smartindent = true -- optional
	end,
})

-- Highlight the yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
