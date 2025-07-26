return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })

      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Use mason-lspconfig's setup_handlers for dynamic server config
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },
}

