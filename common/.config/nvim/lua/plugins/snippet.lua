return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "*",
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
    -- load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
