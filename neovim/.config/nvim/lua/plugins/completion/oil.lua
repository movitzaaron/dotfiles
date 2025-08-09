return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        use_default_keymaps = false,
        keymaps = {
            ["<CR>"] = "actions.select",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-s>"] = "actions.select_split",
            ["<Esc>"] = "actions.close",
        },
        view_options = {
            show_hidden = true,
        },
        float = {
            padding = 5,
        },
    },
}
