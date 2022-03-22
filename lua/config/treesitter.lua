--- Use tree-sitter for folding
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

--#region Config
require('nvim-treesitter.configs').setup {
    indent = {enable = true},
    highlight = {enable = true},
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
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['aC'] = '@conditional.outer',
                ['iC'] = '@conditional.inner',
                ['aL'] = '@loop.outer',
                ['iL'] = '@loop.inner',
                ['in'] = '@number'
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ['<Leader>s'] = '@parameter.inner'
            },
            swap_previous = {
                ['<Leader>S'] = '@parameter.inner'
            }
        }
    },
    refactor = {
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = 'grr'
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = 'grd',
                list_definitions = 'grl',
                goto_next_usage = 'grn',
                goto_previous_usage = 'grp'
            }
        }
    },
    ensure_installed = {
        -- 'bash',
        'bibtex',
        'c',
        'cmake',
        'comment',
        'cpp',
        'css',
        'html',
        'glimmer',
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
        -- 'pug',
        'python',
        'query',
        'r',
        'regex',
        'rst',
        'scss',
        'svelte',
        'toml',
        'typescript',
        'vim',
        'yaml'
    }
}
--#endregion
