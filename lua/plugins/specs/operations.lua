local in_term = require('config').in_term

---@type LazyPluginSpec[]
return {
    {
        'numToStr/Comment.nvim',
        name = 'comment.nvim',
        keys = {
            {'gc', mode = {'n', 'x'}, desc = 'toggle comment linewise'},
            {'gcc', mode = {'n'}, desc = 'toggle comment in current line'},
            {'gcA', mode = {'n'}, desc = 'insert comment at EOL'},
            {'gcO', mode = {'n'}, desc = 'insert comment above'},
            {'gco', mode = {'n'}, desc = 'insert comment below'},
            {'gb', mode = {'n', 'x'}, desc = 'toggle comment blockwise'},
            {'gbc', mode = {'n'}, desc = 'toggle comment in current block'}
        },
        config = function()
            require('Comment').setup()
            local ft = require 'Comment.ft'
            ft.pug = {'//-%s'}
            ft.htmldjango = {
                '{#%s#}', '{% comment %}%s{% endcomment %}'
            }
        end
    },
    {
        'kylechui/nvim-surround',
        keys = {
            {'ys', mode = 'n', desc = 'add surrounding pair'},
            {'yss', mode = 'n', desc = 'add surrounding pair (line)'},
            {'<C-g>s', mode = 'i', desc = 'add surrounding pair (insert)'},
            {'S', mode = 'x', desc = 'add surrounding pair (visual)'},
            {'ds', mode = 'n', desc = 'delete surrounding pair'},
            {'cs', mode = 'n', desc = 'change surrounding pair'}
        },
        ---@type user_options
        opts = {
            move_cursor = false,
            keymaps = {
                insert_line = false,
                normal_line = false,
                normal_cur_line = false,
                visual_line = false,
                change_line = false
            }
        }
    },
    {
        -- XXX: no alternative
        'chrisbra/unicode.vim',
        cond = in_term,
        keys = {
            {'ga', '<Plug>(UnicodeGA)', desc = 'view unicode character'}
        },
        cmd = {'Digraphs', 'UnicodeName', 'UnicodeTable'},
        init = function()
            vim.g.Unicode_no_default_mappings = true
        end
    },
    {
        -- TODO: choose an alternative?
        'AndrewRadev/splitjoin.vim',
        keys = {
            {'gS', desc = 'split code'},
            {'gJ', desc = 'join code'}
        },
        init = function()
            vim.g.splitjoin_quiet = 1
            vim.g.splitjoin_trailing_comma = 0
            vim.g.splitjoin_curly_brace_padding = 0
            vim.g.splitjoin_html_attributes_hanging = 1
        end
    },
    {
        -- TODO: choose an alternative?
        'mg979/vim-lion',
        keys = {
            {'g]', mode = {'n', 'x'}, desc = 'align left'},
            {'g[', mode = {'n', 'x'}, desc = 'align right'},
            {'g}', mode = {'n', 'x'}, desc = 'squeeze left'},
            {'g{', mode = {'n', 'x'}, desc = 'squeeze right'},
        }
    }
}
