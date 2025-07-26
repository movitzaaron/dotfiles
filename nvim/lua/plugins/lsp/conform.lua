return
    -- Formatter
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = { "stylelua" },
                python = { "black", "isort" },
                -- yaml = { "yamlfmt" },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        },
   }
