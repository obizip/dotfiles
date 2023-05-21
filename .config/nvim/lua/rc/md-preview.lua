return {
  {
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = ":call mkdp#util#install()",
      -- install manually :call mkpd#util#install()
    },
  },
}
