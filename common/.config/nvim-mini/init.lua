vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

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
vim.o.number = true
vim.o.relativenumber = true

vim.o.wildmode = "list:longest,list:full"
vim.o.scrolloff = 4
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "100"
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { nbsp = "+", trail = "-", tab = "  ", lead = " " }

-- Tab & Indent --
vim.o.tabstop = 4
vim.o.shiftwidth = 0 -- follow tabstop
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
      vim.o.shiftwidth = 0 -- tabstopに従う
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

-------------------------------
-- Keymaps
-------------------------------

nnoremap("<C-h>", cmd("bn"))
nnoremap("<C-l>", cmd("bp"))
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
cnoremap("<C-x>", "<C-f>") -- open cmdwin

nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")
nnoremap("Y", "y$")

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
-- Plugins
-------------------------------

-- Clone 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
local MiniDeps = require("mini.deps")
MiniDeps.setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "obizip/quietbuddy.nvim",
    depends = {
      "tjdevries/colorbuddy.nvim",
    },
  })

  vim.cmd.colorscheme("quietbuddy")
end)

now(function()
  add({ source = "nvim-lualine/lualine.nvim" })
  require("lualine").setup()
end)

later(function()
  add({
    source = "folke/which-key.nvim",
  })

  require("which-key").setup({
    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
    },
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
  })
end)

later(function()
  add("echasnovski/mini.bufremove")

  require("mini.bufremove").setup()
  nnoremap("<leader>d", cmd("lua MiniBufremove.wipeout()"), "Delete Buffer")
end)

now(function()
  add({
    source = "saghen/blink.cmp",
    depends = { "rafamadriz/friendly-snippets" },
  })

  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
  })

  add({
    source = "j-hui/fidget.nvim",
  })

  require("blink.cmp").setup({
    keymap = {
      preset = "none",
      ["<C-g>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-c>"] = { "cancel", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-n>"] = { "snippet_forward", "select_next", "fallback" },
      ["<C-p>"] = { "snippet_backward", "select_prev", "fallback" },
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
            { "kind" },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "lua" },
  })

  require("mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local config = {}
      if server_name == "lua_ls" then
        config.settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        }
      end

      config.capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig")[server_name].setup(config)
    end,
  })

  require("lspconfig")["ocamllsp"].setup({})

  require("fidget").setup()

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, signs = true, underline = false })

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
end)

later(function()
  add({
    source = "nvim-telescope/telescope.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

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
  })
end)

later(function()
  add({
    source = "nvim-tree/nvim-tree.lua",
  })

  require("nvim-tree").setup({
    view = {
      width = 30,
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
  })

  nnoremap("<leader>t", cmd("NvimTreeToggle"))
end)

later(function()
  add({
    source = "stevearc/conform.nvim",
  })

  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
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
  })
end)

later(function()
  add({
    source = "lewis6991/gitsigns.nvim",
  })

  require("gitsigns").setup({
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  })
end)

later(function()
  add({
    source = "kevinhwang91/nvim-hlslens",
  })

  require("hlslens").setup({
    nearest_only = true,
  })

  nnoremap("n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
  nnoremap("N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
  nnoremap("*", [[*<Cmd>lua require('hlslens').start()<CR>]])
  nnoremap("#", [[#<Cmd>lua require('hlslens').start()<CR>]])
end)

later(function()
  add({
    source = "shortcuts/no-neck-pain.nvim",
  })

  require("no-neck-pain").setup()
  nnoremap("<leader>z", cmd("NoNeckPain"), "Zenn Mode")
end)

later(function()
  add({ source = "echasnovski/mini.align", checkout = "stable" })

  require("mini.align").setup(
    -- No need to copy this inside `setup()`. Will be used automatically.
    {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },

      -- Modifiers changing alignment steps and/or options
      -- modifiers = {
      --   -- Main option modifiers
      --   ['s'] = --<function: enter split pattern>,
      --   ['j'] = --<function: choose justify side>,
      --   ['m'] = --<function: enter merge delimiter>,
      --
      --   -- Modifiers adding pre-steps
      --   ['f'] = --<function: filter parts by entering Lua expression>,
      --   ['i'] = --<function: ignore some split matches>,
      --   ['p'] = --<function: pair parts>,
      --   ['t'] = --<function: trim parts>,
      --
      --   -- Delete some last pre-step
      --   ['<BS>'] = --<function: delete some last pre-step>,
      --
      --   -- Special configurations for common splits
      --   ['='] = --<function: enhanced setup for '='>,
      --   [','] = --<function: enhanced setup for ','>,
      --   ['|'] = --<function: enhanced setup for '|'>,
      --   [' '] = --<function: enhanced setup for ' '>,
      -- },
    }
  )
end)
