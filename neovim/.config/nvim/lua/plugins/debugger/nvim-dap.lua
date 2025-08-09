local function rebuild_project(co, path)
    local spinner = require("easy-dotnet.ui-modules.spinner").new()
    spinner:start_spinner("Building")

    vim.fn.jobstart(string.format("dotnet build %s", path), {
        stdout_buffered = true,
        stderr_buffered = true,
        on_exit = vim.schedule_wrap(function(_, return_code)
            if return_code == 0 then
                spinner:stop_spinner("Built successfully")
            else
                spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
                vim.notify("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
                error("Build failed")
            end
            if co then coroutine.resume(co) end
        end),
    })
    coroutine.yield() -- Yield here so the build is completed before proceeding.
end

return {
    -- DAP core configuration
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dotnet = require("easy-dotnet")
            local dapui = require("dapui")

            dap.set_log_level("TRACE")

            -- Python Adapter (unchanged)
            dap.adapters.python = {
                type = "executable",
                command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
                args = { "-m", "debugpy.adapter" },
            }
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        return os.getenv("HOME") .. "/.virtualenvs/tools/bin/python"
                    end,
                },
            }

            -- DAP UI listeners
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Keymaps (unchanged)
            vim.keymap.set("n", "q", function()
                dap.close(); dapui.close()
            end, {})
            vim.keymap.set("n", "<F5>", dap.continue, {})
            vim.keymap.set("n", "<F10>", dap.step_over, {})
            vim.keymap.set("n", "<F11>", dap.step_into, {})
            vim.keymap.set("n", "<F12>", dap.step_out, {})
            vim.keymap.set("n", "<leader>dO", dap.step_over, {})
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, {})
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, {})
            vim.keymap.set("n", "<leader>dj", dap.down, {})
            vim.keymap.set("n", "<leader>dk", dap.up, {})
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<F2>", require("dap.ui.widgets").hover, {})

            -- Helper function to check if a file exists
            local function file_exists(path)
                local stat = vim.loop.fs_stat(path)
                return stat and stat.type == "file"
            end

            -- Caching the DLL
            local debug_dll = nil

            local function ensure_dll()
                if debug_dll then
                    return debug_dll
                end

                -- Get the DLL from easy-dotnet
                debug_dll = dotnet.get_debug_dll()

                -- Debugging output to check the DLL
                if debug_dll == nil then
                    error("Failed to obtain DLL from dotnet.get_debug_dll()")
                end

                print("Returned DLL from dotnet.get_debug_dll(): " .. vim.inspect(debug_dll))
                return debug_dll
            end

            -- Loop through supported .NET languages (C# & F#)
            for _, lang in ipairs { "cs", "fsharp" } do
                dap.adapters.coreclr = {
                    type = "executable",
                    command = "/usr/local/netcoredbg", -- This should be the path to netcoredbg executable
                    args = { "--interpreter=vscode" },
                }

                dap.configurations[lang] = {
                    {
                        type = "coreclr",
                        name = "Launch .NET Program",
                        request = "launch",
                        env = function()
                            local dll = ensure_dll()
                            return dotnet.get_environment_variables(dll.project_name, dll.absolute_project_path)
                        end,
                        program = function()
                            local dll = ensure_dll()
                            local co = coroutine.running()
                            if not co then error("This function must be run within a coroutine") end
                            rebuild_project(co, dll.project_path)

                            if not file_exists(dll.target_path) then
                                error("Project has not been built. Missing: " .. dll.target_path)
                            end
                            return dll.target_path
                        end,
                        cwd = function()
                            local dll = ensure_dll()
                            return dll.absolute_project_path
                        end,
                    },
                }

                -- Reset DLL reference after debugging ends
                dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
                    debug_dll = nil
                end
            end
        end,
    },

    -- DAP UI configuration
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dapui").setup()
        end,
    },
}
