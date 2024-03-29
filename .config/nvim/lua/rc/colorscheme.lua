return {
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    config = function()
      require('tokyonight').setup({
        on_highlights = function(hl, c)
          hl.EndOfBuffer = {
            fg = c.fg_gutter
          }
        end
      })
    end,
  },

  {
    "mcchrish/zenbones.nvim",
    event = "VeryLazy",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    config = function()
      vim.g.zenbones = { darkness = 'stark' }
      -- vim.cmd([[colorscheme tokyobones]])
    end
  },

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
          },
          theme = {
            wave = {},
            lotus = {},
            dragon = {
              ui = {
                bg = "#16171F",
                bg_gutter = "#6A70FA"
              }
            },
            all = {}
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            MsgArea = { fg = theme.ui.fg },
            StatusLine = { fg = "#000000", bg = "#D1D1D1" },
            StatusLineNC = { fg = theme.ui.nontext, bg = theme.ui.bg_m3 },
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
      vim.cmd([[colorscheme kanagawa]])
    end
  },
  {
    "blazkowolf/gruber-darker.nvim",
    event = "VeryLazy",
    -- opts = {
    --   bold = false,
    --   italic = {
    --     strings = false,
    --   },
    -- },
  }
}
