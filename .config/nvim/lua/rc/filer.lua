return {
  "tamago324/lir.nvim",
  keys = { {
    "<leader>e",
    function()
      require('lir.float').init()
    end,
    desc = "Open filer"
  } },
  dependencies = {
    "folke/which-key.nvim",
  },
  config = function()

    local actions = require("lir.actions")
    local mark_actions = require("lir.mark.actions")
    local clipboard_actions = require("lir.clipboard.actions")
    local wk = require("which-key")
    wk.register({
      ["<leader>e"] = { require'lir.float'.init, "Open filer"}
    })
    require("lir").setup({
      show_hidden_files = true,
      ignore = {".DS_Store", "node_modules"},
      devicons = {
        enable = false,
        highlight_dirname = false,
      },
      mappings = {
        ["l"] = actions.edit,
        ["<C-s>"] = actions.split,
        ["<C-v>"] = actions.vsplit,
        ["<C-t>"] = actions.edit,

        ["h"] = actions.up,
        ["q"] = actions.quit,

        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["@"] = actions.cd,
        ["Y"] = actions.yank_path,
        ["."] = actions.toggle_show_hidden,
        ["D"] = actions.delete,

        ["J"] = function()
          mark_actions.toggle_mark()
          vim.cmd("normal! j")
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste,
      },
      float = {
        winblend = 0,
        curdir_window = {
          enable = true,
          highlight_dirname = true,
        },
      },
      hide_cursor = true,
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "lir" },
      callback = function()
        -- use visual mode
        vim.api.nvim_buf_set_keymap(
          0,
          "x",
          "J",
          ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
          { noremap = true, silent = true }
        )

        -- echo cwd
        vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
      end,
    })

  end,
}
