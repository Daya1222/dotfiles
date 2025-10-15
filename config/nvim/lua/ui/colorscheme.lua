return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- make sure it loads before other plugins
		config = function()
			require("catppuccin").setup()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
