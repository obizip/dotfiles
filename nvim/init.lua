vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
vim.env.PATH = "/mise/shims:" .. vim.env.PATH

-------------------------------
-- Options
-------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.clipboard = "unnamedplus"
vim.o.errorbells = false
vim.o.visualbell = false

-- File --
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.autowrite = true
vim.o.undofile = true

-- Display --
vim.o.termguicolors = true
vim.o.number = false
vim.o.relativenumber = false

vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.showcmd = false
vim.o.laststatus = 2
vim.o.wildmode = "list:longest,list:full"
vim.o.scrolloff = 4
vim.o.signcolumn = "yes:1"
-- vim.o.colorcolumn = "100"
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { nbsp = "+", trail = "-", tab = "  ", lead = " " }

-- Tab & Indent --
vim.o.tabstop = 4
vim.o.shiftwidth = 0   -- follow tabstop
vim.o.softtabstop = -1 -- follow shiftwidth

vim.o.smartindent = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "+ "
vim.o.breakindent = true
vim.o.smoothscroll = true

-- Search --
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.filetype.add({
  extension = {
    vto = "vento",
    xwl = "xml",
    lwx = "xml",
  },
})

-------------------------------
-- Utils
-------------------------------

local function nnoremap(lhs, rhs, desc)
  vim.keymap.set({ "n" }, lhs, rhs, { desc = desc, noremap = true })
end

local function inoremap(lhs, rhs, desc)
  vim.keymap.set({ "i" }, lhs, rhs, { desc = desc, noremap = true })
end

local function vnoremap(lhs, rhs, desc)
  vim.keymap.set({ "v" }, lhs, rhs, { desc = desc, noremap = true })
end

local function cnoremap(lhs, rhs, desc)
  vim.keymap.set({ "c" }, lhs, rhs, { desc = desc, noremap = true })
end

local function tnoremap(lhs, rhs, desc)
  vim.keymap.set({ "t" }, lhs, rhs, { desc = desc, noremap = true })
end

local function cmd(command)
  return "<CMD>" .. command .. "<CR>"
end

local autocmd = vim.api.nvim_create_autocmd

local function set_ft_indent(pattern, indent)
  autocmd("FileType", {
    pattern = pattern,
    callback = function()
      vim.o.tabstop = indent -- only set tabstop
      vim.o.shiftwidth = 0   -- tabstopに従う
      vim.o.softtabstop = -1 -- shiftwidthに従う
      vim.opt_local.expandtab = true
    end,
  })
end



autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})

set_ft_indent({
  "c",
  "cpp",
  "lua",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "ocaml",
}, 2)

local usercmd = vim.api.nvim_create_user_command
usercmd('CopyRelPath', "let @* = expand('%')", {})

-------------------------------
-- Keymaps
-------------------------------

nnoremap("<C-h>", cmd("bn | file"))
nnoremap("<C-l>", cmd("bp | file"))
nnoremap("<C-k>", "<C-w><C-w>")
nnoremap("<ESC><ESC>", cmd("noh"))

inoremap("<C-b>", "<left>")
inoremap("<C-f>", "<right>")
inoremap("<C-a>", "<C-o>^")
inoremap("<C-e>", "<end>")
inoremap("<C-y>", "<C-r>+") -- paste

cnoremap("<C-b>", "<left>")
cnoremap("<C-f>", "<right>")
cnoremap("<C-a>", "<home>")
cnoremap("<C-e>", "<end>")
cnoremap("<C-y>", "<C-r>+") -- paste
cnoremap("<C-x>", "<C-f>")  -- open cmdwin

nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")
nnoremap("Y", "y$")
nnoremap("<leader>n", cmd("set nu! | set rnu!"), "Toggle number")

vnoremap("j", "gj")
vnoremap("k", "gk")
vnoremap("gj", "j")
vnoremap("gk", "k")

tnoremap("<Esc>", [[<C-\><C-n>]])

-- ref: https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
vim.keymap.set("i", "<C-l>", function()
  local line = vim.fn.getline(".")
  local col = vim.fn.getpos(".")[3]
  local substring = line:sub(1, col - 1)
  local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
  return "<C-w>" .. result:upper()
end, { expr = true })

-------------------------------
-- Lazy
-------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  defaults = { lazy = true },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  ui = {
    icons = {
      cmd = "[cmd]",
      config = "[config]",
      event = "[event]",
      favorite = "[favorite]",
      ft = "[ft]",
      init = "[init]",
      import = "[import]",
      keys = "[keys]",
      lazy = "[lazy]",
      loaded = "[loaded]",
      not_loaded = "[not_loaded]",
      plugin = "[plugin]",
      runtime = "[runtime]",
      require = "[require]",
      source = "[source]",
      start = "[start]",
      task = "[task]",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  spec = {
    {
      -- {
      -- 	"folke/tokyonight.nvim",
      -- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
      -- 	priority = 1000, -- make sure to load this before all the other start plugins
      -- 	config = function()
      -- 		-- load the colorscheme here
      -- 		vim.cmd([[colorscheme tokyonight]])
      -- 	end,
      -- },
      {
        'junegunn/vim-easy-align',
        lazy = false,
        config = function()
          -- EasyAlign を visual モードで使用
          vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {})

          -- EasyAlign をノーマルモードで使用
          vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', {})
        end
      },
      {
        "obizip/quietbuddy.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        dependencies = {
          "tjdevries/colorbuddy.nvim"
        },
        config = function()
          -- load the colorscheme here
          vim.cmd([[colorscheme quietbuddy]])
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
          require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = { "rust", "go", "python", "lua", "vim", "vimdoc", "yaml", "json", "javascript", "typescript", "html", "css" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = true,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            highlight = {
              enable = true,
              disable = { "dockerfile" },
              additional_vim_regex_highlighting = false,
            },

            indent = {
              enable = false,
            },

          })
        end,
      },
      {
        "folke/which-key.nvim",
        lazy = false,
        opts = {
          preset = "helix",
          triggers = {
            { "<leader>", mode = { "n", "v" } },
            { "g",        mode = { "n", "v" } },
          },
          icons = {
            mappings = false,
          },
          plugins = {
            marks = false,     -- shows a list of your marks on ' and `
            registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            spelling = {
              enabled = false,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
              suggestions = 20, -- how many suggestions should be shown in the list?
            },
            presets = {
              operators = false,    -- adds help for operators like d, y, ...
              motions = false,      -- adds help for motions
              text_objects = false, -- help for text objects triggered after entering an operator
              windows = false,      -- default bindings on <c-w>
              nav = false,          -- misc bindings to work with windows
              z = false,            -- bindings for folds, spelling and others prefixed with z
              g = false,            -- bindings for prefixed with g
            },
          }
        },
      },
      {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
          {
            "<leader>x",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
          },
          -- {
          --   "<leader>xX",
          --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          --   desc = "Buffer Diagnostics (Trouble)",
          -- },
          -- {
          --   "<leader>xL",
          --   "<cmd>Trouble loclist toggle<cr>",
          --   desc = "Location List (Trouble)",
          -- },
          -- {
          --   "<leader>xQ",
          --   "<cmd>Trouble qflist toggle<cr>",
          --   desc = "Quickfix List (Trouble)",
          -- },
        },
      },
      {
        "stevearc/conform.nvim",
        lazy = false,
        opts = {
          formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            -- You can also customize some of the format options for the filetype
            rust = { "rustfmt", lsp_format = "fallback" },
            -- You can use a function here to determine the formatters dynamically
            python = function(bufnr)
              if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_format" }
              else
                return { "isort", "black" }
              end
            end,
            ocaml = { "ocamlformat" },
          },
          formatters = {
            ocamlformat = {
              command = "ocamlformat",
              args = {
                "--if-then-else",
                "vertical",
                "--break-cases",
                "fit-or-vertical",
                "--type-decl",
                "sparse",
                "--enable-outside-detected-project",
                "--parens-tuple-patterns",
                "always",
                "--name",
                "$FILENAME",
                "-",
              },
            },
          },
          format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
          },
        }
      },
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
          { "<leader>t", "<CMD>NvimTreeToggle<CR>", desc = "Toggle Tree Viewer" },
        },
        opts = {
          view = {
            width = 20,
          },
          renderer = {
            indent_width = 2,
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
        },
        config = function()
          local builtin = require("telescope.builtin")
          nnoremap("<leader>f", builtin.find_files, "Find Files")
          nnoremap("<leader>c", function()
            builtin.find_files({ cwd = "~/.config" })
          end, "Find Config Files")
          nnoremap("<leader>/", builtin.live_grep, "Grep")
          nnoremap("<leader>b", builtin.buffers, "Find Buffers")
          nnoremap("<leader>h", builtin.help_tags, "Find Help")

          local actions = require("telescope.actions")
          require("telescope").setup({
            defaults = {
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
          })
        end,
      },

      {
        "saghen/blink.cmp",
        event = "InsertEnter",
        -- optional: provides snippets for the snippet source
        dependencies = "rafamadriz/friendly-snippets",
        version = "*",
        opts = {
          keymap = {
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide' },
            ['<C-y>'] = { 'select_and_accept' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<Tab>'] = { 'select_prev', 'fallback' },
            ['<S-Tab>'] = { 'select_next', 'fallback' },
            -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
            -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<C-k>'] = { 'snippet_forward', 'fallback' },
            ['<C-j>'] = { 'snippet_backward', 'fallback' },
            -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
          },
          completion = {
            list = {
              selection = {
                preselect = false,
                auto_insert = true,
              },
            },
            menu = {
              draw = {
                columns = {
                  { "label", "label_description", gap = 1 },
                  { "kind" }, },
              },
            },
          },
          sources = {
            default = { "lsp", "path", "snippets", "buffer" },
          },
          fuzzy = { implementation = "lua" },
        },
      },

      {
        "j-hui/fidget.nvim",
        lazy = false,
        opts = {},
      },

      {
        "echasnovski/mini.bufremove",
        event = "VeryLazy",
        config = function()
          require("mini.bufremove").setup()
          nnoremap("<leader>d", cmd("lua MiniBufremove.wipeout()"), "Delete Buffer")
        end
      },

      {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewfile" },
        dependencies = {
          -- "saghen/blink.cmp",
          "williamboman/mason.nvim",
          "williamboman/mason-lspconfig.nvim",
        },
        config = function()
          autocmd("LspAttach", {
            callback = function()
              nnoremap("K", vim.lsp.buf.hover, "Hover")
              nnoremap("grr", vim.lsp.buf.references, "Reference")
              nnoremap("grd", vim.lsp.buf.definition, "Definition")
              nnoremap("grD", vim.lsp.buf.declaration, "Declaration")
              nnoremap("gri", vim.lsp.buf.implementation, "Implementation")
              nnoremap("<C-s>", vim.lsp.buf.signature_help, "Signature Help")
              nnoremap("grt", vim.lsp.buf.type_definition, "Type Definition")
              nnoremap("gra", vim.lsp.buf.code_action, "Code Action")

              nnoremap("gd", vim.lsp.buf.definition, "Definition")
              nnoremap("gD", vim.lsp.buf.declaration, "Declaration")
              nnoremap("gi", vim.lsp.buf.implementation, "Implementation")
              nnoremap("gt", vim.lsp.buf.type_definition, "Type Definition")
              nnoremap("ga", vim.lsp.buf.code_action, "Code Action")

              nnoremap("ge", vim.diagnostic.open_float, "Open Floating Diagnostic Window")
              nnoremap("g[", vim.diagnostic.goto_prev, "Go To Previous Diagnostic")
              nnoremap("g]", vim.diagnostic.goto_next, "Go To Next Diagnostic")
              nnoremap("g=", vim.lsp.buf.format, "Format")
              nnoremap("grn", vim.lsp.buf.rename, "Rename Symbol")
              nnoremap("<leader>r", vim.lsp.buf.rename, "Rename Symbol")
            end,
          })


          vim.diagnostic.config({
            virtual_text = false, signs = true, underline = false
          })

          require("mason").setup()
          require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls" },
          })
          vim.lsp.config('lua_ls', {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                },
              }
            },
          })

          vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls", "pyright", "denols" })

          -- vim.cmd [[set completeopt+=menuone,noselect,popup]]
          -- vim.lsp.start({
          --   name = '*',
          --   on_attach = function(client, bufnr)
          --     vim.lsp.completion.enable(true, client.id, bufnr, {
          --       autotrigger = true, -- 自動補完を有効にする
          --       convert = function(item)
          --         return { abbr = item.label:gsub('%b()', '') }
          --       end,
          --     })
          --   end,
          -- })
        end,
      },
      {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
          signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
          numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
          linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
          word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        },
      },
      {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
          "LazyGit",
          "LazyGitConfig",
          "LazyGitCurrentFile",
          "LazyGitFilter",
          "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
          { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
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
        end,
      },
      {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        keys = { { "<leader>z", ":NoNeckPain<cr>", desc = "Zen mode" } },
      },
      {
        "echasnovski/mini.indentscope",
        version = "*",
        -- event = "VeryLazy",
        opts = {
          -- Which character to use for drawing scope indicator
          symbol = "|",
        },
      },
    },
  },
})
