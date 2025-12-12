return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "biome" },
			typescript = { "biome" },
			javascriptreact = { "biome" },
			typescriptreact = { "biome" },
			json = { "biome" },
			html = { "biome" },
			css = { "biome" },
			rust = { "rustfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
		format_on_save = {
			timeout_ms = 2000,
			lsp_fallback = true,
		},
	},
}
