---
--- Options
---

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.clipboard = "unnamedplus"
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

vim.opt.complete = "o,.,w,b,u,t"
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

-- vim.cmd([[
-- colorscheme quiet
-- hi Comment   guifg=lightgreen
-- hi Type      gui=bold
-- hi Constant  guifg=lightblue
-- hi Keyword   guifg=darkgray gui=italic
-- hi Statement guifg=darkgray gui=italic
-- hi PreProc   guifg=darkgray gui=italic
-- hi Pmenu     guifg=white guibg=#333333
-- hi DiagnosticUnnecessary guifg=NONE guibg=NONE
-- hi Directory guifg=lightblue
-- hi GitSignsAdd     guifg=#008B00
-- hi GitSignsChange  guifg=#0040FF
-- hi GitSignsDelete  guifg=#E60026
-- ]])

-- vim.o.cmdheight = 0
-- require("vim._core.ui2").enable({
-- 	enable = true,
-- 	msg = {
-- 		targets = {
-- 			-- -- 既定: 軽い通知系は msg ポップアップへ
-- 			[""] = "msg",
-- 			empty = "msg",
-- 			bufwrite = "msg",
-- 			confirm = "cmd",
-- 			emsg = "cmd",
-- 			echo = "cmd",
-- 			echomsg = "cmd",
-- 			echoerr = "cmd",
-- 			completion = "cmd",
-- 			list_cmd = "pager",
-- 			lua_error = "pager",
-- 			lua_print = "cmd",
-- 			progress = "cmd",
-- 			rpc_error = "pager",
-- 			quickfix = "cmd",
-- 			search_cmd = "cmd",
-- 			search_count = "cmd",
-- 			shell_cmd = "cmd",
-- 			shell_err = "pager",
-- 			shell_out = "pager",
-- 			shell_ret = "cmd",
-- 			undo = "cmd",
-- 			verbose = "cmd",
-- 			wildlist = "cmd",
-- 			wmsg = "cmd",
-- 		},
-- 	},
-- })

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

-- 入力されたパスからディレクトリとファイルを一括作成するコマンド (1文字: N)
vim.api.nvim_create_user_command("E", function(opts)
	local path = vim.fn.expand(opts.args)
	local dir = vim.fn.fnamemodify(path, ":h")

	vim.fn.mkdir(dir, "p")
	vim.cmd("edit " .. path)
end, {
	nargs = 1,
	complete = "file",
})

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
-- Plugin Manager
--

local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd("echo 'Installing `mini.nvim`' | redraw")
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd("echo 'Installed `mini.nvim`' | redraw")
end

require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local function now_if_ft(pattern, f)
	now(function()
		autocmd("FileType", {
			pattern = pattern,
			callback = f,
		})
	end)
end

--
-- LSP
--

now(function()
	add({
		source = "mason-org/mason-lspconfig.nvim",
		depends = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	})
	require("mason").setup()
	require("mason-lspconfig").setup()

	vim.lsp.enable("ocamllsp")

	add("j-hui/fidget.nvim")
	require("fidget").setup()

	vim.diagnostic.config({
		severity_sort = true,
		virtual_text = { current_line = true },
	})

	add("stevearc/conform.nvim")
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			python = { "ruff_format", "ruff_fix" },
			ocaml = { "ocamlformat" },
			-- php = { "php_cs_fixer" },
			sql = { "sql_formatter" },
			javascript = { "oxfmt" },
			typescript = { "oxfmt" },
			javascriptreact = { "oxfmt" },
			typescriptreact = { "oxfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})

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
			vim.bo.complete = "o"
		end,
	})

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "MiniDeps" },
				},
			},
		},
	})

	vim.lsp.config("rust_analyzer", {
		settings = {
			["rust-analyzer"] = {
				completion = {
					callable = {
						snippets = "none",
					},
				},
			},
		},
	})
end)

later(function()
	add("folke/trouble.nvim")
	require("trouble").setup()
	nnoremap("<Leader>x", cmd("Trouble diagnostics toggle"), "Toggle Diagnostics Viewer")
	nnoremap("<Leader>q", cmd("Trouble qflist toggle"), "Toggle QuickFix Viewer")
end)

--
-- File Picker
--

later(function()
	local function make_fzf_native(params)
		vim.notify("Building fzf native extension", vim.log.levels.INFO)
		vim.cmd("lcd " .. params.path)
		vim.cmd("!make -s")
		vim.cmd("lcd -")
	end

	add({
		source = "nvim-telescope/telescope.nvim",
		checkout = "v0.2.1",
		depends = {
			"nvim-lua/plenary.nvim",
			{
				source = "nvim-telescope/telescope-fzf-native.nvim",
				hooks = {
					post_checkout = make_fzf_native,
					post_install = make_fzf_native,
				},
			},
		},
	})

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
	vim.keymap.set("n", "<leader>f", picker.find_files, { desc = "Find Files" })
	vim.keymap.set("n", "<leader>g", picker.git_files, { desc = "Find Git Files" })
	vim.keymap.set("n", "<leader>/", picker.live_grep, { desc = "Live Grep" })
end)

later(function()
	add("j-morano/buffer_manager.nvim")
	require("buffer_manager").setup()

	-- Setup
	require("buffer_manager").setup({ height = 0.75 })
	-- Navigate buffers bypassing the menu
	local bmui = require("buffer_manager.ui")
	local keys = "1234567890"
	for i = 1, #keys do
		local key = keys:sub(i, i)
		nnoremap(string.format("<Leader>%s", key), function()
			bmui.nav_file(i)
		end)
	end
	nnoremap("<Leader>b", bmui.toggle_quick_menu, "Toggle Buffer Viewer")
	nnoremap("<C-n>", bmui.nav_next)
	nnoremap("<C-p>", bmui.nav_prev)
end)

---
--- Editing
---

later(function()
	add("folke/flash.nvim")
	require("flash").setup({
		modes = {
			char = {
				enabled = false,
			},
		},
	})
	nnoremap("s", function()
		require("flash").jump()
	end)
end)

---
--- UI
---

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	-- require("nvim-treesitter").install({ "vimdoc", "lua", "html", "typescript", "tsx", "html", "css" })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "vimdoc", "c3", "nim", "typescript", "typescriptreact" },
		callback = function()
			vim.treesitter.start()
		end,
	})
end)

-- now(function()
-- 	add("obizip/bquiet.nvim")
-- 	require("bquiet").setup({ style = "dark" })
-- 	vim.cmd.colorscheme("bquiet")
-- end)
now(function()
	add("dchinmay2/alabaster.nvim")
	vim.cmd.colorscheme("alabaster")
end)
-- now(function()
-- 	-- add("folke/tokyonight.nvim")
-- 	add("catppuccin/nvim")
--
-- 	vim.cmd([[colorscheme catppuccin-nvim]])
-- end)
--
now(function()
	add("folke/which-key.nvim")
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
end)

now(function()
	add("nvim-lualine/lualine.nvim")
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
end)

now(function()
	add("lewis6991/gitsigns.nvim")
	require("gitsigns").setup({
		signcolumn = false,
		numhl = true,
	})
end)

later(function()
	add("kevinhwang91/nvim-hlslens")
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
end)

now(function()
	add("nvim-tree/nvim-tree.lua")
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
	nnoremap("<Leader>t", "<Cmd>NvimTreeToggle<CR>", "Toggle Tree Viewer")
end)

now(function()
	add("lukas-reineke/indent-blankline.nvim")
	require("ibl").setup({ scope = { enabled = false } })
end)

--
-- Language Specific
--

now_if_ft("markdown", function()
	add({
		source = "delphinus/md-render.nvim",
	})
	nnoremap("<leader>m", "<Plug>(md-render-preview-tab)", "Markdown preview (toggle)")
end)

now_if_ft("typescriptreact", function()
	add("windwp/nvim-ts-autotag")
	require("nvim-ts-autotag").setup()
end)
