return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		build = "make tiktoken",
		opts = {
			model = "claude-opus-4.5",
			temperature = 0.1,
			window = {
				layout = "vertical",
				width = 0.3,
			},
			headers = {
				user = " Daya",
				assistant = " Copilot",
				tool = " Tool",
			},
			auto_insert_mode = true,
			show_help = false,
		},
	},
}
