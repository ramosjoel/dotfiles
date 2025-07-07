return {
    { 'theHamsta/nvim-dap-virtual-text', dependencies = { 'mfussenegger/nvim-dap' } },
    { 'nvim-neotest/nvim-nio',           dependencies = { 'mfussenegger/nvim-dap' } },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' },
        keys = {
            { '<leader>du', function() require('dapui').toggle() end,              desc = '[D]ebug [U]I' },
            { '<leader>df', function() require('dapui').float_element() end,       desc = '[D]ebug [F]loat' },
            { '<leader>dl', function() require('dapui').float_element('repl') end, desc = '[D]ebug [L]og' },
        },
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/neotest',
            'nvim-neotest/neotest-go',
        },
        keys = function()
            return {
                { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle [B]reakpoint' },
                { '<leader>dc', function() require('dap').continue() end,          desc = '[C]ontinue' },
                { '<leader>di', function() require('dap').step_into() end,         desc = 'Step [I]nto' },
                { '<leader>do', function() require('dap').step_over() end,         desc = 'Step [O]ver' },
                { '<leader>dr', function() require('dap').repl.open() end,         desc = 'Open [R]EPL' },
            }
        end,
        config = function()
            -- ***** UI Setup ***** --
            local dap, dapui = require('dap'), require('dapui')
            local dapgo = require('dap-go')
            dapui.setup()
            dapgo.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end


            -- Include the next few lines until the comment only if you feel you need it
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
            -- Include everything after this
            -- ***** Go ***** --
            dap.adapters.delve = function(callback, config)
                if config.mode == 'remote' and config.request == 'attach' then
                    callback({
                        type = 'server',
                        host = config.host or '127.0.0.1',
                        port = config.port or '38697'
                    })
                else
                    callback({
                        type = 'server',
                        port = '${port}',
                        executable = {
                            command = 'dlv',
                            args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
                            detached = vim.fn.has("win32") == 0,
                        }
                    })
                end
            end


            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = "${file}"
                },
                {
                    type = "delve",
                    name = "Debug smoketests", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    buildFlags = "-v -count=1 -tags=smoketests",
                    -- program = "${workspaceFolder}/src/smoketests/features/featurename/v1"
                    program = "${file}"
                },
            }
        end,
    },
    { 'leoluz/nvim-dap-go' }
    -- {
    --     'leoluz/nvim-dap-go',
    --     dependencies = { 'mfussenegger/nvim-dap' },
    --     keys = {
    --         { '<leader>dt', function() require('dap-go').debug_test() end, desc = 'Debug [T]est' },
    --     },
    --
    --     config = function()
    --         require('dap-go').setup({
    --             dap_configurations = {
    --                 {
    --                     -- Must be "go" or it will be ignored by the plugin
    --                     type = "go",
    --                     name = "Attach remote",
    --                     mode = "remote",
    --                     request = "attach",
    --                 },
    --                 {
    --                     type = "go",
    --                     name = "Debug Bond Test",
    --                     request = "launch",
    --                     program = "${file}",
    --                 }
    --             },
    --             -- delve configurations
    --             delve = {
    --                 -- the path to the executable dlv which will be used for debugging.
    --                 -- by default, this is the "dlv" executable on your PATH.
    --                 path = "dlv",
    --                 -- time to wait for delve to initialize the debug session.
    --                 -- default to 20 seconds
    --                 initialize_timeout_sec = 20,
    --                 -- a string that defines the port to start delve debugger.
    --                 -- default to string "${port}" which instructs nvim-dap
    --                 -- to start the process in a random available port.
    --                 -- if you set a port in your debug configuration, its value will be
    --                 -- assigned dynamically.
    --                 port = "${port}",
    --                 -- additional args to pass to dlv
    --                 args = { "dap", "-l", "127.0.0.1:${port}" },
    --                 -- the build flags that are passed to delve.
    --                 -- defaults to empty string, but can be used to provide flags
    --                 -- such as "-tags=unit" to make sure the test suite is
    --                 -- compiled during debugging, for example.
    --                 -- passing build flags using args is ineffective, as those are
    --                 -- ignored by delve in dap mode.
    --                 -- avaliable ui interactive function to prompt for arguments get_arguments
    --                 build_flags = { "-count=1", "-tags=smoketests" },
    --                 -- whether the dlv process to be created detached or not. there is
    --                 -- an issue on delve versions < 1.24.0 for Windows where this needs to be
    --                 -- set to false, otherwise the dlv server creation will fail.
    --                 -- avaliable ui interactive function to prompt for build flags: get_build_flags
    --                 detached = vim.fn.has("win32") == 0,
    --                 -- the current working directory to run dlv from, if other than
    --                 -- the current working directory.
    --                 cwd = nil,
    --             },
    --             -- options related to running closest test
    --             tests = {
    --                 -- enables verbosity when running the test.
    --                 verbose = true,
    --             },
    --         })
    --     end
    -- },
}
