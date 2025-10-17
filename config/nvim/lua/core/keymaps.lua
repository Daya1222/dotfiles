vim.g.mapleader = " "
vim.g.maplocalleader = "//"

-- Exit insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Insert mode navigation
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<leader>o", "<cmd>b#<CR>", { desc = "󰮲 Switch to alternate buffer" })

-- Delete without yanking
vim.keymap.set("v", "x", '"_d', { desc = "Delete without yanking" })

--- Mini files
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open()
end, { desc = "󰙅 File Explorer" })
