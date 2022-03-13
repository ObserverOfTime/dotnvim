vim.g.gruvbox_italic = true
vim.g.gruvbox_improved_warnings = true

local gruvbox = [[colorscheme gruvbox]]
if pcall(vim.api.nvim_command, gruvbox) then
    --#region Customisation
    vim.cmd[[
    hi Folded ctermbg=234 guibg=#1C1C1C
    hi Visual ctermbg=237 guibg=#3A3A3A
    hi MatchParen ctermbg=236 guibg=#303030
    hi Todo ctermfg=179 guifg=#D7AF5F
    hi Pmenu ctermbg=233 guibg=#121212
    hi PmenuSel ctermbg=238 guibg=#444444
    hi PmenuSel ctermfg=255 guifg=#EEEEEE
    hi SignColumn ctermbg=NONE guibg=NONE
    hi GitSignsAdd guibg=NONE
    hi GitSignsChange guibg=NONE
    hi GitSignsDelete guibg=NONE
    hi DiagnosticSignError guibg=NONE
    hi DiagnosticSignWarn guibg=NONE
    hi DiagnosticSignInfo guibg=NONE
    hi DiagnosticSignHint guibg=NONE
    hi! clear ColorColumn
    hi! link NormalFloat Normal
    hi! link Operator GruvboxGreen
    hi! link TSOperator GruvboxGreen
    hi! link FocusedSymbol GruvboxYellowBold
    ]]
    --#endregion
else -- Fallback
    vim.api.nvim_command[[colorscheme desert]]
end
