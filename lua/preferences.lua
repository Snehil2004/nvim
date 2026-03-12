-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation (tabs, width 4)
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- General
vim.opt.swapfile = true
vim.o.mouse = ""
vim.opt.termguicolors = true

-- Source current file
vim.keymap.set("n", "<leader><leader>x", ":source %<CR>", { desc = "Source current file" })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when copying text",
	group = vim.api.nvim_create_augroup("highlighting-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
