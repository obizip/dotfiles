local utils = require("utils")
local inoremap = utils.inoremap
local cnoremap = utils.cnoremap
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap

-- emacs style
inoremap("<C-b>", "<left>")
inoremap("<C-f>", "<right>")
inoremap("<C-a>", "<C-o>^")
inoremap("<C-e>", "<end>")
inoremap("<C-y>", "<C-r>+") -- paste

nnoremap("<leader>k", function()
  vim.cmd("edit ~/.config/nvim/keymap.txt")
end)

cnoremap("<C-b>", "<left>")
cnoremap("<C-f>", "<right>")
cnoremap("<C-a>", "<home>")
cnoremap("<C-e>", "<end>")
cnoremap("<C-y>", "<C-r>+") -- paste
cnoremap("<C-x>", "<C-f>")  -- open cmdwin

nnoremap("Q", "<nop>")
nnoremap("<C-h>", ":bp<cr>")
nnoremap("<C-l>", ":bn<cr>")
nnoremap("<C-q>", ":bwipe<cr>")
nnoremap("<Esc><Esc>", ":noh<cr>")
nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("gj", "j")
nnoremap("gk", "k")
nnoremap("Y", "y$")

vnoremap("j", "gj")
vnoremap("k", "gk")
vnoremap("gj", "j")
vnoremap("gk", "k")

local function insert_today()
  local today = os.date("%Y-%m-%d")
  local current_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { current_pos[1], current_pos[2] + 1 })
  vim.api.nvim_put({ today }, "", true, true)
end

vim.api.nvim_create_user_command("Today", function()
  insert_today()
end, {})

-- vim.api.nvim_create_user_command("Numbertoggle", function()
--     vim.wo.number = not vim.wo.number
-- end, {})
-- nnoremap("<C-n>", ":<C-u>Numbertoggle<cr>")

vim.keymap.set("i", "<C-l>", function()
  local line = vim.fn.getline(".")
  local col = vim.fn.getpos(".")[3]
  local substring = line:sub(1, col - 1)
  local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
  return "<C-w>" .. result:upper()
end, { expr = true })
