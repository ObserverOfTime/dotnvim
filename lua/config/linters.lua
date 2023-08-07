-- Disable for git mergetool
if vim.g._mergetool then return end

local null_ls = require 'null-ls'

--- Check if executable exists
---@param cmd string
---@return fun(): boolean
local function is_executable(cmd)
    return function()
        return vim.fn.executable(cmd) == 1
    end
end

--- Check if node binary exists
---@param cmd string
---@return fun(utils: ConditionalUtils): boolean
local function has_node_bin(cmd)
    return function(utils)
        return utils.root_has_file('node_modules/.bin/'..cmd)
    end
end

--#region Config
local cfg = {
    autopep8 = {
        condition = is_executable('autopep8')
    },
    djlint = {
        filetypes = {'htmldjango'},
        condition = is_executable('djlint')
    },
    eslint_d = {
        env = {ESLINT_D_LOCAL_ESLINT_ONLY = true},
        filetypes = {'javascript', 'typescript', 'svelte'},
        condition = has_node_bin('eslint')
    },
    flake8 = {
        condition = is_executable('flake8')
    },
    isort = {
        condition = is_executable('isort')
    },
    mypy = {
        condition = is_executable('mypy')
    },
    ktlint = {
        extra_args = {'--android'}
    },
    rstcheck = {
        extra_args = {
            '--ignore-directives=automodule'
        }
    },
    puglint = {
        prefer_local = 'node_modules/.bin',
        condition = has_node_bin('pug-lint')
    },
    pylint = {
        condition = is_executable('pylint')
    },
    ruff = {
        condition = is_executable('ruff')
    },
    shellcheck = {
        extra_args = {
            '-e', 'SC1090,SC2034,SC2128,SC2148,SC2164',
            '-o', 'add-default-case,require-double-brackets'
        }
    },
    shfmt = {
        extra_args = {'-s', '-ci', '-i', '2', '-bn'}
    },
    stylelint = {
        prefer_local = 'node_modules/.bin',
        filetypes = {'css', 'scss', 'less', 'svelte'},
        condition = has_node_bin('stylelint')
    },
    stylint = {
        prefer_local = 'node_modules/.bin',
        condition = has_node_bin('stylint')
    },
    tidy = {
        filetypes = {'html'}
    },
    xmllint = {
        filetypes = {'xml', 'svg'}
    },
    vint = {
        extra_args = {'--enable-neovim'}
    }
}
--#endregion

--#region Sources
null_ls.setup {
    sources = {
        --#region Diagnostics
        null_ls.builtins.diagnostics.djlint.with(cfg.djlint),
        null_ls.builtins.diagnostics.eslint_d.with(cfg.eslint_d),
        null_ls.builtins.diagnostics.flake8.with(cfg.flake8),
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.mypy.with(cfg.mypy),
        null_ls.builtins.diagnostics.puglint.with(cfg.puglint),
        null_ls.builtins.diagnostics.pylint.with(cfg.pylint),
        null_ls.builtins.diagnostics.rstcheck.with(cfg.rstcheck),
        null_ls.builtins.diagnostics.ruff.with(cfg.ruff),
        null_ls.builtins.diagnostics.shellcheck.with(cfg.shellcheck),
        null_ls.builtins.diagnostics.stylelint.with(cfg.stylelint),
        null_ls.builtins.diagnostics.stylint.with(cfg.stylint),
        null_ls.builtins.diagnostics.tidy.with(cfg.tidy),
        -- null_ls.builtins.diagnostics.vint.with(cfg.vint),
        --#endregion

        --#region Formatting
        null_ls.builtins.formatting.autopep8.with(cfg.autopep8),
        null_ls.builtins.formatting.eslint_d.with(cfg.eslint_d),
        null_ls.builtins.formatting.isort.with(cfg.isort),
        null_ls.builtins.formatting.perltidy,
        null_ls.builtins.formatting.ruff.with(cfg.ruff),
        null_ls.builtins.formatting.shfmt.with(cfg.shfmt),
        null_ls.builtins.formatting.stylelint.with(cfg.stylelint),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.tidy.with(cfg.tidy),
        null_ls.builtins.formatting.xmllint.with(cfg.xmllint),
        --#endregion

        --#region Code actions
        null_ls.builtins.code_actions.eslint_d.with(cfg.eslint_d),
        null_ls.builtins.code_actions.shellcheck.with(cfg.shellcheck),
        --#endregion
    }
}
--#endregion
