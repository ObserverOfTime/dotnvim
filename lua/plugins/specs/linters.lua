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
        only_local = 'node_modules/.bin',
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
        only_local = 'node_modules/.bin',
        filetypes = {'css', 'scss', 'less', 'svelte'},
        condition = has_node_bin('stylelint')
    },
    stylint = {
        only_local = 'node_modules/.bin',
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

---pug-lint source
local function puglint()
    local h = require 'null-ls.helpers'
    local methods = require 'null-ls.methods'
    local resolver = require 'null-ls.helpers.command_resolver'

    return h.make_builtin {
        name = 'puglint',
        filetypes = {'pug'},
        method = methods.internal.DIAGNOSTICS,
        generator_opts = {
            command = 'pug-lint',
            args = {'--reporter=inline', '$FILENAME'},
            to_stdin = true,
            from_stderr = true,
            format = 'line',
            check_exit_code = function(code)
                return code <= 2
            end,
            on_output = h.diagnostics.from_patterns {
                {
                    pattern = [[([^:]+):(%d+) (.+)]],
                    groups = {'filename', 'row', 'message'}
                },
                {
                    pattern = [[([^:]+):(%d+):(%d+) (.+)]],
                    groups = {'filename', 'row', 'col', 'message'}
                }
            },
            dynamic_command = resolver.from_node_modules
        },
        factory = h.generator_factory
    }
end

---@type LazyPluginSpec[]
return {
    {
        'nvimtools/none-ls.nvim',
        enabled = not_mergetool,
        config = function()
            require('null-ls').setup {
                sources = {
                    require('null-ls.builtins.diagnostics.djlint').with(cfg.djlint),
                    require('none-ls.diagnostics.eslint_d').with(cfg.eslint_d),
                    require('none-ls.diagnostics.flake8').with(cfg.flake8),

                    require('null-ls.builtins.diagnostics.hadolint'),
                    require('null-ls.builtins.diagnostics.mypy').with(cfg.mypy),
                    puglint().with(cfg.puglint),
                    require('null-ls.builtins.diagnostics.pylint').with(cfg.pylint),
                    require('null-ls.builtins.diagnostics.rstcheck').with(cfg.rstcheck),
                    require('none-ls.diagnostics.ruff').with(cfg.ruff),
                    require('null-ls.builtins.diagnostics.stylelint').with(cfg.stylelint),
                    require('null-ls.builtins.diagnostics.stylint').with(cfg.stylint),
                    require('null-ls.builtins.diagnostics.tidy').with(cfg.tidy),
                    require('null-ls.builtins.diagnostics.vint').with(cfg.vint),

                    require('none-ls.formatting.autopep8').with(cfg.autopep8),
                    require('none-ls.formatting.eslint_d').with(cfg.eslint_d),
                    require('null-ls.builtins.formatting.isort').with(cfg.isort),
                    require('none-ls.formatting.ruff_format').with(cfg.ruff),
                    require('null-ls.builtins.formatting.shfmt').with(cfg.shfmt),
                    require('null-ls.builtins.formatting.stylelint').with(cfg.stylelint),
                    require('null-ls.builtins.formatting.stylua'),
                    require('null-ls.builtins.formatting.tidy').with(cfg.tidy),
                    require('null-ls.builtins.formatting.xmllint').with(cfg.xmllint),

                    require('none-ls.code_actions.eslint_d').with(cfg.eslint_d),
                }
            }
        end,
        dependencies = {
            'plenary.nvim',
            'nvimtools/none-ls-extras.nvim'
        }
    }
}
