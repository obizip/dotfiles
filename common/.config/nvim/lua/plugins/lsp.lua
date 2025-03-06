return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewfile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
            { virtual_text = false, signs = true, underline = false })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local utils = require("utils")
      local nnoremap = utils.nnoremap
      nnoremap("K", vim.lsp.buf.hover)
      nnoremap("gr", vim.lsp.buf.references)
      nnoremap("gd", vim.lsp.buf.definition)
      nnoremap("gD", vim.lsp.buf.declaration)
      nnoremap("gi", vim.lsp.buf.implementation)
      nnoremap("gK", vim.lsp.buf.signature_help)
      nnoremap("gt", vim.lsp.buf.type_definition)
      nnoremap("ga", vim.lsp.buf.code_action)
      nnoremap("ge", vim.diagnostic.open_float)
      nnoremap("g[", vim.diagnostic.goto_prev)
      nnoremap("g]", vim.diagnostic.goto_next)
      -- nnoremap("gf", vim.lsp.buf.format)
      nnoremap("gn", vim.lsp.buf.rename)
      nnoremap("<leader>r", vim.lsp.buf.rename)

      local lspconfig = require("lspconfig")

      lspconfig["gopls"].setup({
        capabilities = capabilities,
      })

      lspconfig["rust_analyzer"].setup({
        capabilities = capabilities,
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if server_name == "lua_ls" then
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  format = {
                    enable = true,
                    defaultConfig = {
                      indent_style = "space",
                      indent_size = "2",
                    },
                  },
                },
              },
            })
          else
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end
        end,
      })
    end,
  },
}
