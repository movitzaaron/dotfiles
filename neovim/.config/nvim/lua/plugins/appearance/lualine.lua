return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        -- Load your custom Kanagawa lualine theme
        local kanagawa_lualine = require('plugins.appearance.themes.kanagawa-lualine') -- adjust if saved in a subfolder

        require('lualine').setup({
            options = {
                theme = kanagawa_lualine, -- pass the theme table here
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            },
        })
    end

    -- Catpuccin
    -- opts = {
    --     function(_, opts)
    --         local trouble = require("trouble")
    --         local symbols = trouble.statusline({
    --             mode = "lsp_document_symbols",
    --             groups = {},
    --             title = false,
    --             filter = { range = true },
    --             format = "{kind_icon}{symbol.name:Normal}",
    --         })
    --         table.insert(opts.sections.lualine_c, {
    --             symbols.get,
    --             cond = symbols.has,
    --         })
    --     end,
    --     sections = {
    --         lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    --         lualine_b = { 'filename', 'branch' },
    --         lualine_c = {
    --             '%=', --[[ add your center compoentnts here in place of this comment ]]
    --         },
    --         lualine_x = {},
    --         lualine_y = { 'filetype', 'progress' },
    --         lualine_z = {
    --             { 'location', separator = { right = '' }, left_padding = 2 },
    --         },
    --     },
    --     inactive_sections = {
    --         lualine_a = { 'filename' },
    --         lualine_b = {},
    --         lualine_c = {},
    --         lualine_x = {},
    --         lualine_y = {},
    --         lualine_z = { 'location' },
    --     },
    --     tabline = {},
    --     extensions = {},
    -- }
}
