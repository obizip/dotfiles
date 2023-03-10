return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",

	dependencies = {
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
		"folke/which-key.nvim",
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {},
		})
		-- telescope.load_extension("fzf")

		local wk = require("which-key")
		wk.register({
			["<leader>b"] = { "<cmd>Telescope buffers<cr>", "Open buffer picker" },
			["<leader>d"] = { "<cmd>Telescope diagnostics<cr>", "Open diagnostic picker" },
			["<leader>f"] = { "<cmd>Telescope find_files<cr>", "Open file picker" },
			["<leader>h"] = { "<cmd>Telescope help_tags<cr>", "Open help picker" },
			["<leader>i"] = { "<cmd>Telescope live_grep<cr>", "Open live grep" },
			["<leader>o"] = { "<cmd>Telescope oldfiles<cr>", "Open file picker at oldfiles" },
			["<leader>q"] = { "<cmd>Telescope quickfix<cr>", "Open quickfix picker" },
			["<leader>s"] = { "<cmd>Telescope treesitter<cr>", "Open symbol picker" },
		})
	end,
}
