---@type LazyPluginSpec[]
return {
    {
        -- TODO: choose an alternative?
        'mattn/emmet-vim',
        ft = {
            'html', 'htmldjango', 'pug',
            'svelte', 'svg', 'xml',
            'css', 'scss', 'less'
        },
        init = function()
            vim.g.emmet_html5 = true
            vim.g.user_emmet_mode = 'i'
            vim.g.user_emmet_leader_key = '<C-e>'
            vim.g.user_emmet_complete_tag = true
            vim.g.user_emmet_settings = {
                html = {
                    empty_element_suffix = '>',
                    quote_char = '"',
                },
                xml = {
                    snippets = {
                        ['!!!'] = '<?xml version="1.1" encoding="${charset}"?>'
                    }
                },
                svelte = {
                    extends = 'html',
                    empty_element_suffix = '/>'
                },
                svg = {
                    extends = 'xml',
                    snippets = {
                        ['svg'] = vim.fn.join({
                            '<svg xmlns="http://www.w3.org/2000/svg">',
                            '  ${cursor}',
                            '</svg>'
                        }, '\n')
                    }
                }
            }
        end
    },
    {
        'stsewd/sphinx.nvim',
        ft = {'rst'},
        build = ':UpdateRemotePlugins'
    },
    {
        -- XXX: no good alternative
        'chrisbra/csv.vim',
        ft = {'csv'},
        init = function()
            vim.g.csv_delim_test = ',|'
            vim.g.csv_hiGroup = 'IncSearch'
            vim.g.csv_no_conceal = true
            vim.g.csv_strict_columns = true
        end
    },
    {
        -- XXX: tree-sitter-pug is a WIP
        'seletskiy/vim-pug',
        ft = {'pug'}
    },
    {
        -- XXX: no tree-sitter parser
        'vio/vim-stylus',
        ft = {'stylus'}
    },
    {
        -- XXX: no tree-sitter parser
        'kchmck/vim-coffee-script',
        ft = {'coffee'}
    },
    {
        -- XXX: no tree-sitter parser
        'wsdjeg/vim-livescript',
        ft = {'livescript'}
    },
    {
        -- XXX: tree-sitter-plantuml is a WIP
        'aklt/plantuml-syntax',
        ft = {'plantuml'}
    }
}
