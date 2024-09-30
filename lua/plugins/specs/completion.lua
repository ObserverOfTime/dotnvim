local c = require 'config'

---Menu format
---@param entry cmp.Entry
---@param item vim.CompletedItem
---@return vim.CompletedItem
local function format(entry, item)
    item.kind = c.icons.lsp.kind[item.kind]
    item.menu = c.icons.cmp[entry.source.name]
    return item
end

---Check if cursor is after words
local function has_words_before()
    local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
    return col ~= 0 and line:sub(col, col):match('%s') == nil
end

---Jump forward
---@param fallback fun()
local function forward(fallback)
    ---@module 'cmp'
    local cmp = package.loaded.cmp
    ---@module 'snippy'
    local snip = package.loaded.snippy

    if cmp.visible() then
        cmp.select_next_item()
    elseif snip.can_expand_or_advance() then
        snip.expand_or_advance()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end

---Jump backward
---@param fallback fun()
local function backward(fallback)
    ---@module 'cmp'
    local cmp = package.loaded.cmp
    ---@module 'snippy'
    local snip = package.loaded.snippy

    if cmp.visible() then
        cmp.select_prev_item()
    elseif snip.can_jump(-1) then
        snip.previous()
    else
        fallback()
    end
end

---async_path source
local async_path = {
    name = 'async_path',
    priority = 1,
    option = {get_cwd = vim.uv.cwd}
}

---buffer source
local buffer = {
    name = 'buffer',
    priority = 1,
    option = {
        keyword_pattern = [[\k\+]],
        get_bufnrs = function()
            return vim.tbl_map(
                vim.api.nvim_win_get_buf,
                vim.api.nvim_tabpage_list_wins(0)
            )
        end
    }
}

---@type LazyPluginSpec[]
return {
    {
        'windwp/nvim-autopairs',
        lazy = true,
        config = function()
            local pairs = require 'nvim-autopairs'
            local Rule = require 'nvim-autopairs.rule'
            local cond = require 'nvim-autopairs.conds'
            pairs.setup()
            pairs.add_rules {
                Rule('{%', '%}', 'htmldjango')
                    :set_end_pair_length(2)
                    :replace_endpair(function() return '  %' end),
                Rule('{#', '#}', 'htmldjango')
                    :set_end_pair_length(2)
                    :replace_endpair(function() return '  #' end),
                Rule('{{', '}}', 'htmldjango')
                    :set_end_pair_length(2)
                    :replace_endpair(function() return '  }' end),
                Rule('$', '$', 'tex')
                    :with_pair(cond.not_before_text('\\')),
                Rule('\\[', '\\]', 'tex'),
                Rule('\\(', '\\)', 'tex'),
            }
        end
    },
    {
        'hrsh7th/nvim-cmp',
        event = {'InsertEnter'},
        config = function()
            local cmp = require 'cmp'
            local snip = require 'snippy'
            local pairs = require 'nvim-autopairs.completion.cmp'

            cmp.setup {
                enabled = true,
                formatting = {format = format},
                completion = {keyword_length = 1},
                experimental = {
                    ghost_text = {hl_group = 'GruvboxBg4'}
                },
                mapping = cmp.mapping.preset.insert {
                    ['<CR>'] = cmp.mapping.confirm {select = false},
                    ['<Tab>'] = cmp.mapping(forward, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(backward, {'i', 's'}),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4)
                },
                snippet = {
                    expand = function(args)
                        snip.expand_snippet(args.body)
                    end
                },
                window = {
                    documentation = {
                        border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'}
                    }
                },
                sources = {
                    {
                        name = 'nvim_lsp',
                        priority = 3
                    },
                    {
                        name = 'snippy',
                        priority = 2
                    },
                    async_path,
                    buffer
                }
            }

            cmp.setup.filetype('gitcommit', {
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.order
                    }
                },
                sources = {
                    {name = 'git', priority = 2},
                    async_path,
                    buffer
                }
            })

            cmp.setup.filetype({'dap-repl'}, {
                sources = {
                    {name = 'omni', priority = 2},
                    buffer
                }
            })

            cmp.event:on('confirm_done', pairs.on_confirm_done())
        end,
        dependencies = {
            'cmp-async-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'dcampos/cmp-snippy',
            'nvim-autopairs'
        }
    },
    {
        'FelipeLema/cmp-async-path',
        lazy = true,
        url = 'https://codeberg.org/FelipeLema/cmp-async-path'
    },
    {
        'wookayin/cmp-omni',
        ft = {'dap-repl'},
        branch = 'fix-return'
    },
    {
        'petertriho/cmp-git',
        ft = {'gitcommit'},
        opts = {
            enableRemoteUrlRewrites = true,
            trigger_actions = {
                {
                    debug_name = 'git_commits',
                    trigger_character = '/',
                    action = function(sources, trigger_char, callback, params)
                        return sources.git:get_commits(callback, params, trigger_char)
                    end
                },
                {
                    debug_name = 'github_issues_and_pr',
                    trigger_character = '#',
                    action = function(sources, trigger_char, callback, _, git_info)
                        return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
                    end
                },
                {
                    debug_name = 'github_mentions',
                    trigger_character = '@',
                    action = function(sources, trigger_char, callback, _, git_info)
                        return sources.github:get_mentions(callback, git_info, trigger_char)
                    end
                }
            }
        },
        dependencies = {'plenary.nvim'}
    },
    {
        'ObserverOfTime/nvim-snippy',
        ft = {'snippets'},
        dev = true,
        config = true
    }
}
