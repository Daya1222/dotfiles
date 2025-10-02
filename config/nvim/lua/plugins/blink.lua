return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.compat",
			optional = true,
		},
	},
	-- Only load when you actually need it
	event = { "InsertEnter", "CmdlineEnter" },

	opts = {
		-- keymap: only override keys that differ from preset
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-y>"] = { "select_and_accept" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = false, -- this you explicitly want
			nerd_font_variant = "mono", -- override default
		},

		completion = {
			-- keep only non-default / necessary overrides
			accept = {
				auto_brackets = {
					enabled = true, -- if default is false
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				compat = {},
			},
			cmdline = {
				enabled = true,
				keymap = { preset = "cmdline" },
				-- leave default “list / menu / ghost_text” behavior if okay
			},
			-- ghost_text default might already be enabled; only include if you want to toggle
			ghost_text = {
				enabled = true,
			},
		},
	},
}
