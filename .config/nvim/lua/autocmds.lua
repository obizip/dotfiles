vim.api.nvim_create_autocmd({ "BufEnter"}, {
  callback = function()
    vim.cmd("stopinsert")
  end,
})
