return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
{
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "cpp","vim", "python", "c_sharp", "javascript", "html","typescript", "json", "css","tsx", "bash","http","sql"};
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			}
		)
	end,
  {
    "windwp/nvim-ts-autotag", -- For auto-closing HTML/JSX tags
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}


