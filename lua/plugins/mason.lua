return {
  {
    "williamboman/mason.nvim",
    version = "v1.*",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.*",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    tag = "v0.1.7",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
      
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")  -- ✅ add this
      local capabilities = cmp_nvim_lsp.default_capabilities() -- ✅ and this
      lspconfig.fsautocomplete.setup{
        cmd = {"fsautocomplete"},   -- FSAC executable
        filetypes = {"fsharp", "fsi", "fsx"},  -- F# files
        root_dir = lspconfig.util.root_pattern("*.fsproj", "*.sln"),  -- auto-detect project
        settings = {
          FSharp = {
            AutomaticWorkspaceInit = true,  -- detect fsproj automatically
            SemanticTokens = false,
            UseSdkScripts = true,           -- allows scripts to work
            ScriptFilesEnabled = true,
          }
        },
      }
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      vim.o.updatetime = 250

      vim.diagnostic.config({
        virtual_text = false,  -- Disable inline virtual text
        float = {
          border = "rounded",  -- Adds a rounded border to the floating window
          focusable = false,
          source = "always",   -- Show the source of the diagnostic message
          header = "",         -- Removes "Diagnostics" header
          prefix = "",         -- Removes bullet point prefix
        },
        signs = true,  -- Keep signs in the gutter
        update_in_insert = false, -- Don't show diagnostics while typing
      })

    end,
  },
}
