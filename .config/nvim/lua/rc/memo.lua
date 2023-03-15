return {
  "glidenote/memolist.vim",
  keys = {
    { "<leader>mn", "<cmd>MemoNew<cr>", desc = "Create a new memo" },
    { "<leader>ml", "<cmd>Telescope memo list<cr>", desc = "List all memos" },
    { "<leader>mg", "<cmd>Telescope memo live_grep<cr>", desc = "Grep all memos" },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'delphinus/telescope-memo.nvim',
  },
  config = function ()
    vim.g.memolist_path = os.getenv("DROPBOXDIR") .. "/memo"
    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_fzf = 1
    vim.g.memolist_template_dir_path = os.getenv("DROPBOXDIR") .. "/memo/.template"

    require'telescope'.load_extension'memo'
  end,

}
