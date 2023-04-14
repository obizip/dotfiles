return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    -- "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {},
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      }
    })
    -- telescope.load_extension "file_browser"
    telescope.load_extension("fzf")

    local wk = require("which-key")
    wk.register({
      ["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
      ["<leader>d"] = { "<cmd>Telescope diagnostics<cr>", "Find Diagnostics" },
      ["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Find File" },
      ["<leader>h"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      ["<leader>i"] = { "<cmd>Telescope live_grep<cr>", "Grep File" },
      ["<leader>o"] = { "<cmd>Telescope oldfiles<cr>", "Find Old File" },
      ["<leader>q"] = { "<cmd>Telescope quickfix<cr>", "Find Quickfix" },
      ["<leader>s"] = { "<cmd>Telescope treesitter<cr>", "Find Symbol" },
      ["<leader>c"] = { function() require('telescope.builtin').find_files({ cwd = '~/.config/nvim' }) end,
        "Find Neovim Config File" },
      ["<leader>w"] = { function() require('telescope.builtin').find_files({
          cwd = vim.fn.system("git rev-parse --show-toplevel | tr -d '\\n'") }) end,
        "Find file in git repository" },
      -- ["<leader>e"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Open file browser" },
    })
  end,
}
