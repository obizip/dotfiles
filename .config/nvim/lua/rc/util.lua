return {
  "nvim-lua/plenary.nvim",
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local presets = require("which-key.plugins.presets")
      presets.operators["v"] = nil
      presets.operators["d"] = nil
      presets.operators["c"] = nil
      require("which-key").setup({
        triggers = { "<leader>" },
      })
    end,
  },
  {
    "lewis6991/impatient.nvim",
    lazy = false,
    config = function()
      require("impatient")
    end,
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },

  {
    "notjedi/nvim-rooter.lua",
    lazy = false,
    config = function()
      require("nvim-rooter").setup({
        rooter_patterns = { ".git", ".hg", ".svn" },
        trigger_patterns = { "*.rs", "*.lua", "*.vim", "*.java", "*.go" },
        manual = false,
      })
    end,
  },

  {
    "tpope/vim-repeat",
    event = "InsertEnter",
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "junegunn/vim-easy-align",
    event = "BufReadPre",
    config = function()
      vim.keymap.set("x", "<leader>a", "<Plug>(EasyAlign)", { noremap = true })
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        map_c_h = true,
      })
      require("nvim-autopairs").remove_rule("'")
      require("nvim-autopairs").remove_rule('"')
    end,
  },

  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    'cappyzawa/trim.nvim',
    event = 'BufWritePre',
    config = function()
      require('trim').setup({
        -- disable = { "markdown" },
        -- if you want to remove multiple blank lines
        patterns = {
          [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
        },
      })
    end
  }
}
