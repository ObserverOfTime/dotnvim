local null_ls = require 'null-ls'

--- Check if executable exists
local function is_executable(cmd)
    return function()
        return vim.fn.executable(cmd) == 1
    end
end

--- Check if node binary exists
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
    eslint = {
        prefer_local = 'node_modules/.bin',
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
        condition = has_node_bin('pug-lint'),
    },
    pylint = {
        condition = is_executable('pylint')
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
        filetypes = {'css', 'scss', 'less', 'svelte'}
    },
    stylint = {
        prefer_local = 'node_modules/.bin',
        condition = has_node_bin('stylint'),
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
null_ls.register {
    --#region Diagnostics
    null_ls.builtins.diagnostics.djlint.with(cfg.djlint),
    null_ls.builtins.diagnostics.eslint.with(cfg.eslint),
    null_ls.builtins.diagnostics.flake8.with(cfg.flake8),
    null_ls.builtins.diagnostics.ktlint.with(cfg.ktlint),
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.mypy.with(cfg.mypy),
    null_ls.builtins.diagnostics.puglint.with(cfg.puglint),
    null_ls.builtins.diagnostics.pylint.with(cfg.pylint),
    null_ls.builtins.diagnostics.rstcheck.with(cfg.rstcheck),
    null_ls.builtins.diagnostics.shellcheck.with(cfg.shellcheck),
    null_ls.builtins.diagnostics.stylelint.with(cfg.stylelint),
    null_ls.builtins.diagnostics.stylint.with(cfg.stylint),
    null_ls.builtins.diagnostics.tidy.with(cfg.tidy),
    null_ls.builtins.diagnostics.vint.with(cfg.vint),
    --#endregion

    --#region Formatting
    null_ls.builtins.formatting.autopep8.with(cfg.autopep8),
    null_ls.builtins.formatting.eslint.with(cfg.eslint),
    null_ls.builtins.formatting.isort.with(cfg.isort),
    null_ls.builtins.formatting.ktlint.with(cfg.ktlint),
    null_ls.builtins.formatting.perltidy,
    null_ls.builtins.formatting.shfmt.with(cfg.shfmt),
    null_ls.builtins.formatting.stylelint.with(cfg.stylelint),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.tidy.with(cfg.tidy),
    null_ls.builtins.formatting.xmllint.with(cfg.xmllint),
    --#endregion

    --#region Code actions
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.eslint.with(cfg.eslint),
    null_ls.builtins.code_actions.shellcheck.with(cfg.shellcheck)
    --#endregion
}
--#endregion
