return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local neodev = require("neodev")

        neodev.setup()

        mason.setup()

        mason_lspconfig.setup({
            ensure_installed = { "lua_ls", "pyright" },
            automatic_installation = true,
        })

        -- Manually configure Lua language server with custom settings
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim", "require" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        -- Manually configure Python LSP (pyright)
        lspconfig.pyright.setup({})

        -- Add other servers here as needed
    end,
}
