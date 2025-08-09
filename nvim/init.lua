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
vim.o.autoread = true
vim.o.undofile = true

-- Display --
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = false

vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.showmatch = true
vim.o.showcmd = false
vim.o.laststatus = 2
vim.o.wildmode = "list:longest,list:full"
vim.o.scrolloff = 4
-- vim.o.signcolumn = "yes:1"
-- vim.o.colorcolumn = "100"
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { nbsp = "+", trail = "-", tab = "  ", lead = " " }
vim.o.splitbelow = true

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
  "sql",
}, 2)

local usercmd = vim.api.nvim_create_user_command
usercmd('CopyRelPath', "let @* = expand('%')", {})

-------------------------------
-- Keymaps
-------------------------------

-- nnoremap("<C-h>", cmd("bn"))
-- nnoremap("<C-l>", cmd("bp"))
nnoremap("<C-k>", "<C-w><C-w>")
nnoremap("<ESC><ESC>", cmd("noh"))

inoremap("<C-b>", "<left>")
inoremap("<C-f>", "<right>")
inoremap("<C-a>", "<C-o>^")
inoremap("<C-e>", "<end>")
inoremap("<C-y>", "<C-r>+") -- paste

-- cnoremap("<C-b>", "<left>")
-- cnoremap("<C-f>", "<right>")
-- cnoremap("<C-a>", "<home>")
-- cnoremap("<C-e>", "<end>")
cnoremap("<C-y>", "<C-r>+") -- paste
-- cnoremap("<C-x>", "<C-f>")  -- open cmdwin

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
        "obizip/bquiet.nvim",
        -- dir = "~/dev/bquiet.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          vim.cmd.colorscheme("bquiet")
        end
      },
      {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        opts = {
          options = {
            theme = {
              normal = {
                a = { fg = '#cccccc', bg = '#202020', gui = 'bold' },
                b = { fg = '#8D8CD8', bg = '#202020', gui = 'bold' },
                c = { fg = '#cccccc', bg = '#202020', gui = 'bold' },
                x = { fg = '#cccccc', bg = '#202020', gui = 'bold' },
                y = { fg = '#cccccc', bg = '#202020', gui = 'bold' },
                z = { fg = '#cccccc', bg = '#202020', gui = 'bold' },
              },
              inactive = {
                a = { fg = '#cccccc', bg = '#101010' },
                b = { fg = '#8D8CD8', bg = '#101010' },
                c = { fg = '#cccccc', bg = '#101010' },
                x = { fg = '#cccccc', bg = '#101010' },
                y = { fg = '#cccccc', bg = '#101010' },
                z = { fg = '#cccccc', bg = '#101010' },
              },
            },
            icons_enabled = false,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
          },
          sections = {
            lualine_a = { { 'filename', path = 1 } },
            lualine_b = { 'branch', 'diagnostics' },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' }
          },
          inactive_sections = {
            lualine_a = { { 'filename', path = 1 } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' }
          },
        }
      },
      {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
          require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            -- ensure_installed = { "rust", "go", "python", "lua", "vim", "vimdoc", "yaml", "json", "javascript", "typescript", "html", "css" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            -- sync_install = true,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
              enable = true,
              disable = { "dockerfile" },
              additional_vim_regex_highlighting = false,
            },

            indent = {
              enable = true,
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
            -- python = function(bufnr)
            --   if require("conform").get_formatter_info("ruff_format", bufnr).available then
            --     return { "ruff_format" }
            --   else
            --     return { "isort", "black" }
            --   end
            -- end,
            python = { "ruff_format", "ruff_fix" },
            ocaml = { "ocamlformat" },
            php = { "php_cs_fixer" },
            sql = { "sql_formatter" },
          },
          formatters = {
            ruff_fix = {
              args = {
                "check",
                "--fix",
                "--select",
                "I",
                "--force-exclude",
                "--exit-zero",
                "--no-cache",
                "--stdin-filename",
                "$FILENAME",
                "-",
              },
            },
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
        "j-morano/buffer_manager.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
          local opts = { noremap = true }
          -- Setup
          require("buffer_manager").setup({
            -- select_menu_item_commands = {
            --   v = {
            --     key = "<C-v>",
            --     command = "vsplit"
            --   },
            --   h = {
            --     key = "<C-h>",
            --     command = "split"
            --   }
            -- },
            focus_alternate_buffer = false,
            short_file_names = false,
            short_term_names = false,
            loop_nav = true,
            highlight = 'Normal:BufferManagerBorder',
            win_extra_options = {
              winhighlight = 'Normal:BufferManagerNormal',
            },
          })
          -- Navigate buffers bypassing the menu
          local bmui = require("buffer_manager.ui")
          local keys = '1234567890'
          for i = 1, #keys do
            local key = keys:sub(i, i)
            nnoremap(
              string.format('<leader>%s', key),
              function() bmui.nav_file(i) end,
              string.format("Open Buffer%s", key)
            )
          end
          -- Just the menu
          nnoremap('<leader><leader>', bmui.toggle_quick_menu, "Open Buffer Manager")
          tnoremap('<leader><leader>', bmui.toggle_quick_menu, "Open Buffer Manager")
          -- Open menu and search
          -- map({ 't', 'n' }, '<M-m>', function()
          --   bmui.toggle_quick_menu()
          --   -- wait for the menu to open
          --   vim.defer_fn(function()
          --     vim.fn.feedkeys('/')
          --   end, 50)
          -- end, opts)
          -- Next/Prev
          nnoremap('<C-l>', bmui.nav_next)
          nnoremap('<C-h>', bmui.nav_prev)
        end
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
        version = "1.*",
        opts = {
          keymap = {
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            -- ['<C-e>'] = { 'hide' },
            ['<C-y>'] = { 'select_and_accept' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
            -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<C-k>'] = { 'snippet_forward', 'fallback' },
            ['<C-j>'] = { 'snippet_backward', 'fallback' },
            -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
          },
          completion = {
            accept = { auto_brackets = { enabled = false }, },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
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
              nnoremap("g[", function() vim.diagnostic.jump({ count = -1 }) end, "Go To Previous Diagnostic")
              nnoremap("g]", function() vim.diagnostic.jump({ count = 1 }) end, "Go To Next Diagnostic")
              nnoremap("g=", vim.lsp.buf.format, "Format")
              nnoremap("grn", vim.lsp.buf.rename, "Rename Symbol")
              nnoremap("<leader>r", vim.lsp.buf.rename, "Rename Symbol")
            end,
          })


          vim.diagnostic.config({
            virtual_text = false,
            underline = false,
            loclist = {
              severity = { min = vim.diagnostic.severity.WARN }
            },
            jump = {
              float = true,
              severity = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }
            },
            signs = {
              text = {
                [vim.diagnostic.severity.HINT] = '',
              },
            }
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

          vim.lsp.config('rust_analyzer', {
            settings = {
              ['rust-analyzer'] = {
                completion = {
                  callable = {
                    snippets = "none"
                  }
                }
              }
            },
          })

          -- vim.lsp.config('ocamlls', {
          --   cmd = { 'ocamllsp' },
          --   filetypes = { 'ocaml', 'reason' },
          --   root_dir = function(bufnr, on_dir)
          --     local fname = vim.api.nvim_buf_get_name(bufnr)
          --     on_dir(util.root_pattern('*.opam', 'esy.json', 'package.json')(fname))
          --   end,
          -- })

          -- local lspconfig = require('lspconfig')
          -- vim.lsp.config("pyright", lspconfig.configs.pyright)
          vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls", "pyright", "denols", "ocamllsp" })
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
        'akinsho/toggleterm.nvim',
        version = "*",
        lazy = false,
        config = function()
          require("toggleterm").setup()

          local term = require("toggleterm.terminal").Terminal
          local tig_term = term:new({
            cmd = "tig status",
            dir = "git_dir",
            direction = "float",
            hidden = true,
            on_open = function(term)
              tnoremap("<leader>g", "<CMD>close<CR>", "Hide Tig")
            end,
          })

          function ToggleTigTerminal()
            tig_term:toggle()
          end

          nnoremap("<leader>g", "<cmd>lua ToggleTigTerminal()<CR>", "Open tig")
        end
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
      {
        "pappasam/nvim-repl",
        event = "VeryLazy",
        opts = {
          filetype_commands = {
            ocaml = { cmd = "ocaml", filetype = "ocaml" }
          },
          open_window_default = "10new"
        },
        keys = {
          { "<Leader>sc", "<Plug>(ReplSendCell)",   mode = "n", desc = "Send Repl Cell" },
          { "<Leader>sl", "<Plug>(ReplSendLine)",   mode = "n", desc = "Send Repl Line" },
          { "<Leader>sl", "<Plug>(ReplSendVisual)", mode = "x", desc = "Send Repl Visual Selection" },
        },
      },
    },
  },
})
