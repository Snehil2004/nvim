-- Neo-tree keymaps are defined in plugins/neo-tree.lua

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>th", ":Telescope colorscheme<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>fw", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true })
vim.keymap.set("n", "<Leader>cb", ":Telescope buffers<CR>", { silent = true })

-- Window management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true })

-- Window navigation handled by vim-tmux-navigator plugin

-- Git
vim.keymap.set("n", "<Leader>gs", ":DiffviewOpen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>q", ":DiffviewClose<CR>", { noremap = true, silent = true })

-- Database
vim.keymap.set("n", "<Leader>dc", ":DBUIToggle<CR>", { silent = true })

-- Diagnostics
vim.keymap.set("n", "Z", vim.diagnostic.open_float, { silent = true, desc = "Open diagnostic float" })

-- LSP keymaps (set only when an LSP client attaches to a buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP keybindings",
	group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
		vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
		vim.keymap.set("n", "<leader>ft", function()
			-- Use conform if available, fallback to LSP formatting
			local ok, conform = pcall(require, "conform")
			if ok then
				conform.format({ async = true, lsp_fallback = true })
			else
				vim.lsp.buf.format({ async = true })
			end
		end, vim.tbl_extend("force", opts, { desc = "Format file" }))
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	end,
})
