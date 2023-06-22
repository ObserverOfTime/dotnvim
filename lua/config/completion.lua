--#region Imports
local cmp = require 'cmp'
local snip = require 'snippy'
local pairs = require 'nvim-autopairs.completion.cmp'
local i = require 'config.icons'
--#endregion

--#region Utilities
--- Menu format
local function format(entry, item)
    item.kind = i.lsp.kind[item.kind]
    item.menu = i.cmp[entry.source.name]
    return item
end

--- Check if cursor is after words
local function has_words_before()
    local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
    return col ~= 0 and line:sub(col, col):match('%s') == nil
end

--- Jump forward
local function forward(fallback)
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

--- Jump backward
local function backward(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif snip.can_jump(-1) then
        snip.previous()
    else
        fallback()
    end
end
--#endregion

--#region Config
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
        ['<C-Space>'] = cmp.mapping.complete {},
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
        {name = 'nvim_lsp'},
        {name = 'snippy'},
        {
            name = 'path',
            option = {get_cwd = vim.loop.cwd}
        },
        {
            name = 'buffer',
            option = {
                keyword_pattern = [[\k\+]],
                get_bufnrs = function()
                    return vim.tbl_map(
                        vim.api.nvim_win_get_buf,
                        vim.api.nvim_tabpage_list_wins(0)
                    )
                end
            },
        }
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
        {name = 'git'},
        {name = 'path'},
        {name = 'buffer'}
    }
})

cmp.event:on('confirm_done', pairs.on_confirm_done())
--#endregion

--#region Git
if _G['packer_plugins']['cmp-git'].loaded then
    require('cmp_git').setup {
        enableRemoteUrlRewrites = true
    }
end
--#endregion
