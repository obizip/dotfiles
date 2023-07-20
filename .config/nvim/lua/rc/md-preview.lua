return {
  {
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   ft = "markdown",
    --   build = ":call mkdp#util#install()",
    --   -- install manually :call mkpd#util#install()
    -- },
    {
      'toppair/peek.nvim',
      build = 'deno task --quiet build:fast',
      ft = "markdown",
      keys = {
        {
          "<leader>p",
          function()
            local peek = require("peek")
            if peek.is_open() then
              peek.close()
            else
              peek.open()
            end
          end,
          desc = "Markdown Preview"
        },
      },
      opts = {
        app = 'browser',
        theme = "dark",
      }
    }
  },
}
