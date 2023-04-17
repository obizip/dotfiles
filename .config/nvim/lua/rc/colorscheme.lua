return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Default options:
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {
          -- add/modify theme and palette colors
          palette = {
            sumiInk0 = "#000000",
            fujiWhite = "#FFFFFF",
          },
          theme = {
            wave = {},
            lotus = {},
            dragon = {
              ui = {
                bg = "#101010",
                bg_gutter = "#505050"
              }
            },
            all = {}
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            WinSeparator = { fg = theme.ui.bg_gutter },
            EndOfBuffer = { fg = theme.ui.bg_gutter },
            LineNr = { fg = theme.ui.nontext, bg = theme.ui.bg },
            SignColumn = { fg = theme.ui.special, bg = theme.ui.bg },
            DiagnosticSignError = { fg = theme.diag.error, bg = theme.ui.bg },
            DiagnosticSignWarn = { fg = theme.diag.warning, bg = theme.ui.bg },
            DiagnosticSignInfo = { fg = theme.diag.info, bg = theme.ui.bg },
            DiagnosticSignHint = { fg = theme.diag.hint, bg = theme.ui.bg },
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
            GitSignsAdd = { fg = theme.vcs.added, bg = theme.ui.bg },
            GitSignsChange = { fg = theme.vcs.changed, bg = theme.ui.bg },
            GitSignsDelete = { fg = theme.vcs.removed, bg = theme.ui.bg },
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
          -- map the value of 'background' option to a theme
          dark = "dragon", -- try "dragon" !
          light = "lotus"
        },
      })

      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa")
    end
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = {
  --     "petertriho/nvim-scrollbar",
  --     "kevinhwang91/nvim-hlslens",
  --   },
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "night",
  --       transparent = true,
  --       on_highlights = function(hl, c)
  --         hl.EndOfBuffer = {
  --           fg = c.comment,
  --         }
  --       end,
  --     })
  --     vim.cmd([[colorscheme tokyonight]])
  --     local colors = require("tokyonight.colors").setup()
  --
  --     require("scrollbar").setup({
  --       handle = {
  --         color = colors.bg_highlight,
  --       },
  --       marks = {
  --         Search = { color = colors.orange },
  --         Error = { color = colors.error },
  --         Warn = { color = colors.warning },
  --         Info = { color = colors.info },
  --         Hint = { color = colors.hint },
  --         Misc = { color = colors.purple },
  --       }
  --     })
  --
  --     -- require('hlslens').setup() is not required
  --     require("scrollbar.handlers.search").setup({
  --       -- hlslens config overrides
  --       nearest_only = true
  --     })
  --   end,
  -- },
}
