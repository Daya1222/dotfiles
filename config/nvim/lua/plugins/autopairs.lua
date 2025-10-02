-- ~/.config/nvim/lua/plugins/autopairs.lua
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- treesitter should be installed
		"hrsh7th/nvim-cmp", -- only if you use nvim-cmp (LazyVim does)
	},
	config = function()
		local ok, npairs = pcall(require, "nvim-autopairs")
		if not ok then
			return
		end

		npairs.setup({
			-- core behavior
			disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
			disable_in_macro = true,
			check_ts = true, -- USE TREESITTER to make smarter decisions
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				typescript = { "template_string" },
				javascriptreact = { "template_string" },
				typescriptreact = { "template_string" },
			},

			-- mapping behavior
			map_cr = false, -- we'll handle <CR> explicitly to avoid conflicts
			map_bs = true, -- backspace behavior
			enable_check_bracket_line = true,
			ignored_next_char = "[%w%.]", -- don't pair if next char is alnum or dot

			-- FastWrap for quick wrapping
			fast_wrap = {
				map = "<M-e>", -- Alt-e
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				cursor_pos_before = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},

			-- optional: fine-tune other features as desired
		})

		-- make <CR> cooperate with popup menu / completion
		-- this prevents double parentheses or broken confirms
		-- Adapted from the plugin README (safe, widely used pattern)
		_G.MUtils = _G.MUtils or {}
		_G.MUtils.CR = function()
			if vim.fn.pumvisible() ~= 0 then
				if vim.fn.complete_info({ "selected" }).selected ~= -1 then
					return npairs.esc("<c-y>") -- confirm selection
				else
					return npairs.esc("<c-e>") .. npairs.autopairs_cr()
				end
			else
				return npairs.autopairs_cr()
			end
		end
		vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

		-- safe nvim-cmp integration (only if cmp exists)
		local has_cmp, cmp = pcall(require, "cmp")
		if has_cmp then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- simple wiring: on confirm, autopairs can add pair characters (like '(')
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- advanced: make autopairs insert '(' only for function/method completion kinds
			-- (uncomment if you want this behavior)
			-- local handlers = require("nvim-autopairs.completion.handlers")
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
			--   filetypes = {
			--     ["*"] = {
			--       ["("] = {
			--         kind = {
			--           cmp.lsp.CompletionItemKind.Function,
			--           cmp.lsp.CompletionItemKind.Method,
			--         },
			--         handler = handlers["*"]
			--       }
			--     }
			--   }
			-- }))
		end

		-- Optional: if you want automatic tag rename (rename opening -> closing)
		-- install and enable nvim-ts-autotag (recommended for robust html/jsx behavior)
		-- require('nvim-ts-autotag').setup({})
	end,
}
