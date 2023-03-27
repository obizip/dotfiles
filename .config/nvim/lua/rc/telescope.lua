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
        -- file_browser = {
        --   theme = "ivy",
        --   -- disables netrw and use telescope-file-browser in its place
        --   hijack_netrw = true,
        --   mappings = {
        --     ["i"] = {
        --       -- ["<C-h>"] = fb_actions.goto_home_dir
        --       -- your custom insert mode mappings
        --     },
        --     ["n"] = {
        --       -- your custom normal mode mappings
        --     },
        --   },
        -- }
      }
    })
    -- telescope.load_extension "file_browser"
    telescope.load_extension("fzf")

    local wk = require("which-key")
    wk.register({
      ["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Open buffer picker" },
      ["<leader>d"] = { "<cmd>Telescope diagnostics<cr>", "Open diagnostic picker" },
      ["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Open file picker" },
      ["<leader>h"] = { "<cmd>Telescope help_tags<cr>", "Open help picker" },
      ["<leader>i"] = { "<cmd>Telescope live_grep<cr>", "Open live grep" },
      ["<leader>o"] = { "<cmd>Telescope oldfiles<cr>", "Open file picker at oldfiles" },
      ["<leader>q"] = { "<cmd>Telescope quickfix<cr>", "Open quickfix picker" },
      ["<leader>s"] = { "<cmd>Telescope treesitter<cr>", "Open symbol picker" },
      -- ["<leader>e"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Open file browser" },
    })
  end,
}
