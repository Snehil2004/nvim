
return {
    -- Mason and Lspconfig
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local on_attach = function(client, bufnr)
                -- Add your keymaps here, or ensure your keymaps.lua file
                -- is loaded after this one.
            end

            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "eslint",
                    "html",
                    "cssls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "ruff",
                    "clangd",
                    "marksman",
                    "emmet_language_server",
                },
                handlers = {
                    -- This is the key part that handles all servers
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            -- Add any server-specific settings here
                        })
                    end,

                    -- You can use custom handlers for specific servers if needed
                    emmet_language_server = function()
                        require("lspconfig").emmet_language_server.setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            filetypes = {
                                "html",
                                "css",
                                "scss",
                                "javascriptreact",
                                "typescriptreact",
                                "vue",
                                "svelte",
                            },
                        })
                    end,

                    -- Or for servers with special configurations
								require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
				end,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})


               },
            })
        end,
    },
}
