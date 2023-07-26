return {
  "nvim-pack/nvim-spectre",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require('spectre').setup()
    vim.keymap.set('n', '<leader>U', '<cmd>lua require("spectre").open()<CR>', {
      desc = "Open Spectre"
    })
    vim.keymap.set('n', '<leader>uw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = "Search current word"
    })
    vim.keymap.set('v', '<leader>uw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
      desc = "Search current word"
    })
    vim.keymap.set('n', '<leader>up', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = "Search on current file"
    })
  end
}
