local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
    -- "dmitmel/cmp-cmdline-history",
    -- "f3fora/cmp-spell",
    -- "ray-x/cmp-treesitter",
    "onsails/lspkind.nvim",
    -- "kdheepak/cmp-latex-symbols",
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind") -- For `luasnip` users.
  -- local has_words_before = function()
  --     unpack = unpack or table.unpack
  --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  -- end
  -- local t = function(str)
  --     return vim.api.nvim_replace_termcodes(str, true, true, true)
  -- end

  cmp.setup({
    preselect = require("cmp").PreselectMode.None,
    -- performance = {
    --   max_view_entries = 3,
    -- },
    -- disable completion in comments
    enabled = function()
      local context = require("cmp.config.context")
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
          and not (buftype == "prompt")
      end
    end,
    completion = {
      -- autocomplete = false,
      completeopt = "menu,menuone,noinsert,noselect",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      -- ["<C-f>"] = cmp.mapping.scroll_docs( -4),
      -- ["<C-b>"] = cmp.mapping.scroll_docs(4),
      -- ["<C-x><C-o>"] = cmp.mapping({
      --     i = function(fallback)
      --         cmp.complete()
      --     end
      --
      -- }),

      ["<C-n>"] = cmp.mapping({
        -- inoremap <C-x><C-o> <Cmd>lua require('cmp').complete()<CR>
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),

      ["<C-p>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end,
      }),

      ["<C-j>"] = cmp.mapping({
        i = function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
      }),

      ["<C-k>"] = cmp.mapping({
        i = function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
      }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          -- elseif has_words_before() then
          --     cmp.complete()
        else
          fallback()
        end
      end, { "i", "s", "c" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end, { "i", "s", "c" }),

      ["<C-c>"] = cmp.mapping.abort(),

      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end, { "i", "s", "c" }),
    },
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" },
      -- { name = "treesitter" },
      -- { name = "kdheepak/cmp-latex-symbols" },
      -- { name = "spell" },
    }),
    -- experimental = {
    --   ghost_text = {
    --     hl_group = "LspCodeLens",
    --   },
    -- },
    formatting = {
      format = lspkind.cmp_format({
        mode = "text", -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      }),
    },
  })

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ "/", "?" }, {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })

  -- Insert '(' after select function or method
  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  -- For crates.nvim
  -- vim.api.nvim_create_autocmd("BufRead", {
  --   group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  --   pattern = "Cargo.toml",
  --   callback = function()
  --     cmp.setup.buffer({ sources = { { name = "crates" } } })
  --   end,
  -- })
end

return M
