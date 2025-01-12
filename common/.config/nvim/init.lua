-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

require("config.options")
require("config.filetypes")
require("config.keymaps")
require("config.commands")
require("config.lazy")

-- vim.cmd("colorscheme yozakura")
vim.cmd("colorscheme cyber")
