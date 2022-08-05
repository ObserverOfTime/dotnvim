if pcall(require, 'gruvbox') then
    package.loaded.gruvbox.setup {
        overrides = {
            String = {italic = false},
            Folded = {bg = '#1C1C1C'},
            Visual = {bg = '#3A3A3A'},
            MatchParen = {bg = '#303030'},
            Todo = {fg = '#D7AF5F'},
            Pmenu = {bg = '#121212'},
            PmenuSel = {
                bg = '#444444',
                fg = '#EEEEEE'
            },
            SignColumn = {bg = 'NONE'},
            GitSignsAdd = {bg = 'NONE'},
            GitSignsChange = {bg = 'NONE'},
            GitSignsDelete = {bg = 'NONE'},
            DiagnosticSignError = {bg = 'NONE'},
            DiagnosticSignWarn = {bg = 'NONE'},
            DiagnosticSignInfo = {bg = 'NONE'},
            DiagnosticSignHint = {bg = 'NONE'},
            NormalFloat = {link = 'Normal'},
            Operator = {link = 'GruvboxGreen'},
            TSOperator = {link = 'GruvboxGreen'},
            FocusedSymbol = {link = 'GruvboxYellowBold'},
            LightBulbVirtualText = {link = 'DiagnosticVirtualTextHint'}
        }
    }
    vim.api.nvim_command[[colorscheme gruvbox]]
else -- Fallback
    vim.api.nvim_command[[colorscheme desert]]
end

vim.api.nvim_command[[hi! clear ColorColumn]]
