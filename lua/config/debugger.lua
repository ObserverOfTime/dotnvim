local dap = require 'dap'
local dapui = require 'dapui'

dapui.setup()

--#region C/C++
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
}

dap.configurations.c = {{
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

dap.configurations.cpp = dap.configurations.c
--#endregion

--#region Python
dap.adapters.python = {
  type = 'executable',
  command = vim.g.python3_host_prog,
  args = {'-m', 'debugpy.adapter'}
}

dap.configurations.python = {{
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

--#region JavaScript
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {'--inspect', '/opt/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {{
    type = 'node2',
    name = 'Node',
    request = 'launch',
    program = '${file}',
    cwd = vim.loop.cwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
}}
--#endregion

--#region Lua
dap.adapters.nlua = function(callback, config)
    callback {
        type = 'server',
        host = config.host or '127.0.0.1',
        port = config.port or 8086
    }
end

dap.configurations.lua = {{
    type = 'nlua',
    name = 'Neovim Lua',
    request = 'attach'
}}
--#endregion

--#region Listeners
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
--#endregion

--#region Mappings
local map = vim.keymap.set
map('n', '<Leader>Dc', dap.continue, {desc = 'DAP continue'})
map('n', '<Leader>Do', dap.step_over, {desc = 'DAP step over'})
map('n', '<Leader>Di', dap.step_into, {desc = 'DAP step into'})
map('n', '<Leader>DO', dap.step_out, {desc = 'DAP step out'})
map('n', '<Leader>Db', dap.toggle_breakpoint, {desc = 'DAP breakpoint'})
map('n', '<Leader>Dr', dap.repl.open, {desc = 'DAP REPL'})
map('n', '<Leader>DR', dap.run_last, {desc = 'DAP run'})
map('n', '<Leader>Dl', function()
    require('osv').run_this()
end, {desc = 'DAP run Lua plugin'})
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
--#endregion

--#region Signs
local hl = 'GruvboxRed'
vim.fn.sign_define('DapStopped',             {text = '', texthl = hl})
vim.fn.sign_define('DapLogPoint',            {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpoint',          {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpointCondition', {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpointRejected',  {text = '', texthl = hl})
--#endregion
