-- local opts = { noremap = true, silent = true }
local nm = { noremap = true }

-- Normal mode --
vim.keymap.set("n", "j", "gj", nm)
vim.keymap.set("n", "k", "gk", nm)
vim.keymap.set("n", "p", "p==", nm)
vim.keymap.set("n", "P", "P==", nm)
vim.keymap.set("n", "n", "nzzzv", nm)
vim.keymap.set("n", "N", "Nzzzv", nm)
vim.keymap.set("n", "H", "^", nm)
vim.keymap.set("n", "L", "$", nm)
vim.keymap.set("n", "Q", "<nop>", nm)
vim.keymap.set("n", "+", "<C-a>", nm)
vim.keymap.set("n", "-", "<C-x>", nm)
vim.keymap.set("n", "<C-a>", "ggVG", nm)
vim.keymap.set("n", "<C-x>", "<Nop>", nm) -- tmux leader key
vim.keymap.set("n", "<Esc><Esc>", ":noh<Cr>", nm)
vim.keymap.set("n", "<C-s>", ":wall<Cr>", nm)
vim.keymap.set("n", "<C-c>", "<ESC>", nm)
vim.keymap.set("n", "<C-f>", "<C-d>", nm)
vim.keymap.set("n", "<C-b>", "<C-u>", nm)

-- vim.keymap.set("n", "<C-h>", ":bp<Cr>", nm)
-- vim.keymap.set("n", "<C-l>", ":bn<Cr>", nm)
vim.keymap.set("n", "<C-d>", ":bwipe<Cr>", nm)

vim.api.nvim_create_user_command("Numbertoggle", function()
  vim.wo.number = not vim.wo.number
end, {})
vim.keymap.set("n", "<C-n>", ":<C-u>Numbertoggle<cr>", nm)

-- local wk = require("which-key")
-- wk.register({
--   -- ["<leader>c"] = { ":e $MYVIMRC<Cr>", "Open init.lua" },
--   ["<leader>2"] = { ":set tabstop=2<Cr>", "Set tab to 2 spaces" },
--   ["<leader>4"] = { ":set tabstop=4<Cr>", "Set tab to 4 spaces" },
--   ["<leader>z"] = { ":Zen<Cr>", "Start ZenMode" },
-- })

-- Insert mode --
-- vim.keymap.set("i", "<C-k>", "<C-o>D", nm) -- カーソルから右を全て削除
vim.keymap.set("i", "<C-j>", "", nm)
vim.keymap.set("i", "<C-y>", "<esc>p==a", nm) -- paste
vim.keymap.set("i", "<C-c>", "<ESC>", nm)
vim.keymap.set("i", "<C-b>", "<left>", nm)
vim.keymap.set("i", "<C-f>", "<right>", nm)
vim.keymap.set("i", "<C-n>", "<down>", nm)
vim.keymap.set("i", "<C-p>", "<up>", nm)
vim.keymap.set("i", "<C-a>", "<home>", nm)
vim.keymap.set("i", "<C-e>", "<end>", nm)

-- Insert today date
vim.api.nvim_create_user_command("Today", function()
  local time = vim.fn.strftime("%Y年%m月%d日")
  vim.cmd(":normal a" .. time)
end, {})
vim.keymap.set("i", "<C-s>", "<C-o>:Today<cr>", nm)

-- Visual mode --
vim.keymap.set("v", "j", "gj", nm)
vim.keymap.set("v", "k", "gk", nm)
vim.keymap.set("v", "+", "<C-a>", nm)
vim.keymap.set("v", "-", "<C-x>", nm)

-- Command mode --
vim.keymap.set("c", "<C-n>", "<down>", nm)
vim.keymap.set("c", "<C-p>", "<up>", nm)
vim.keymap.set("c", "<C-b>", "<left>", nm)
vim.keymap.set("c", "<C-f>", "<right>", nm)
vim.keymap.set("c", "<C-a>", "<home>", nm)
vim.keymap.set("c", "<C-e>", "<end>", nm)

-- Terminal mode --
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", nm)
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:bp<Cr>", nm)
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-n>:bn<Cr>", nm)
