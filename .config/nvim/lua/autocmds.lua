vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd("stopinsert")
  end,
})
vim.cmd([[
augroup restore-ime
  autocmd!
  autocmd InsertEnter * silent call chansend(v:stderr, "\e[<r")
  autocmd InsertLeave * silent call chansend(v:stderr, "\e[<s\e[<0t")
  autocmd VimLeave * silent call chansend(v:stderr, "\e[<0t\e[<s")
augroup END
]])
