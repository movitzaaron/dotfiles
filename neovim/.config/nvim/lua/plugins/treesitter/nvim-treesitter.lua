return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "python",
                "rust",
                "java",
                "cpp",
                "css",
                "http",
            },
        })
    end
}
