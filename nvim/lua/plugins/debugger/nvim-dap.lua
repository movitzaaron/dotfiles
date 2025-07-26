return{ 
    {
      "mfussenegger/nvim-dap",
        config = function()
    local dap = require("dap")

    -- Adapter configuration
    dap.adapters.python = {
      type = "executable",
      command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
      args = { "-m", "debugpy.adapter" },
    }

    -- Debug launch configuration
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- Run the current file
        pythonPath = function()
          return os.getenv("HOME") .. "/.virtualenvs/tools/bin/python"
        end,
      },
    }
  end,
    },

    {
      "rcarriga/nvim-dap-ui",
      dependencies = { 
          "mfussenegger/nvim-dap",
          "nvim-neotest/nvim-nio",
      },
      config = function()
        require("dapui").setup()
      end,
    }
}
