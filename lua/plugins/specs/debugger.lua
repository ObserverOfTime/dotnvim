local c = require 'config'

---@type table<string, dap.Adapter>
local adapters = {}
---@type table<string, Configuration[]>
local configurations = {}

--#region C/C++/Rust
---@type dap.ExecutableAdapter
adapters.lldb = {
    type = 'executable',
    command = 'lldb-dap',
    name = 'lldb'
}

configurations.c = {{
    type = 'lldb',
    name = 'LLDB',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = function()
        local co = assert(coroutine.running())
        vim.schedule(function()
            vim.ui.input({
                prompt = 'Program',
                completion = 'file'
            }, function(input)
                coroutine.resume(co, input)
            end)
        end)
        return coroutine.yield()
    end,
    env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, k..'='..v)
        end
        return variables
    end
}}

configurations.cpp = configurations.c
configurations.rust = configurations.c
configurations.zig = configurations.c
--#endregion

--#region Python
---@type dap.ExecutableAdapter
adapters.python = {
    type = 'executable',
    command = vim.g.python3_host_prog,
    args = {'-m', 'debugpy.adapter'},
    options = {source_filetype = 'python'}
}

configurations.python = {{
    type = 'python',
    name = 'Python',
    request = 'launch',
    program = '${file}',
    pythonPath = function()
        local venv = vim.env.VIRTUAL_ENV
        return (venv or '/usr')..'/bin/python'
    end
}}
--#endregion

--#region JavaScript/TypeScript
---@type dap.ServerAdapter
adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = 8123,
    executable = {
        command = 'node',
        args = {
            '/opt/js-debug/src/dapDebugServer.js'
        }
    }
}

---@type dap.ExecutableAdapter
adapters.firefox = {
    type = 'executable',
    command = 'firefox-debugadapter'
}

configurations.javascript = {
    {
        type = 'pwa-node',
        name = 'JavaScript (Node)',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}'
    },
    {
        type = 'firefox',
        name = 'JavaScript (Firefox)',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:4000',
        webRoot = '${workspaceFolder}',
        firefoxExecutable = '/usr/bin/firefox-developer-edition'
    }
}

configurations.typescript = {{
    type = 'pwa-node',
    name = 'TypeScript (Deno)',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}',
    runtimeExecutable = 'deno',
    runtimeArgs = {
        'run',
        '--inspect-wait',
        '--allow-all'
    },
    attachSimplePort = 9229
}}
--#endregion

--#region Lua
---@type dap.ExecutableAdapter
adapters['local-lua'] = {
    type = 'executable',
    command = 'local-lua-dbg',
    enrich_config = function(config, on_config)
        if not config['extensionPath'] then
            local path = '/usr/lib/node_modules/local-lua-debugger-vscode'
            on_config(vim.tbl_extend('force', config, {extensionPath = path}))
        else
            on_config(config)
        end
    end
}

configurations.lua = {{
    type = 'local-lua',
    name = 'Lua',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = {
        lua = '/usr/local/bin/nlua',
        file = '${file}'
    }
}}
--#endregion

---@type LazyPluginSpec[]
return {
    {
        'mfussenegger/nvim-dap',
        cond = c.in_term,
        enabled = c.not_mergetool,
        keys = {
            {
                '<Leader>Dc',
                function()
                    require('dap').continue()
                end,
                mode = {'n'},
                desc = 'DAP continue',
            },
            {
                '<Leader>Do',
                function()
                    require('dap').step_over()
                end,
                mode = {'n'},
                desc = 'DAP step over',
            },
            {
                '<Leader>Di',
                function()
                    require('dap').step_into()
                end,
                mode = {'n'},
                desc = 'DAP step into',
            },
            {
                '<Leader>DO',
                function()
                    require('dap').step_out()
                end,
                mode = {'n'},
                desc = 'DAP step out',
            },
            {
                '<Leader>Db',
                function()
                    require('dap').toggle_breakpoint()
                end,
                mode = {'n'},
                desc = 'DAP breakpoint',
            },
            {
                '<Leader>Dr',
                function()
                    require('dap.repl').open()
                end,
                mode = {'n'},
                desc = 'DAP REPL',
            },
            {
                '<Leader>DR',
                function()
                    require('dap').run_last()
                end,
                mode = {'n'},
                desc = 'DAP run',
            },
            {
                '<Leader>DC',
                function()
                    vim.ui.input({
                        prompt = 'Condition'
                    }, function(input)
                        require('dap').set_breakpoint(input)
                    end)
                end,
                mode = {'n'},
                desc = 'DAP condition',
            },
            {
                '<Leader>DL',
                function()
                    vim.ui.input({
                        prompt = 'Log point message'
                    }, function(input)
                        require('dap').set_breakpoint(nil, nil, input)
                    end)
                end,
                mode = {'n'},
                desc = 'DAP log point',
            },
            {
                '<Leader>De',
                function()
                    require('dapui').eval()
                end,
                mode = {'n', 'x'},
                desc = 'DAP eval text',
            },
            {
                '<Leader>DE',
                function()
                    vim.ui.input({
                        prompt = 'Expression'
                    }, function(input)
                        require('dapui').eval(input)
                    end)
                end,
                mode = {'n'},
                desc = 'DAP eval input',
            }
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            dapui.setup()

            dap.adapters = adapters
            dap.configurations = configurations

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close

            local hl = 'GruvboxRed'
            vim.fn.sign_define('DapStopped', {text = '', texthl = hl})
            vim.fn.sign_define('DapLogPoint', {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpoint', {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpointCondition', {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpointRejected', {text = '', texthl = hl})
        end,
        dependencies = {'nvim-dap-ui'}
    },
    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        dependencies = {'nvim-nio'}
    }
}
