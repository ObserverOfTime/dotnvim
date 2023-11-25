local c = require 'config'
local hl = 'GruvboxRed'
local map = vim.keymap.set

---@type table<string, Adapter>
local adapters = {}
---@type table<string, Configuration[]>
local configurations = {}

--#region C/C++
---@type ExecutableAdapter
adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
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
--#endregion

--#region Python
---@type ExecutableAdapter
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
---@type ServerAdapter
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

configurations.javascript = {{
    type = 'pwa-node',
    name = 'JavaScript',
    request = 'launch',
    program = '${file}',
    cwd = '${workspaceFolder}'
}}

configurations.typescript = {{
    type = 'pwa-node',
    name = 'TypeScript',
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
---@type ExecutableAdapter
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
        lazy = true,
        cond = function()
            return c.in_term() and c.not_mergetool()
        end,
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            dapui.setup()

            dap.adapters = adapters
            dap.configurations = configurations

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close

            map('n', '<Leader>Dc', dap.continue, {desc = 'DAP continue'})
            map('n', '<Leader>Do', dap.step_over, {desc = 'DAP step over'})
            map('n', '<Leader>Di', dap.step_into, {desc = 'DAP step into'})
            map('n', '<Leader>DO', dap.step_out, {desc = 'DAP step out'})
            map('n', '<Leader>Db', dap.toggle_breakpoint, {desc = 'DAP breakpoint'})
            map('n', '<Leader>Dr', dap.repl.open, {desc = 'DAP REPL'})
            map('n', '<Leader>DR', dap.run_last, {desc = 'DAP run'})
            map('n', '<Leader>DC', function()
                vim.ui.input({prompt = 'Condition'}, dap.set_breakpoint)
            end, {desc = 'DAP condition'})
            map('n', '<Leader>DL', function()
                vim.ui.input({prompt = 'Log point message'}, function(input)
                    dap.set_breakpoint(nil, nil, input)
                end)
            end, {desc = 'DAP log point'})
            map('n', '<Leader>DE', function()
                vim.ui.input({prompt = 'Expression'}, dapui.eval)
            end, {desc = 'DAP eval input'})
            map({'n', 'x'}, '<Leader>De', dapui.eval, {desc = 'DAP eval text'})

            vim.fn.sign_define('DapStopped',             {text = '', texthl = hl})
            vim.fn.sign_define('DapLogPoint',            {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpoint',          {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpointCondition', {text = '', texthl = hl})
            vim.fn.sign_define('DapBreakpointRejected',  {text = '', texthl = hl})
        end,
        dependencies = {'rcarriga/nvim-dap-ui'}
    }
}
