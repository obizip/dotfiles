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

if vim.fn.executable('tectonic') then
  local pdf_cmd = ""
  local pdf_args = {}
  if vim.loop.os_uname().sysname == "Darwin" then
    pdf_cmd = "displayline"
    pdf_args = { "%l", "%p", "%f" }
  else
    pdf_cmd = "zathura"
    pdf_args = { "--synctex-forward", "%l:0:%f", "%p" }
  end

  local lspconfig = require("lspconfig")
  lspconfig.texlab.setup({
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = "tectonic",
          args = { "-X", "compile", "--synctex", "%f", "--keep-logs", "--keep-intermediates" },
          onSave = true,
          forwardSearchAfter = false,
        },
        auxDirectory = ".",
        forwardSearch = {
          executable = pdf_cmd,
          args = pdf_args,
        },
        chktex = {
          onOpenAndSave = false,
          onEdit = false,
        },
        -- diagnosticsDelay = 300,
        diagnosticsDelay = 100,
        latexFormatter = "latexindent",
        latexindent = {
          ["local"] = nil, -- local is a reserved keyword
          modifyLineBreaks = false,
        },
        bibtexFormatter = "texlab",
        formatterLineLength = 80,
      },
    },
  })
end
