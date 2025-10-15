return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  version = false,
  config = function()
    -- Enable the mini modules you want
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.align").setup()
    require("mini.surround").setup()
    require("mini.move").setup()
    require("mini.files").setup()
  end,
}


