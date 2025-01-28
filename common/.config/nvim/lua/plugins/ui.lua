return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = false,
        theme = {
          inactive = {
            a = { color = "Normal" },
            b = { color = "Normal" },
            c = { color = "Normal" },
            x = { color = "Normal" },
            y = { color = "Normal" },
            z = { color = "Normal" },
          },
          normal = {
            a = { color = "Normal" },
            b = { color = "Normal" },
            c = { color = "Normal" },
            x = { color = "Normal" },
            y = { color = "Normal" },
            z = { color = "Normal" },
          },
          visual = {
            a = { color = "Normal" },
            b = { color = "Normal" },
            c = { color = "Normal" },
            x = { color = "Normal" },
            y = { color = "Normal" },
            z = { color = "Normal" },
          },
          replace = {
            a = { color = "Normal" },
            b = { color = "Normal" },
            c = { color = "Normal" },
            x = { color = "Normal" },
            y = { color = "Normal" },
            z = { color = "Normal" },
          },
          insert = {
            a = { color = "Normal" },
            b = { color = "Normal" },
            c = { color = "Normal" },
            x = { color = "Normal" },
            y = { color = "Normal" },
            z = { color = "Normal" },
          },
        },
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = { { 'branch', color = "DiagnosticError" } },
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = {},
        lualine_x = { 'diagnostics' },
        lualine_y = { 'diff' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' }
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterViolet",
          "RainbowDelimiterBlue",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterOrange",
          "RainbowDelimiterCyan",
          "RainbowDelimiterRed",
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true,       -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,     -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false,  -- Toggle with `:Gitsigns toggle_word_diff`
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup({
        nearest_only = true,
      })

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    keys = { { "<leader>z", ":NoNeckPain<cr>", desc = "Move Center" } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
}
