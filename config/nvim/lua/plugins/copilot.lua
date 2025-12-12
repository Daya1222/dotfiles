return {
	"github/copilot.vim",
	cmd = "Copilot",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		vim.g.copilot_no_tab_map = true

		vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
		vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-word)")
		vim.keymap.set("n", "<leader>cb", function()
			if vim.g.copilot_enabled == 1 then
				vim.cmd("Copilot disable")
			else
				vim.cmd("Copilot enable")
			end
		end, { desc = "Toggle Copilot" })

		vim.g.copilot_enabled = 0
	end,
}
