return {
  "fatih/vim-go",
  ft = { "go" },
  event = "BufReadPre",
  config = function()
    vim.g.go_def_mapping_enabled = 1
    vim.g.go_metalinter_autosave = 0
    vim.g.go_doc_keywordprg_enabled = 0
  end,
}
