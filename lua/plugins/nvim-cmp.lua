return {
  -- LSP source for nvim-cmp
  { "hrsh7th/cmp-nvim-lsp" },

  -- Snippet engine + sources
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- nvim-cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),   -- scroll docs up
          ["<C-d>"] = cmp.mapping.scroll_docs(4),    -- scroll docs down
          ["<C-S>"] = cmp.mapping.complete(),        -- trigger completion
          ["<C-e>"] = cmp.mapping.abort(),           -- cancel completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm selection
          }),        
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Mason setup
      mason.setup()
      mason_lspconfig.setup({ automatic_installation = true })

      -- Auto-attach all installed LSPs
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = function(client, bufnr)
              client.server_capabilities.semanticTokensProvider = nil
              local buf_map = function(mode, lhs, rhs)
                vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
              end

              buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
              buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
              buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
              buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
              buf_map("n", "<leader>c", "<cmd>lua vim.lsp.buf.clear_references()<CR>",
                { noremap = true, silent = true }
              )
            end,
          })
        end,
      })
    end,
  },

  -- Mason plugins
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
}
