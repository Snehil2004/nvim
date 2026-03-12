return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function()
				-- Load VS Code style snippets (friendly-snippets)
				require("luasnip.loaders.from_vscode").lazy_load()
				-- Load custom Lua snippets (e.g., C++ competitive programming boilerplate)
				require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
			end,
		},

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },

			keymap = {
				preset = "none",
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-Space>"] = { "show", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
				list = {
					selection = { preselect = true, auto_insert = false },
				},
			},

			signature = {
				enabled = true,
				window = { border = "rounded" },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "dadbod", "buffer", "path" },
					mysql = { "dadbod", "buffer", "path" },
					plsql = { "dadbod", "buffer", "path" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},

			cmdline = {
				enabled = true,
			},

			appearance = {
				nerd_font_variant = "mono",
			},
		},
	},
}
