--- Use tree-sitter for folding
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

--#region Config
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        disable = {'bash'}
    },
    indent = {enable = true},
    playground = {enable = true},
    query_linter = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['aa'] = '@call.outer',
                ['ia'] = '@call.inner',
                ['aP'] = '@parameter.outer',
                ['iP'] = '@parameter.inner',
                ['aI'] = '@conditional.outer',
                ['iI'] = '@conditional.inner',
                ['aL'] = '@loop.outer',
                ['iL'] = '@loop.inner',
                ['aC'] = '@comment.outer',
                ['in'] = '@number'
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ['gss'] = '@parameter.inner'
            },
            swap_previous = {
                ['gsS'] = '@parameter.inner'
            }
        }
    },
    refactor = {
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = 'gsr'
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = 'gsd',
                goto_next_usage = 'gsn',
                goto_previous_usage = 'gsp'
            }
        }
    },
    ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'cmake',
        'comment',
        'cpp',
        'css',
        'dockerfile',
        'glimmer',
        -- 'help', FIXME: vigoux/tree-sitter-vimdoc#1
        'html',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'kotlin',
        'latex',
        'lua',
        'make',
        'markdown',
        'nix',
        -- 'perl', FIXME: ganezdragon/tree-sitter-perl#20
        'python',
        'query',
        'r',
        'regex',
        'rst',
        'rust',
        'scss',
        'svelte',
        'toml',
        'typescript',
        'vim',
        'yaml'
    }
}
--#endregion
