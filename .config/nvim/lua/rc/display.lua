return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
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
    lazy = false,
    config = function()
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
          lualine_b = { 'branch', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'filetype' },
          lualine_y = { 'diff' },
          lualine_z = { 'location' }
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
    end
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "m-demare/hlargs.nvim",
    event = "BufReadPre",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'hlargs'.setup()
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      vim.opt.termguicolors = true
      -- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1a1b23 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#16171F gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup {
        -- show_end_of_line = true,
        -- space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
      -- require("indent_blankline").setup {
      --   char = "",
      --   char_highlight_list = {
      --     "IndentBlanklineIndent1",
      --     "IndentBlanklineIndent2",
      --   },
      --   space_char_highlight_list = {
      --     "IndentBlanklineIndent1",
      --     "IndentBlanklineIndent2",
      --   },
      --   show_trailing_blankline_indent = false,
      -- }
    end
  }
}
