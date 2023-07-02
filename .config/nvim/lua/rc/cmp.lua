local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "dmitmel/cmp-cmdline-history",
    "ray-x/cmp-treesitter",
    "onsails/lspkind.nvim",
    "kdheepak/cmp-latex-symbols",
    "windwp/nvim-autopairs",
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require('luasnip')
  local lspkind = require("lspkind")
  -- For `luasnip` users.
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    preselect = require('cmp').PreselectMode.None,
    -- disable completion in comments
    -- enabled = function()
    --   local context = require("cmp.config.context")
    --   local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    --   -- keep command mode completion enabled when cursor is in a comment
    --   if vim.api.nvim_get_mode().mode == "c" then
    --     return true
    --   else
    --     return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment") and
    --         not (buftype == "prompt")
    --   end
    -- end,
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- ["<C-f>"] = cmp.mapping.scroll_docs( -4),
      -- ["<C-b>"] = cmp.mapping.scroll_docs(4),

      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s", "c" }),

      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s", "c" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end, { "i", "s", "c" }
      ),
    }),
    sources = cmp.config.sources({
      { name = "luasnip" },
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, ctx)
          return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
        end
      },
      { name = "nvim_lsp_signature_help" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" },
      { name = "treesitter" },
      { name = "kdheepak/cmp-latex-symbols" },
    }),
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",       -- show only symbol annotations
        maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      }),
    },
  })

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })

  -- Insert '(' after select function or method
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
