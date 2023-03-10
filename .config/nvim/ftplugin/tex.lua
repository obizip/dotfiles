-- 読点、句読点を置き換え
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.tex",
  callback = function()
    vim.api.nvim_exec("silent! %s/、/, /g", false)
    vim.api.nvim_exec("silent! %s/。/. /g", false)
    vim.api.nvim_exec(string.format("silent! %s", [[%s/\\\@<!\s\+$//]]), false)
  end,
})

-- requirements
-- compiler:
--  tectonic
-- pdf viewer
--  mac: skim
--  wsl: zathura
