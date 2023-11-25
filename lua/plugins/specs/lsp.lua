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
        'simrat39/symbols-outline.nvim',
        lazy = true,
        cond = c.not_mergetool,
        opts = {
            preview_bg_highlight = 'NormalFloat',
            symbols = vim.tbl_map(symbol, kind)
        }
    },
    {
        'barreiroleo/ltex_extra.nvim',
        lazy = true,
        cond = c.not_mergetool
    },
    {
        'JosefLitos/reform.nvim',
        ft = {'bash', 'sh'},
        build = 'make',
        config = true
    },
    {
        'folke/neodev.nvim',
        ft = {'lua'}
    },
    {
        'uga-rosa/ccc.nvim',
        lazy = true,
        cond = c.not_mergetool,
        config = true
    }
}
