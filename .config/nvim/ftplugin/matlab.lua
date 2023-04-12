vim.bo.tabstop = 2

vim.api.nvim_create_user_command("Run", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("cd " .. vim.fn.expand("%:p:h"))
  vim.cmd("!octave " .. vim.fn.expand('%:p'))
  vim.cmd("cd " .. cwd)
end, {})
