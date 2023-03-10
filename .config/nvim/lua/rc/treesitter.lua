local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "HiPhish/nvim-ts-rainbow2",
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "andymass/vim-matchup",
    "David-Kunz/treesitter-unit",
  },
}

function M.config()
  local opt = { noremap = true }
  vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', opt)
  vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', opt)
  vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', opt)
  vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', opt)

  require("nvim-treesitter.configs").setup({
    -- ensure_installed = { "org" },
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,
      disable = {},
      -- additional_vim_regax_highlighting = { "org" },
    },
    rainbow = {
      enable = true,
      -- list of languages you want to disable the plugin for
      disable = { "jsx" },
      -- Which query to use for finding delimiters
      query = "rainbow-parens",
      -- Highlight the entire buffer all at once
      strategy = require("ts-rainbow.strategy.global"),
      -- Do not enable for files with more than n lines
      max_file_lines = 3000,
    },
    matchup = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["as"] = "@statement.outer",
        },
        include_surrounding_whitespace = true,
      }
    }
  })
end

return M
