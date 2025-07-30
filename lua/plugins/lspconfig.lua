-- Updated for Neovim 0.11+ with proper vim.lsp.config usage and mason integration

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- Register all configurations before attaching
      vim.lsp.config("clangd", {
        on_attach = function(client, bufnr)
          -- client.server_capabilities.documentFormattingProvider = false
          -- client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("cssls", { capabilities = capabilities })
      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("marksman", { capabilities = capabilities })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          pyright = { disableOrganizeImports = true },
          python = { analysis = { ignore = { "*" } } },
        },
      })

      vim.lsp.config("ruff", {
        capabilities = capabilities,
        filetypes = { "python" },
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
        end,
      })

      vim.lsp.config("emmet_language_server", {
        filetypes = {
          "html", "css", "scss", "javascriptreact", "typescriptreact",
          "vue", "svelte", "xml", "pug"
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      })

      vim.lsp.config("eslint", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- You can add eslint-specific on_attach logic here
        end,
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable semantic tokens if needed
          -- client.server_capabilities.semanticTokensProvider = nil
        end,
        flags = {
          debounce_text_changes = 150,
        },
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Setup mason-lspconfig to apply handlers for installed servers
      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },
}

