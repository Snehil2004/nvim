--if we use custom file for everything use require('file name')
--set the leader key to space to execute the command followed by leader key
vim.cmd("let mapleader = ' '")

require("preferences")
require("keymaps")
-- Step 1: this is installation setup for lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Step 2: Configure Lazy.nvim to manage plugins
 require("lazy").setup({
	ui = {
		border = "double",
	},

	spec = {
		{ import = "plugins" }, -- Ensure this file exists
	},
})

-- Adding the colorschemee ( if you want to change the theme just change the name e.g. default,nord,catppuccin,retrobox
vim.cmd("colorscheme rose-pine-moon")
vim.o.cmdheight = 0
vim.o.wrap = false
vim.opt.guicursor = "" -- this is betterrrrrrr;
--kai matlab hai o
