return {
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
        signcolumn                   = false,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
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
    event = "VeryLazy",
    config = function()
      local custom_nightfly = require("lualine.themes.nightfly")
      local bg = "#1a1b26"
      local fg = "#a9b1d6"

      custom_nightfly.replace.b.fg = fg
      custom_nightfly.replace.b.bg = bg

      custom_nightfly.normal.b.fg = fg
      custom_nightfly.normal.b.bg = bg
      custom_nightfly.normal.c.fg = fg
      custom_nightfly.normal.c.bg = bg

      custom_nightfly.inactive.b.fg = fg
      custom_nightfly.inactive.b.bg = bg
      custom_nightfly.inactive.c.fg = fg
      custom_nightfly.inactive.c.bg = bg

      custom_nightfly.visual.b.fg = fg
      custom_nightfly.visual.b.bg = bg

      custom_nightfly.insert.b.fg = fg
      custom_nightfly.insert.b.bg = bg

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = {},
          lualine_z = {}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
      -- require("lualine").setup({
      --   options = {
      --     -- theme = custom_nightfly,
      --     sections = {
      --       lualine_a = { 'mode' },
      --       lualine_b = { 'branch', 'diff' },
      --       lualine_c = { { 'filename', file_status = true, path = 2 } },
      --       lualine_x = { 'encoding', 'fileformat', 'filetype' },
      --       lualine_y = { 'progress' },
      --       lualine_z = { 'location' }
      --     },
      --   },
      -- })
    end,
  },

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
