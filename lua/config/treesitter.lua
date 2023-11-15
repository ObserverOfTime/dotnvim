--- Use tree-sitter for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

--#region Config
local ok, nvimts = pcall(require, 'nvim-treesitter.configs')

local install_dir = vim.fn.stdpath('data')..'/site'

local langs = {
    'awk',
    'bash',
    'bibtex',
    'c',
    'cmake',
    'cpp',
    'css',
    'diff',
    'dockerfile',
    'gitattributes',
    'gitcommit',
    'gitignore',
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
    'luap',
    -- 'make',
    'markdown',
    'markdown_inline',
    'perl',
    'po',
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
    'xml',
    'yaml'
}

if not ok then
    ---@diagnostic disable-next-line: redundant-parameter
    require('nvim-treesitter').setup {
        ensure_install = langs,
        auto_install = false,
        install_dir = install_dir
    }
    vim.opt.indentexpr = [[v:lua.require('nvim-treesitter').indentexpr()]]
    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      ---@param args AutocmdArgs
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })
    return
end

nvimts.setup {
    auto_install = false,
    install_dir = install_dir..'/parser',
    indent = {enable = true},
    highlight = {enable = true},
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
    ensure_installed = langs
}
--#endregion
