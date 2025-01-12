local M = {}

function M.inoremap(lhs, rhs)
  vim.keymap.set({ "i" }, lhs, rhs, { noremap = true })
end

function M.nnoremap(lhs, rhs)
  vim.keymap.set({ "n" }, lhs, rhs, { noremap = true })
end

function M.cnoremap(lhs, rhs)
  vim.keymap.set({ "c" }, lhs, rhs, { noremap = true })
end

function M.vnoremap(lhs, rhs)
  vim.keymap.set({ "v" }, lhs, rhs, { noremap = true })
end

return M
