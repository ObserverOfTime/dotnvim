local in_term = require('config').in_term

---@param mode string
---@param line string
---@param pattern string
---@param format string
---@return string?
local function gx_handler(mode, line, pattern, format)
    local name = require('gx.helper').find(line, mode, pattern)
    if name then return format:format(name) end
end

---@type LazyPluginSpec[]
return {
    {
        'numToStr/Comment.nvim',
        name = 'comment.nvim',
        keys = {
            {'gc',  mode = {'n', 'x'}, desc = 'toggle comment linewise'},
            {'gcc', mode = {'n'},      desc = 'toggle comment in current line'},
            {'gcA', mode = {'n'},      desc = 'insert comment at EOL'},
            {'gcO', mode = {'n'},      desc = 'insert comment above'},
            {'gco', mode = {'n'},      desc = 'insert comment below'},
            {'gb',  mode = {'n', 'x'}, desc = 'toggle comment blockwise'},
            {'gbc', mode = {'n'},      desc = 'toggle comment in current block'}
        },
        config = function()
            local tsccms = require 'ts_context_commentstring.integrations.comment_nvim'
            require('Comment').setup {
                pre_hook = tsccms.create_pre_hook()
            }
            local ft = require 'Comment.ft'
            ft.pug = {'//-%s'}
            ft.htmldjango = {
                '{#%s#}', '{% comment %}%s{% endcomment %}'
            }
        end,
        dependencies = {'nvim-ts-context-commentstring'}
    },
    {
        'kylechui/nvim-surround',
        keys = {
            {
                'ys',
                '<Plug>(nvim-surround-normal)',
                mode = 'n',
                desc = 'add surrounding pair'
            },
            {
                'yss',
                '<Plug>(nvim-surround-normal-cur)',
                mode = 'n',
                desc = 'add surrounding pair (line)'
            },
            {
                '<C-g>s',
                '<Plug>(nvim-surround-insert)',
                mode = 'i',
                desc = 'add surrounding pair (insert)'
            },
            {
                'S',
                '<Plug>(nvim-surround-visual)',
                mode = 'x',
                desc = 'add surrounding pair (visual)'
            },
            {
                'ds',
                '<Plug>(nvim-surround-delete)',
                mode = 'n',
                desc = 'delete surrounding pair'
            },
            {
                'cs',
                '<Plug>(nvim-surround-change)',
                mode = 'n',
                desc = 'change surrounding pair'
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
        keys = {
            {'gS', '<Cmd>TSJSplit<CR>', desc = 'split node'},
            {'gJ', '<Cmd>TSJJoin<CR>',  desc = 'join node'}
        },
        cmd = {'TSJSplit', 'TSJJoin'},
        opts = {
            use_default_keymaps = false
        }
    },
    {
        'chrishrb/gx.nvim',
        submodules = false,
        keys = {
            {'gx', '<Cmd>Browse<CR>', mode = {'n', 'x'}, desc = 'browse'}
        },
        cmd = {'Browse'},
        init = function()
            vim.g.netrw_nogx = true
        end,
        ---@type GxOptions
        opts = {
            open_browser_app = 'kde-open',
            handlers = {
                brewfile = false,
                cargo = {
                    name = 'cargo',
                    filename = 'Cargo.toml',
                    handle = function(mode, line)
                        local format = 'https://crates.io/crates/%s'
                        return gx_handler(mode, line, '([%w-]+)%s-=%s-', format)
                    end
                },
                pyproject = {
                    name = 'pyproject',
                    filename = 'pyproject.toml',
                    handle = function(mode, line)
                        local format = 'https://pypi.org/project/%s/'
                        local url = gx_handler(mode, line, '([%w-]+)[>~=]=', format)
                        if url then return url end
                        return gx_handler(mode, line, '([%w-]+)%[[%w,-]+%]-[>~=]=', format)
                    end
                },
                requirements = {
                    name = 'requirements',
                    filetype = {'requirements'},
                    handle = function(mode, line)
                        local format = 'https://pypi.org/project/%s/'
                        local url = gx_handler(mode, line, '([%w-]+)[>~=]=', format)
                        if url then return url end
                        return gx_handler(mode, line, '([%w-]+)%[[%w,-]+%]-[>~=]=', format)
                    end
                }
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
        -- XXX: no good alternative
        'vim-laundry/vim-lion',
        keys = {
            {'g]', mode = {'n', 'x'}, desc = 'align left'},
            {'g[', mode = {'n', 'x'}, desc = 'align right'}
        }
    }
}
