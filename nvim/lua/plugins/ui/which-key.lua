return {
  "folke/which-key.nvim",
  lazy = false,  -- load immediately on startup
    dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui", -- if you use this too
  },
  config = function()
    local wk = require("which-key")

    wk.setup({})

    local harpoon = require("harpoon")
    local conform = require("conform")
    local telescope = require("telescope.builtin")
    local dap = require("dap")
    local dap_widgets = require("dap.ui.widgets")

    -- Harpoon setup
    harpoon.setup()

    -- Diagnostic Toggle Function
    vim.g["diagnostics_active"] = true
    local function Toggle_diagnostics()
      if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.disable()
      else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable()
      end
    end

    wk.register({
      -- Groups
      ["<leader>f"] = { name = "file" },
      ["<leader>w"] = { name = "windows" },
      ["<leader>b"] = { name = "buffers" },

      -- Clipboard
      ["<leader>y"] = { '"+y', "Copy to clipboard", mode = { "n", "v" } },
      ["<leader>p"] = { '"+p', "Paste from clipboard", mode = { "n", "v" } },

      -- Window movements
      ["<C-c>"] = { "<C-w>c", "Close window" },
      ["<lt>"] = { "<C-w><lt>", "Decrease current window width" },
      [">"] = { "<C-w>>", "Increase current window width" },
      ["-"] = { "<C-w>-", "Decrease current window height" },
      ["+"] = { "<C-w>+", "Increase current window height" },

      -- Oil
      ["-"] = { ":lua require('oil').open()<CR>", "Open Oil" },
      ["<Leader>o"] = { ":lua require('oil').open_float()<CR>", "Open Oil in floating window" },

      -- Harpoon
      ["<leader>a"] = { function() harpoon.list:add() end, "Add file to Harpoon list" },
      ["<leader>A"] = { function() harpoon.ui.toggle_quick_menu(harpoon.list) end, "Toggle Harpoon menu" },
      ["<leader>1"] = { function() harpoon.list:select(1) end, "Switch to Harpoon buffer 1" },
      ["<leader>2"] = { function() harpoon.list:select(2) end, "Switch to Harpoon buffer 2" },
      ["<leader>3"] = { function() harpoon.list:select(3) end, "Switch to Harpoon buffer 3" },
      ["<leader>4"] = { function() harpoon.list:select(4) end, "Switch to Harpoon buffer 4" },

      -- Formatter
      ["<leader>fm"] = { function() conform.format({ lsp_fallback = true, timeout_ms = 500 }) end, "Format File" },

      -- LSP
      ["<leader>xd"] = { Toggle_diagnostics, "Toggle Vim Diagnostics" },
      ["gD"] = { vim.lsp.buf.declaration, "Go to Declaration" },
      ["gd"] = { vim.lsp.buf.definition, "Go to Definition" },
      ["K"] = { vim.lsp.buf.hover, "Show Info About Symbol" },
      ["gi"] = { vim.lsp.buf.implementation, "Go to Implementation" },
      ["<C-i>"] = { vim.lsp.buf.signature_help, "Show Signature Help" },
      ["<space>wa"] = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
      ["<space>wr"] = { vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
      ["<space>wl"] = {
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        "List Workspace Folders"
      },
      ["<space>D"] = { vim.lsp.buf.type_definition, "Go to Type Definition" },
      ["<space>rn"] = { vim.lsp.buf.rename, "Rename Symbol" },
      ["<space>ca"] = { vim.lsp.buf.code_action, "Code Action", mode = { "n", "v" } },
      ["gr"] = { vim.lsp.buf.references, "Find References" },

      -- Telescope
      ["<leader>ff"] = { telescope.find_files, "Find Files" },
      ["<leader>fg"] = { telescope.live_grep, "Live Grep" },
      ["<leader>fb"] = { telescope.buffers, "Search Buffers" },
      ["<leader>fh"] = { telescope.help_tags, "Search Help" },

      -- TMUX
      ["<C-\\>"] = { "<cmd>TmuxNavigatePrevious<cr>", "Go to the previous pane" },
      ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Go to the left pane" },
      ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Go to the down pane" },
      ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Go to the up pane" },
      ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Go to the right pane" },

      -- DAP
      ["<leader>dc"] = { function() dap.continue() end, "Continue" },
      ["<leader>do"] = { function() dap.step_over() end, "Step Over" },
      ["<leader>di"] = { function() dap.step_into() end, "Step Into" },
      ["<leader>du"] = { function() dap.step_out() end, "Step Out" },
      ["<Leader>db"] = { function() dap.toggle_breakpoint() end, "Toggle Breakpoint" },
      ["<Leader>dB"] = { function() dap.set_breakpoint() end, "Set Breakpoint" },
      ["<Leader>dlp"] = {
        function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
        "Set Breakpoint (Log Message)"
      },
      ["<Leader>dro"] = { function() dap.repl.open() end, "Open REPL" },
      ["<Leader>drl"] = { function() dap.run_last() end, "Run Last" },
      ["<Leader>dh"] = { function() dap_widgets.hover() end, "DAP Hover Widget", mode = { "n", "v" } },
      ["<Leader>dp"] = { function() dap_widgets.preview() end, "DAP Preview Widget", mode = { "n", "v" } },
      ["<Leader>df"] = { function() dap_widgets.centered_float(dap_widgets.frames) end, "DAP Frames Widget" },
      ["<Leader>ds"] = { function() dap_widgets.centered_float(dap_widgets.scopes) end, "DAP Scopes Widget" },

    }, { prefix = "", mode = "n" })
  end,
}

