vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".git", vim.uv.cwd() },
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim", "Snacks", "snacks" },
			},
		},
	},
})

vim.lsp.enable({ "basedpyright", "ts_ls", "lua_ls", "cssls", "html", "tailwindcss" })

vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			if diagnostic.code == 80001 then
				return "" -- Return empty string instead of nil
			end
			return diagnostic.message
		end,
	},
})
