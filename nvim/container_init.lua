-------------------------------
-- Options
-------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-- vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.showmatch = true
vim.o.showcmd = false
vim.o.laststatus = 2
vim.o.wildmode = "list:longest,list:full"
vim.o.scrolloff = 4
-- vim.o.signcolumn = "yes:1"
-- vim.o.colorcolumn = "100"
-- vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { nbsp = "+", trail = "-", tab = "> ", lead = " " }
-- vim.o.splitbelow = true

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
vim.o.wrapscan = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

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
      vim.o.tabstop = indent
      vim.o.shiftwidth = 0
      vim.o.softtabstop = -1
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

-- nnoremap("<C-n>", cmd("bn"))
-- nnoremap("<C-p>", cmd("bp"))
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
nnoremap("<leader>n", cmd("set nu!"), "Toggle number")

nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

vnoremap("j", "gj")
vnoremap("k", "gk")
vnoremap("gj", "j")
vnoremap("gk", "k")

-- tnoremap("<Esc>", [[<C-\><C-n>]])

-- ref: https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
vim.keymap.set("i", "<C-l>", function()
  local line = vim.fn.getline(".")
  local col = vim.fn.getpos(".")[3]
  local substring = line:sub(1, col - 1)
  local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
  return "<C-w>" .. result:upper()
end, { expr = true })

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  defaults = { lazy = true },
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("tokyonight").setup({
          style = "night",
          on_highlights = function(hl, colors)
            hl.DiagnosticUnnecessary = { fg = colors.comment }
          end
        })

        vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {
      "neovim/nvim-lspconfig",
      lazy = false,
      version = "1.x",
      dependencies = {
        "williamboman/mason.nvim",
        {
          "williamboman/mason-lspconfig.nvim",
          version = "v1.x"
        },
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
            -- nnoremap("[g", function() vim.diagnostic.jump({ count = -1 }) end, "Go To Previous Diagnostic")
            -- nnoremap("]g", function() vim.diagnostic.jump({ count = 1 }) end, "Go To Next Diagnostic")
            nnoremap("g=", vim.lsp.buf.format, "Format")
            nnoremap("grn", vim.lsp.buf.rename, "Rename Symbol")
            nnoremap("<leader>r", vim.lsp.buf.rename, "Rename Symbol")
          end,
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls" },
        })

        require("mason-lspconfig").setup_handlers {
          function(server_name) -- default handler (optional)
            local settings = {}
            if server_name == "lua_ls" then
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  },
                }
              }
            elseif server_name == "rust_analyzer" then
              settings = {
                ['rust-analyzer'] = {
                  completion = {
                    callable = {
                      snippets = "none"
                    }
                  }
                }
              }
            end
            require("lspconfig")[server_name].setup {
              settings = settings
            }
          end,
        }


        require("lspconfig")["gopls"].setup {}
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      branch = "master",
      config = function()
        require("nvim-treesitter.configs").setup({
          -- A list of parser names, or "all" (the five listed parsers should always be installed)
          ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "yaml", "json", "dockerfile", "make" },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = true,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          highlight = {
            enable = true,
          },

          indent = {
            enable = true,
          },
        })
      end
    },
    {
      "folke/which-key.nvim",
      lazy = false,
      opts = {
        preset = "modern",
        triggers = {
          { "<leader>", mode = { "n", "v" } },
          { "g",        mode = { "n", "v" } },
        },
        icons = {
          mappings = false,
        },
        plugins = {
          marks = true,      -- shows a list of your marks on ' and `
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
            g = true,             -- bindings for prefixed with g
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
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
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

          -- ['<C-k>'] = { 'snippet_forward', 'fallback' },
          -- ['<C-j>'] = { 'snippet_backward', 'fallback' },
          ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        signature = {
          enabled = true,
          trigger = {
            enabled = false,
          },
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
      "shortcuts/no-neck-pain.nvim",
      version = "*",
      keys = { { "<leader>z", ":NoNeckPain<cr>", desc = "Zen mode" } },
    },
    {
      "stevearc/conform.nvim",
      lazy = false,
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt", lsp_format = "fallback" },
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
          height = 0.75,
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
        -- local opts = { noremap = true }
        -- map({ 't', 'n' }, '<M-m>', function()
        --   bmui.toggle_quick_menu()
        --   -- wait for the menu to open
        --   vim.defer_fn(function()
        --     vim.fn.feedkeys('/')
        --   end, 50)
        -- end, opts)
        -- Next/Prev
        nnoremap('<C-n>', bmui.nav_next)
        nnoremap('<C-p>', bmui.nav_prev)
      end
    },
  },
})
