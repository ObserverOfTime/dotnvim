local not_mergetool = require('config').not_mergetool

---Check if executable exists
---@param cmd string
---@return fun(): boolean
local function is_executable(cmd)
    return function()
        return vim.fn.executable(cmd) == 1
    end
end

---Check if node binary exists
---@param cmd string
---@return fun(utils: ConditionalUtils): boolean
local function has_node_bin(cmd)
    return function(utils)
        return utils.root_has_file('node_modules/.bin/'..cmd)
    end
end

---Configuration
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
        extra_args = {'--enable-neovim'},
        ---@param utils ConditionalUtils
        condition = function(utils)
            return utils.root_has_file_matches('init%.vim')
        end
    }
}

---@type LazyPluginSpec[]
return {
    {
        'nvimtools/none-ls.nvim',
        name = 'null-ls.nvim',
        enabled = not_mergetool,
        config = function()
            local null_ls = require 'null-ls'
            null_ls.setup {
                sources = {
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
                    null_ls.builtins.diagnostics.stylelint.with(cfg.stylelint),
                    null_ls.builtins.diagnostics.stylint.with(cfg.stylint),
                    null_ls.builtins.diagnostics.tidy.with(cfg.tidy),
                    null_ls.builtins.diagnostics.vint.with(cfg.vint),

                    null_ls.builtins.formatting.autopep8.with(cfg.autopep8),
                    null_ls.builtins.formatting.eslint_d.with(cfg.eslint_d),
                    null_ls.builtins.formatting.isort.with(cfg.isort),
                    null_ls.builtins.formatting.ruff.with(cfg.ruff),
                    null_ls.builtins.formatting.shfmt.with(cfg.shfmt),
                    null_ls.builtins.formatting.stylelint.with(cfg.stylelint),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.tidy.with(cfg.tidy),
                    null_ls.builtins.formatting.xmllint.with(cfg.xmllint),

                    null_ls.builtins.code_actions.eslint_d.with(cfg.eslint_d),
                }
            }
        end,
        dependencies = {'plenary.nvim'}
    }
}
