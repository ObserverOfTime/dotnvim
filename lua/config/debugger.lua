local dap = require 'dap'

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
        return vim.fn.input('Program: ', vim.fn.getcwd()..'/', 'file')
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
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
}}
--#endregion

--#region Listeners
dap.listeners.after.event_initialized['dapui_config'] = function()
  package.loaded.dapui.open()
end
--#endregion

--#region Mappings
local map = vim.keymap.set

--- Evaluate text with DAP UI
local function dapui_eval()
    package.loaded.dapui.eval()
end

-- Evaluate input with DAP UI
local function dapui_input()
    local expr = vim.fn.input('Expression: ')
    package.loaded.dapui.eval(expr)
end

--- Set log point
local function dap_log_point()
    local msg = vim.fn.input('Log point message: ')
    dap.set_breakpoint(nil, nil, msg)
end

--- Set breakpoint condition
local function dap_condition()
    dap.set_breakpoint(vim.fn.input('Condition: '))
end

map('n', '<Leader>Dc', dap.continue)
map('n', '<Leader>Do', dap.step_over)
map('n', '<Leader>Di', dap.step_into)
map('n', '<Leader>DO', dap.step_out)
map('n', '<Leader>Db', dap.toggle_breakpoint)
map('n', '<Leader>DC', dap_condition)
map('n', '<Leader>DL', dap_log_point)
map('n', '<Leader>Dr', dap.repl.open)
map('n', '<Leader>Dl', dap.run_last)
map('n', '<Leader>DE', dapui_input)
map({'n', 'x'}, '<Leader>De', dapui_eval)
--#endregion

--#region Signs
local hl = 'GruvboxRed'
vim.fn.sign_define('DapStopped', {text = '', texthl = hl})
vim.fn.sign_define('DapLogPoint', {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpoint', {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpointCondition', {text = '', texthl = hl})
vim.fn.sign_define('DapBreakpointRejected', {text = '', texthl = hl})
--#endregion
