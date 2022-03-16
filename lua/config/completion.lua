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
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
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
    mapping = {
        ['<CR>'] = cmp.mapping.confirm {select = false},
        ['<Tab>'] = cmp.mapping(forward, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(backward, {'i', 's'}),
        ['<C-x><C-o>'] = cmp.mapping.complete()
    },
    snippet = {
        expand = function(args)
            snip.expand_snippet(args.body)
        end
    },
    documentation = {
        border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'}
    },
    sources = {
        {name = 'nvim_lsp'},
        {name = 'snippy'},
        {name = 'path'},
        {
            name = 'buffer',
            option = {keyword_pattern = [[\k\+]]}
        },
        {name = 'cmp_git'}
    }
}

cmp.event:on('confirm_done', pairs.on_confirm_done())
--#endregion