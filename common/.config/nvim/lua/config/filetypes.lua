vim.filetype.add({
  extension = {
    vto = "vento",
  },
})

local ft_indent = {
  c = 2,
  cpp = 2,
  lua = 2,
  javascript = 2,
  typescript = 2,
  javascriptreact = 2,
  typescriptreact = 2,
}

for ft, indent in pairs(ft_indent) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { ft },
    callback = function()
      vim.o.tabstop = indent -- only set tabstop
      vim.o.shiftwidth = 0 -- tabstopに従う
      vim.o.softtabstop = -1 -- shiftwidthに従う
      vim.opt_local.expandtab = true
    end,
  })
end
