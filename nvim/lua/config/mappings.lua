-- Require necessary modules (assumed to be placed at the top of your config)
local wk = require("which-key")
local harpoon = require("harpoon")
local conform = require("conform")
local telescope = require("telescope.builtin")
local dap = require("dap")
local dap_widgets = require("dap.ui.widgets") -- Ensure this module exists

-- Harpoon setup
harpoon:setup()

-- Diagnostic Toggle Function
vim.g["diagnostics_active"] = true
local function Toggle_diagnostics()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.enable(false)
    else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable()
    end
end

-- Register key bindings with which-key
wk.add({
    -- Groups
    { "<leader>f", group = "file" },                     -- Group for file operations
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- Proxy for window mappings
    {
        "<leader>b",
        group = "buffers",
        expand = function()
            return require("which-key.extras").expand.buf()
        end
    },

    -- Clipboard
    { "<leader>y", '"+y',                                                       desc = "Copy to clipboard",              mode = { "n", "v" } },
    { "<leader>p", '"+p',                                                       desc = "Paste from clipboard",           mode = { "n", "v" } },

    -- -- Window Movements
    -- { "<C-k>",     "<C-w>k",                                                    desc = "Move up a window",               mode = "n" },
    -- { "<C-j>",     "<C-w>j",                                                    desc = "Move down a window",             mode = "n" },
    -- { "<C-h>",     "<C-w>h",                                                    desc = "Move left a window",             mode = "n" },
    -- { "<C-l>",     "<C-w>l",                                                    desc = "Move right a window",            mode = "n" },
    { "<C-c>",     "<C-w>c",                                                    desc = "Close window",                   mode = "n" },
    { "<lt>",      "<C-w><lt>",                                                 desc = "Decrease current window width",  mode = "n" },
    { ">",         "<C-w>>",                                                    desc = "Increase current window width",  mode = "n" },
    { "-",         "<C-w>-",                                                    desc = "Decrease current window height", mode = "n" },
    { "+",         "<C-w>+",                                                    desc = "Increase current window height", mode = "n" },

    -- Oil
    { "-",         ":lua require('oil').open()<CR>",                            desc = "Open Oil",                       mode = "n" }, -- Conflicts with window height decrease
    { "<Leader>o", ":lua require('oil').open_float()<CR>",                      desc = "Open Oil in floating window",    mode = "n" },

    -- Harpoon
    { "<leader>a", function() harpoon:list():add() end,                         desc = "Add file to Harpoon list",       mode = "n" },
    { "<leader>A", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle Harpoon menu",            mode = "n" },
    { "<leader>1", function() harpoon:list():select(1) end,                     desc = "Switch to Harpoon buffer 1",     mode = "n" },
    { "<leader>2", function() harpoon:list():select(2) end,                     desc = "Switch to Harpoon buffer 2",     mode = "n" },
    { "<leader>3", function() harpoon:list():select(3) end,                     desc = "Switch to Harpoon buffer 3",     mode = "n" },
    { "<leader>4", function() harpoon:list():select(4) end,                     desc = "Switch to Harpoon buffer 4",     mode = "n" },

    -- Formatter
    {
        "<leader>fm",
        function()
            conform.format({ lsp_fallback = true, timeout_ms = 500 })
        end,
        desc = "Format File",
        mode = "n"
    },

    -- LSP
    { "<leader>xd", Toggle_diagnostics,                  desc = "Toggle Vim Diagnostics",  mode = "n" },
    { "gD",         vim.lsp.buf.declaration,             desc = "Go to Declaration",       mode = "n" },
    { "gd",         vim.lsp.buf.definition,              desc = "Go to Definition",        mode = "n" },
    { "K",          vim.lsp.buf.hover,                   desc = "Show Info About Symbol",  mode = "n" },
    { "gi",         vim.lsp.buf.implementation,          desc = "Go to Implementation",    mode = "n" },
    { "<C-i>",      vim.lsp.buf.signature_help,          desc = "Show Signature Help",     mode = "n" },
    { "<space>wa",  vim.lsp.buf.add_workspace_folder,    desc = "Add Workspace Folder",    mode = "n" },
    { "<space>wr",  vim.lsp.buf.remove_workspace_folder, desc = "Remove Workspace Folder", mode = "n" },
    {
        "<space>wl",
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        desc = "List Workspace Folders",
        mode = "n"
    },
    { "<space>D",   vim.lsp.buf.type_definition,            desc = "Go to Type Definition",  mode = "n" },
    { "<space>rn",  vim.lsp.buf.rename,                     desc = "Rename Symbol",          mode = "n" },
    { "<space>ca",  vim.lsp.buf.code_action,                desc = "Code Action",            mode = { "n", "v" } },
    { "gr",         vim.lsp.buf.references,                 desc = "Find References",        mode = "n" },

    -- Telescope
    { "<leader>ff", telescope.find_files,                   desc = "Find Files",             mode = "n" },
    { "<leader>fg", telescope.live_grep,                    desc = "Live Grep",              mode = "n" },
    { "<leader>fb", telescope.buffers,                      desc = "Search Buffers",         mode = "n" },
    { "<leader>fh", telescope.help_tags,                    desc = "Search Help",            mode = "n" },


    -- TMUX
    { "<C-\\>",     "<cmd>TmuxNavigatePrevious<cr>",        desc = "Go to the previous pane" },
    { "<C-h>",      "<cmd>TmuxNavigateLeft<cr>",            desc = "Got to the left pane" },
    { "<C-j>",      "<cmd>TmuxNavigateDown<cr>",            desc = "Got to the down pane" },
    { "<C-k>",      "<cmd>TmuxNavigateUp<cr>",              desc = "Got to the up pane" },
    { "<C-l>",      "<cmd>TmuxNavigateRight<cr>",           desc = "Got to the right pane" },

    -- DAP (Debug Adapter Protocol)
    { "<leader>dc", function() dap.continue() end,          desc = "Continue",               mode = "n" },
    { "<leader>do", function() dap.step_over() end,         desc = "Step Over",              mode = "n" },
    { "<leader>di", function() dap.step_into() end,         desc = "Step Into",              mode = "n" },
    { "<leader>du", function() dap.step_out() end,          desc = "Step Out",               mode = "n" },
    { "<Leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint",      mode = "n" },
    { "<Leader>dB", function() dap.set_breakpoint() end,    desc = "Set Breakpoint",         mode = "n" },
    {
        "<Leader>dlp",
        function()
            dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end,
        desc = "Set Breakpoint (Log Message)",
        mode = "n"
    },
    { "<Leader>dro", function() dap.repl.open() end,                                desc = "Open REPL",          mode = "n" },
    { "<Leader>drl", function() dap.run_last() end,                                 desc = "Run Last",           mode = "n" },
    { "<Leader>dh",  function() dap_widgets.hover() end,                            desc = "DAP Hover Widget",   mode = { "n", "v" } },
    { "<Leader>dp",  function() dap_widgets.preview() end,                          desc = "DAP Preview Widget", mode = { "n", "v" } },
    { "<Leader>df",  function() dap_widgets.centered_float(dap_widgets.frames) end, desc = "DAP Frames Widget",  mode = "n" },
    { "<Leader>ds",  function() dap_widgets.centered_float(dap_widgets.scopes) end, desc = "DAP Scopes Widget",  mode = "n" },
}, { prefix = "", mode = "n" }) -- Adjust prefix and default mode as needed
