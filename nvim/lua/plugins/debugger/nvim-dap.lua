return
    -- In your plugins list (core/plugins.lua or similar)
    {
      "mfussenegger/nvim-dap",
      config = function()
        -- Optional dap setup code if any
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap" },
      config = function()
        require("dapui").setup()
      end,
    }
