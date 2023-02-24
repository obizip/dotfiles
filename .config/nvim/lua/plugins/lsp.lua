return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/which-key.nvim",
      { "folke/lsp-colors.nvim",
        config = function()
          require("lsp-colors").setup({
            Error = "#db4b4b",
            Warning = "#e0af68",
            Information = "#0db9d7",
            Hint = "#10B981"
          })
        end },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local null_ls = require("null-ls")

          null_ls.setup({
            sources = {
              null_ls.builtins.diagnostics.eslint,
            },
          })
        end,
      },
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("fidget").setup()

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)

      local wk = require("which-key")
      wk.register({
        ["<leader>a"] = { vim.lsp.buf.format, "Format" },
        ["<leader>r"] = { vim.lsp.buf.rename, "Rename" },
        ["<leader>j"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
        ["<leader>k"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })

      -- requirements
      -- compiler:
      --  tectonic
      -- pdf viewer
      --  mac: skim
      --  wsl: zathura

      if not vim.fn.executable('tectonic') then
        local pdf_cmd = ""
        local pdf_args = {}
        if vim.loop.os_uname().sysname == "Darwin" then
          pdf_cmd = "displayline"
          pdf_args = { "%l", "%p", "%f" }
        else
          pdf_cmd = "zathura"
          pdf_args = { "--synctex-forward", "%l:0:%f", "%p" }
        end

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
    end,
  },
}
