-- Quick Fix: Hybrid approach that ensures TypeScript works
return {
--[[  	{
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
			-- Enhanced capabilities
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

			-- Modern diagnostic configuration
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Common on_attach function
			local on_attach = function(client, bufnr)
				-- Modern LSP keymaps
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		end

			-- Install servers via Mason
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
			})

			-- DIRECT lspconfig setup (bypassing mason-lspconfig handlers to avoid conflicts)

			-- TypeScript - DIRECT SETUP
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

			-- ESLint
			require("lspconfig").eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			-- Lua
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})

			-- Python
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pyright = { disableOrganizeImports = true },
					python = { analysis = { ignore = { "*" } } },
				},
			})

			require("lspconfig").ruff.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					client.server_capabilities.hoverProvider = false
				end,
			})

			-- C/C++
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Web Development
			require("lspconfig").html.setup({ capabilities = capabilities, on_attach = on_attach })
			require("lspconfig").cssls.setup({ capabilities = capabilities, on_attach = on_attach })
			require("lspconfig").jsonls.setup({ capabilities = capabilities, on_attach = on_attach })

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

			-- Markdown
			require("lspconfig").marksman.setup({ capabilities = capabilities, on_attach = on_attach })

end,
	}, ]]
}
