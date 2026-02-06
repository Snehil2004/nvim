-- this is for showing line number 
vim.cmd("set number")
--this is for showing relative line numbers turn off if you dont want it 
vim.cmd("set relativenumber")
vim.cmd("set noexpandtab")
-- if you want more space just increase the number 
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.swapfile = true
vim.o.mouse = ""
vim.opt.termguicolors = true
vim.keymap.set('n','<leader><leader>x',':sourece % ,<CR>')
vim.api.nvim_create_autocmd('TextYankPost',{
	desc = 'Highlight when copying text',
	group = vim.api.nvim_create_augroup('highlighting-yank',{clear = true}),
	callback = function ()
		vim.highlight.on_yank()
	end
}) 
