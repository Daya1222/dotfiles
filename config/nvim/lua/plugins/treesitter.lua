return {

    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPre", "BufNewFile"},
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "lua",
                "javascript",
                "python"
            },
            auto_install = false,
        })
    end

}
