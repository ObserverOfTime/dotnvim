---@type LazyPluginSpec[]
return {
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
