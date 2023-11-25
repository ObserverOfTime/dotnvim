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
            {
                'ys', '<Plug>(nvim-surround-normal)',
                mode = 'n', desc = 'add surrounding pair'
            },
            {
                'yss', '<Plug>(nvim-surround-normal-cur)',
                mode = 'n', desc = 'add surrounding pair (line)'
            },
            {
                '<C-g>s', '<Plug>(nvim-surround-insert)',
                mode = 'i', desc = 'add surrounding pair (insert)'},
            {
                'S', '<Plug>(nvim-surround-visual)',
                mode = 'x', desc = 'add surrounding pair (visual)'},
            {
                'ds', '<Plug>(nvim-surround-delete)',
                mode = 'n', desc = 'delete surrounding pair'},
            {
                'cs', '<Plug>(nvim-surround-change)',
                mode = 'n', desc = 'change surrounding pair'
            }
        },
        ---@type user_options
        opts = {
            move_cursor = false,
            keymaps = {
                insert = false,
                insert_line = false,
                normal = false,
                normal_cur = false,
                normal_line = false,
                normal_cur_line = false,
                visual = false,
                visual_line = false,
                delete = false,
                change = false,
                change_line = false
            }
        }
    },
    {
        'Wansmer/treesj',
        enabled = true,
        keys = {
            {'gS', '<Cmd>TSJSplit<CR>', desc = 'split node'},
            {'gJ', '<Cmd>TSJJoin<CR>', desc = 'join node'}
        },
        opts = {
            use_default_keymaps = false
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
        -- XXX: no good alternative
        'mg979/vim-lion',
        keys = {
            {'g]', mode = {'n', 'x'}, desc = 'align left'},
            {'g[', mode = {'n', 'x'}, desc = 'align right'}
        }
    }
}
