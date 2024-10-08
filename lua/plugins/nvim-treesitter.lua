return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "cpp","vim", "python", "c_sharp", "javascript", "html","typescript", "json", "css","tsx", "bash"};
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
