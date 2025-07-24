local Path = require('plenary.path')

local home_path = Path:new("/Users/movitz/projects/leetcode")

if not home_path:exists() then
    home_path:mkdir({ parents = true })
end


return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        storage = {
            home = home_path.filename,
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
        arg = "leet",
        lang = "python3",
        description = {
            position = "right",
        }
    },
}
