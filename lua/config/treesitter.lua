--- Use tree-sitter for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

--#region Config
require('nvim-treesitter.configs').setup {
    indent = {enable = true},
    highlight = {enable = true},
    playground = {enable = true},
    query_linter = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<Leader>si',
            node_incremental = '<Leader>sn',
            node_decremental = '<Leader>sm',
            scope_incremental = '<Leader>ss'
        }
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['aB'] = '@block.outer',
                ['iB'] = '@block.inner',
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
                ['ar'] = '@regex.outer',
                ['ir'] = '@regex.inner',
                ['in'] = '@number.inner',
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
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']k'] = '@class.outer',
                [']m'] = '@function.outer',
                [']a'] = '@parameter.outer'
            },
            goto_next_end = {
                [']K'] = '@class.outer',
                [']M'] = '@function.outer',
                [']A'] = '@parameter.outer'
            },
            goto_previous_start = {
                ['[k'] = '@class.outer',
                ['[m'] = '@function.outer',
                ['[a'] = '@parameter.outer'
            },
            goto_previous_end = {
                ['[K'] = '@class.outer',
                ['[M'] = '@function.outer',
                ['[A'] = '@parameter.outer'
            },
        },
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
                goto_definition      = 'gsd',
                goto_next_usage      = 'gsn',
                goto_previous_usage  = 'gsp',
                list_definitions_toc = 'gst'
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
        'diff',
        'dockerfile',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'glimmer',
        'html',
        -- 'htmldjango',
        'http',
        -- 'ini',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'kotlin',
        'latex',
        'lua',
        'luadoc',
        'luap',
        -- 'make',
        'markdown',
        'markdown_inline',
        'nix',
        -- 'perl',
        'python',
        'query',
        'r',
        'regex',
        'rnoweb',
        'rst',
        'rust',
        'scss',
        'svelte',
        'toml',
        'typescript',
        'vim',
        'vimdoc',
        'yaml'
    }
}
--#endregion
