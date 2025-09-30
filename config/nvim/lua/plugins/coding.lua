return {
    --Auto pair 
  {
  "nvim-mini/mini.pairs",
  event = "VeryLazy",
  opts = {
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { "string", "comment" },
    skip_unbalanced = true,
    markdown = true,
  },
  keys = {
    {
      "<leader>up",
      function()
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          print("Disabled auto pairs")
        else
          print("Enabled auto pairs")
        end
      end,
      desc = "Toggle auto pairs",
    },
  },
},

    -- Search and Replace
    {
        "MagicDuck/grug-far.nvim",
        lazy = true,
        opts = { headerMaxWidth = 80 },
        cmd = { "GrugFar", "GrugFarWithin" },
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },


    {
        "windwp/nvim-ts-autotag"
    }
}

