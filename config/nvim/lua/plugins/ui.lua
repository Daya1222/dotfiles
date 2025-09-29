local function enable_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, 
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      enable_transparency()
    end,
  },

    {
	"nvim-lualine/lualine.nvim",
        lazy = false,
        priority = 999,
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = 'tokyonight',
	}
}

}

