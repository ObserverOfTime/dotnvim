local c = require 'config'
local kind = c.icons.lsp.kind

---@param val string
---@return {icon: string}
local function symbol(val)
    return {icon = val}
end

---@type LazyPluginSpec[]
return {
    {
        'hedyhli/outline.nvim',
        lazy = true,
        enabled = c.not_mergetool,
        opts = {
            keymaps = {
                toggle_preview = 'p'
            },
            symbols = {
                icons = vim.tbl_map(symbol, kind)
            }
        }
    },
    {
        'JosefLitos/reform.nvim',
        ft = {'bash', 'sh'},
        build = 'make',
        config = true
    },
    {
        'uga-rosa/ccc.nvim',
        lazy = true,
        enabled = c.not_mergetool,
        config = true
    }
}
