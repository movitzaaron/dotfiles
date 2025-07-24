return {
    {
        "mfussenegger/nvim-dap",

    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dapui = require('dapui')

            dapui.setup()
        end
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {
            modes = {
                cascade = {
                    mode = "diagnostics",     -- inherit from diagnostics mode
                    filter = function(items)
                        local severity = vim.diagnostic.severity.HINT
                        for _, item in ipairs(items) do
                            severity = math.min(severity, item.severity)
                        end
                        return vim.tbl_filter(function(item)
                            return item.severity == severity
                        end, items)
                    end,
                },
            },
        },
    },
}
