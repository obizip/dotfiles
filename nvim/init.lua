---
--- Options
---

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
vim.o.errorbells = false
vim.o.visualbell = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.autowrite = true
vim.o.autowriteall = true
vim.o.autoread = true
vim.o.undofile = true

vim.o.termguicolors = true

vim.o.showmode = false
vim.o.showcmd = false

vim.o.splitbelow = true

vim.o.wildmode = "list:longest,list:full"
vim.o.wildignorecase = true
vim.o.scrolloff = 4
vim.o.cursorline = true

-- vim.opt.complete = "o,.,w,b,u,t"
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "popup" }

vim.o.virtualedit = "block"

vim.o.linebreak = true
vim.o.showbreak = "+ "
vim.o.breakindent = true
vim.o.smoothscroll = true
vim.o.signcolumn = "yes:1"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.formatoptions = "tqj"
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.expandtab = true

vim.o.background = "dark"

--
-- Auto Commands
--

local autocmd = vim.api.nvim_create_autocmd

local function set_indent_width(pattern, width)
	autocmd("FileType", {
		pattern = pattern,
		callback = function()
			vim.o.tabstop = width
			vim.o.shiftwidth = 0
			vim.o.softtabstop = -1
		end,
	})
end

set_indent_width({
	"markdown",
	"c",
	"cpp",
	"lua",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"ocaml",
	"sql",
	"nim",
}, 2)

local usercmd = vim.api.nvim_create_user_command

--
-- Keymaps
--

local function noremap(mode, lhs, rhs, desc)
	vim.keymap.set({ mode }, lhs, rhs, { desc = desc, noremap = true })
end

local function nnoremap(lhs, rhs, desc)
	noremap("n", lhs, rhs, desc)
end

local function inoremap(lhs, rhs, desc)
	noremap("i", lhs, rhs, desc)
end

local function vnoremap(lhs, rhs, desc)
	noremap("v", lhs, rhs, desc)
end

-- local function cnoremap(lhs, rhs, desc)
-- 	noremap("c", lhs, rhs, desc)
-- end
--
-- local function tnoremap(lhs, rhs, desc)
-- 	noremap("t", lhs, rhs, desc)
-- end

local function cmd(command)
	return "<Cmd>" .. command .. "<CR>"
end

inoremap("<C-b>", "<left>")
inoremap("<C-f>", "<right>")
inoremap("<C-a>", "<C-o>^")
inoremap("<C-e>", "<end>")

nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")
nnoremap("Y", "y$")
nnoremap("<Leader>n", cmd("set nu!"), "Toggle Number Column")

nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

nnoremap("<C-n>", cmd("bn"))
nnoremap("<C-p>", cmd("bp"))

vnoremap("j", "gj")
vnoremap("k", "gk")
vnoremap("gj", "j")
vnoremap("gk", "k")

-- ref: https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
vim.keymap.set({ "i" }, "<C-l>", function()
	local line = vim.fn.getline(".")
	local col = vim.fn.getpos(".")[3]
	local substring = line:sub(1, col - 1)
	local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
	return "<C-w>" .. result:upper()
end, { expr = true })

--
-- Plugins
--

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({
	preset = "helix",
	filter = function(mapping)
		return mapping.desc and mapping.desc ~= ""
	end,
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
		{ "g", mode = { "n", "v" } },
	},
	icons = {
		mappings = false,
	},

	sort = { "desc" },
	plugins = {
		marks = false,
		registers = false,
		spelling = {
			enabled = false,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
})

local hooks = {} -- table of `function (ev, name, kind) ... end`

vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

-- Hightlight
table.insert(hooks, function(_, name, kind)
	if name == "nvim-treesitter" and kind == "update" then
		vim.cmd("TSUpdate")
	end
end)
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local highlighting_filetypes = { "typescript", "tsx", "javascript", "jsx" }
require("nvim-treesitter").install(highlighting_filetypes)

vim.api.nvim_create_autocmd("FileType", {
	pattern = highlighting_filetypes,
	callback = function()
		vim.treesitter.start()
	end,
})

-- LSP
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

autocmd("LspAttach", {
	callback = function()
		-- Default Keymaps
		-- grn : vim.lsp.buf.rename()
		-- gra : vim.lsp.buf.code_action()
		-- grr : vim.lsp.buf.references()
		-- gri : vim.lsp.buf.implementation()
		-- grt : vim.lsp.buf.type_definition()
		-- gO  : vim.lsp.buf.document_symbol()
		-- CTRL-S : vim.lsp.buf.signature_help()
		nnoremap("K", vim.lsp.buf.hover, "Hover")
		nnoremap("grd", vim.lsp.buf.definition, "Definition")
		nnoremap("grD", vim.lsp.buf.declaration, "Declaration")
		nnoremap("ge", vim.diagnostic.open_float, "Open Floating Diagnostic Window")
		nnoremap("[g", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Go To Previous Diagnostic")
		nnoremap("]g", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Go To Next Diagnostic")
		nnoremap("g=", vim.lsp.buf.format, "Format")

		vim.o.formatoptions = "tqj"
		-- vim.bo.complete = "o"
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.enable("clangd")

vim.lsp.config("phpantom_lsp", {
	cmd = { "phpantom_lsp" },
	filetypes = { "php" },
	root_markers = { ".phpantom.toml", ".git", "composer.json" },
})
vim.lsp.enable("phpantom_lsp")

-- Formatter
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup()
nnoremap("<Leader>x", cmd("Trouble diagnostics toggle"), "Toggle Diagnostics Viewer")
nnoremap("<Leader>q", cmd("Trouble qflist toggle"), "Toggle QuickFix Viewer")

-- Fuzzy finder
table.insert(hooks, function(ev, name, kind)
	if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
		vim.system({ "make" }, { cwd = ev.data.path })
	end
end)
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzf-native.nvim" })

vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
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

			-- PHP
			"vendor/",
			"var/",
			"public/bundles/",
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
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
require("telescope").load_extension("fzf")

local picker = require("telescope.builtin")
nnoremap("<leader>f", picker.find_files, "Find Files")
nnoremap("<leader>g", picker.git_files, "Find Git Files")
nnoremap("<leader>/", picker.live_grep, "Live Grep")

-- Filer
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({})
nnoremap("-", cmd("Oil"), "Open parent directory")

vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })
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
				bookmarks = false,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
})
nnoremap("<Leader>t", cmd("NvimTreeToggle"), "Toggle Tree Viewer")

-- UI
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
	options = {
		-- theme = "codedark",
		icons_enabled = false,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "|", right = "|" },
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename", "branch", "diagnostics" },
		lualine_x = { "progress", "location" },
		lualine_y = {},
		lualine_z = {},
	},
})

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup({
	signcolumn = false,
	numhl = true,
})

vim.pack.add({ "https://github.com/kevinhwang91/nvim-hlslens" })
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
vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		for _, hook in ipairs(hooks) do
			hook(ev, name, kind)
		end
	end,
})
