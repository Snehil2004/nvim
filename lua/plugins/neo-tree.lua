return {
 --[[  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added     = "✚",
              deleted   = "✖",
              modified  = "󰰑 ",
              renamed   = "󰁕",
              -- Status type
              untracked = "󰦱 ",
              ignored   = "◌",
              unstaged  = "✗",
              staged    = "",
              conflict  = "",
            },
          },
        },
      })

      require("nvim-web-devicons").setup({
        override_by_extension = {
          css = {
            icon = "",         -- Stylish icon for CSS
            color = "#61afef",  -- electric blue
            cterm_color = "67", -- Approximate cterm version
            name = "css",
          },
        },
      })
    end,
  }, ]]
}

