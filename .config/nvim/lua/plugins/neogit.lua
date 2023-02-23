return {
  "TimUntersberger/neogit",

  keys = { { "<leader>g", "<cmd>Neogit<cr>", desc = "Open neogit" } },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/which-key.nvim",
    'sindrets/diffview.nvim',
  },

  config = function()
    local neogit = require("neogit")
    require 'diffview'.setup({
      file_panel = {
        listing_style = "list", -- One of 'list' or 'tree'
        win_config = { -- See ':h diffview-config-win_config'
          position = "bottom",
          height = 10,
          win_opts = {}
        },
      },
    })

    neogit.setup({
      integrations = {
        diffview = true,
      }
    })
  end,
}
