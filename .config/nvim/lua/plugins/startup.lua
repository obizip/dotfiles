return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local alpha = require 'alpha'
    local theta = require 'alpha.themes.theta'
    local dashboard = require("alpha.themes.dashboard")
    local header = theta.header
    local section_mru = theta.section_mru
    local buttons = {
      type = "group",
      val = {
        { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("e", "  New file", "<cmd>ene<CR>"),
        dashboard.button("SPC f", "  Find file"),
        dashboard.button("SPC i", "  Live grep"),
        dashboard.button("SPC c", "  Configuration"),
        dashboard.button("l", "  Open Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "  Open Mason", "<cmd>Mason<CR>"),
        dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
      },
      position = "center",
    }

    theta.config.layout = {
      { type = "padding", val = 2 },
      header,
      { type = "padding", val = 2 },
      section_mru,
      { type = "padding", val = 2 },
      buttons,
    }

    alpha.setup(theta.config)
  end,
}
