return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" }, -- Roslyn is usually managed separately or via Crashdummyy registry
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            -- Setup Lua
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } }, -- Stops the "undefined global 'vim'" warning
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- Setup Roslyn
            -- Note: If you are using the 'seblj/roslyn.nvim' plugin, you usually don't setup it here.
            -- But for standard lspconfig usage:
        end,
    },
}
