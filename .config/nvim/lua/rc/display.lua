return {
  {
    "petertriho/nvim-scrollbar",
    -- event = "VeryLazy",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
    },
    config = function()
      require("scrollbar.handlers.search").setup()
      require("scrollbar").setup({
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = false, -- Requires gitsigns
          handle = true,
          search = true,    -- Requires hlslens
          ale = false,      -- Requires ALE
        },
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require('gitsigns').setup {
        signs                        = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn                   = false, -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm                         = {
          enable = false
        },
      }
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    -- event = "VeryLazy",
    config = function()
      require('lualine').setup {
        options = {
          theme = "onelight",
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          -- lualine_b = { 'filename', 'branch' },
          lualine_b = { 'branch' },
          -- lualine_c = { 'fileformat' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     -- stylua: ignore
  --     local colors = {
  --       blue   = '#80a0ff',
  --       cyan   = '#79dac8',
  --       black  = '#080808',
  --       white  = '#c6c6c6',
  --       red    = '#ff5189',
  --       violet = '#d183e8',
  --       grey   = '#303030',
  --     }
  --
  --     local bubbles_theme = {
  --       normal = {
  --         a = { fg = colors.black, bg = colors.violet },
  --         b = { fg = colors.white, bg = colors.grey },
  --         c = { fg = colors.white, bg = colors.black },
  --       },
  --       insert = { a = { fg = colors.black, bg = colors.blue } },
  --       visual = { a = { fg = colors.black, bg = colors.cyan } },
  --       replace = { a = { fg = colors.black, bg = colors.red } },
  --       inactive = {
  --         a = { fg = colors.white, bg = colors.black },
  --         b = { fg = colors.white, bg = colors.black },
  --         c = { fg = colors.white, bg = colors.black },
  --       },
  --     }
  --
  --     require('lualine').setup {
  --       options = {
  --         theme = bubbles_theme,
  --         component_separators = '|',
  --         section_separators = { left = '', right = '' },
  --       },
  --       sections = {
  --         lualine_a = {
  --           { 'mode', separator = { left = '' }, right_padding = 2 },
  --         },
  --         -- lualine_b = { 'filename', 'branch' },
  --         lualine_b = { 'branch' },
  --         -- lualine_c = { 'fileformat' },
  --         lualine_c = { { 'filename', path = 1 } },
  --         lualine_x = {},
  --         lualine_y = { 'filetype', 'progress' },
  --         lualine_z = {
  --           { 'location', separator = { right = '' }, left_padding = 2 },
  --         },
  --       },
  --       inactive_sections = {
  --         lualine_a = { 'filename' },
  --         lualine_b = {},
  --         lualine_c = {},
  --         lualine_x = {},
  --         lualine_y = {},
  --         lualine_z = { 'location' },
  --       },
  --       tabline = {},
  --       extensions = {},
  --     }
  --   end,
  -- },
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'hlargs'.setup()
    end
  },

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufReadPre",
  --   config = {
  --     buftype_exclude = { "terminal", "nofile" },
  --     filetype_exclude = {
  --       "help",
  --       "startify",
  --       "dashboard",
  --       "packer",
  --       "neogitstatus",
  --       "NvimTree",
  --       "neo-tree",
  --       "Trouble",
  --     },
  --     char = "▏",
  --     use_treesitter_scope = true,
  --     show_trailing_blankline_indent = false,
  --     show_current_context = true,
  --     context_patterns = {
  --       "class",
  --       "return",
  --       "function",
  --       "method",
  --       "^if",
  --       "^while",
  --       "jsx_element",
  --       "^for",
  --       "^object",
  --       "^table",
  --       "block",
  --       "arguments",
  --       "if_statement",
  --       "else_clause",
  --       "jsx_element",
  --       "jsx_self_closing_element",
  --       "try_statement",
  --       "catch_clause",
  --       "import_statement",
  --       "operation_type",
  --     },
  --   },
  -- },
}
