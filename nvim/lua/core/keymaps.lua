-- lua/core/keymaps.lua

-- Basic keymaps not depending on plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit all" })

-- You can add more basic keymaps here if needed

local wk = require("which-key")

wk.setup({})

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

local wk = require("which-key")

wk.add({
    -- Groups
    { "<leader>f", group = "file" },
    { "<leader>w", group = "windows" },
    { "<leader>b", group = "buffers" },

    -- Clipboard
    { "<leader>y", '"+y',            desc = "Copy to clipboard",    mode = { "n", "v" } },
    { "<leader>p", '"+p',            desc = "Paste from clipboard", mode = { "n", "v" } },

    -- Trouble
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },


    -- Window movements
    { "<C-c>",      "<C-w>c",                                                                            desc = "Close window" },
    { "<lt>",       "<C-w><lt>",                                                                         desc = "Decrease current window width" },
    { ">",          "<C-w>>",                                                                            desc = "Increase current window width" },
    { "-",          "<C-w>-",                                                                            desc = "Decrease current window height" },
    { "+",          "<C-w>+",                                                                            desc = "Increase current window height" },

    -- Oil
    { "<leader>o",  ":lua require('oil').open_float()<CR>",                                              desc = "Open Oil in floating window" },
    { "-",          ":lua require('oil').open()<CR>",                                                    desc = "Open Oil" }, -- Note: "-" is already used above, consider changing one of these

    -- Harpoon
    { "<leader>a",  function() require("harpoon").list:add() end,                                        desc = "Add file to Harpoon list" },
    { "<leader>A",  function() require("harpoon.ui").toggle_quick_menu() end,                            desc = "Toggle Harpoon menu" },
    { "<leader>1",  function() require("harpoon").list:select(1) end,                                    desc = "Switch to Harpoon buffer 1" },
    { "<leader>2",  function() require("harpoon").list:select(2) end,                                    desc = "Switch to Harpoon buffer 2" },
    { "<leader>3",  function() require("harpoon").list:select(3) end,                                    desc = "Switch to Harpoon buffer 3" },
    { "<leader>4",  function() require("harpoon").list:select(4) end,                                    desc = "Switch to Harpoon buffer 4" },

    -- Formatter
    { "<leader>fm", function() require("conform").format({ lsp_fallback = true, timeout_ms = 500 }) end, desc = "Format File" },

    -- LSP
    { "<leader>xd", Toggle_diagnostics,                                                                  desc = "Toggle Vim Diagnostics" },
    { "gD",         vim.lsp.buf.declaration,                                                             desc = "Go to Declaration" },
    { "gd",         vim.lsp.buf.definition,                                                              desc = "Go to Definition" },
    { "K",          vim.lsp.buf.hover,                                                                   desc = "Show Info About Symbol" },
    { "gi",         vim.lsp.buf.implementation,                                                          desc = "Go to Implementation" },
    { "<C-i>",      vim.lsp.buf.signature_help,                                                          desc = "Show Signature Help" },
    { "<space>wa",  vim.lsp.buf.add_workspace_folder,                                                    desc = "Add Workspace Folder" },
    { "<space>wr",  vim.lsp.buf.remove_workspace_folder,                                                 desc = "Remove Workspace Folder" },
    {
        "<space>wl",
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        desc = "List Workspace Folders",
    },
    { "<space>D",   vim.lsp.buf.type_definition,                       desc = "Go to Type Definition" },
    { "<space>rn",  vim.lsp.buf.rename,                                desc = "Rename Symbol" },
    { "<space>ca",  vim.lsp.buf.code_action,                           desc = "Code Action",            mode = { "n", "v" } },
    { "gr",         vim.lsp.buf.references,                            desc = "Find References" },

    -- Telescope
    { "<leader>ff", require("telescope.builtin").find_files,           desc = "Find Files" },
    { "<leader>fg", require("telescope.builtin").live_grep,            desc = "Live Grep" },
    { "<leader>fb", require("telescope.builtin").buffers,              desc = "Search Buffers" },
    { "<leader>fh", require("telescope.builtin").help_tags,            desc = "Search Help" },

    -- TMUX
    { "<C-\\>",     "<cmd>TmuxNavigatePrevious<cr>",                   desc = "Go to the previous pane" },
    { "<C-h>",      "<cmd>TmuxNavigateLeft<cr>",                       desc = "Go to the left pane" },
    { "<C-j>",      "<cmd>TmuxNavigateDown<cr>",                       desc = "Go to the down pane" },
    { "<C-k>",      "<cmd>TmuxNavigateUp<cr>",                         desc = "Go to the up pane" },
    { "<C-l>",      "<cmd>TmuxNavigateRight<cr>",                      desc = "Go to the right pane" },

    -- DAP
    { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
    { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
    { "<leader>du", function() require("dap").step_out() end,          desc = "Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint() end,    desc = "Set Breakpoint" },
    {
        "<leader>dlp",
        function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
        desc = "Set Breakpoint (Log Message)",
    },
    { "<leader>dro", function() require("dap").repl.open() end,                                           desc = "Open REPL" },
    { "<leader>drl", function() require("dap").run_last() end,                                            desc = "Run Last" },
    { "<leader>dh",  function() require("dap_widgets").hover() end,                                       desc = "DAP Hover Widget",   mode = { "n", "v" } },
    { "<leader>dp",  function() require("dap_widgets").preview() end,                                     desc = "DAP Preview Widget", mode = { "n", "v" } },
    { "<leader>df",  function() require("dap_widgets").centered_float(require("dap_widgets").frames) end, desc = "DAP Frames Widget" },
    { "<leader>ds",  function() require("dap_widgets").centered_float(require("dap_widgets").scopes) end, desc = "DAP Scopes Widget" },
}, { prefix = "", mode = "n" })
