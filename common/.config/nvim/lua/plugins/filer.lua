return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    config = function()
      require("oil").setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>t", "<CMD>NvimTreeToggle<CR>", desc = "Open parent directory" },
    },
    opts = {
      sort = {
        -- sorter = "case_sensitive",
      },
      view = {
        width = 15,
      },
      renderer = {
        indent_width = 1,
        add_trailing = true,
        group_empty = true,
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
            modified = false,
            hidden = false,
            diagnostics = false,
            bookmarks = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local nnoremap = require("utils").nnoremap
      nnoremap("<leader>f", builtin.find_files)
      nnoremap("<leader>c", function()
        builtin.find_files({ cwd = "~/.config" })
      end)
      nnoremap("<leader>g", builtin.live_grep)
      nnoremap("<leader>b", builtin.buffers)
      nnoremap("<leader>h", builtin.help_tags)

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          file_ignore_patterns = {
            ".git/",
            "yarn.lock",
            "package%-lock.json",
            "%.png",
            "%.jpg",
            "%.svg",
            "%.webp",
            "%.ico",
            "node_modules/",
            "target/",
            "_build/",
            "old%-configs/",
            "vendor/",
          },
          mappings = {
            i = {
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-\\>"] = "which_key",
            },
            n = {
              ["<C-c>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })

      require("telescope").load_extension("fzf")
    end,
  },
}
