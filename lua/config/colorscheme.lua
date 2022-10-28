if pcall(require, 'gruvbox') then
    package.loaded.gruvbox.setup {
        overrides = {
            String = {italic = false},
            WinBar = {bg = '#252525'},
            Folded = {bg = '#1C1C1C'},
            Visual = {bg = '#3A3A3A'},
            MatchParen = {bg = '#353535'},
            Pmenu = {bg = '#121212'},
            PmenuSel = {
                bg = '#444444',
                fg = '#EEEEEE'
            },
            WinSeparator = {fg = '#BDAE93'},
            FoldColumn = {bg = 'NONE'},
            SignColumn = {bg = 'NONE'},
            GitSignsAdd = {bg = 'NONE'},
            GitSignsChange = {bg = 'NONE'},
            GitSignsDelete = {bg = 'NONE'},
            DiagnosticSignError = {bg = 'NONE'},
            DiagnosticSignWarn = {bg = 'NONE'},
            DiagnosticSignInfo = {bg = 'NONE'},
            DiagnosticSignHint = {bg = 'NONE'},
            NormalFloat = {link = 'Normal'},
            Quote = {link = 'GruvboxOrange'},
            Operator = {link = 'GruvboxGreen'},
            LspInlayHint = {link = 'GruvboxBg4'},
            FocusedSymbol = {link = 'GruvboxYellowBold'},
            LightBulbVirtualText = {link = 'DiagnosticVirtualTextHint'},
            ['@text.todo'] = {link = 'DiagnosticHint'},
            ['@text.note'] = {link = 'DiagnosticInfo'},
            ['@text.warning'] = {link = 'DiagnosticWarn'},
            ['@text.danger'] = {link = 'DiagnosticError'},
            ['@type.qualifier'] = {link = 'StorageClass'},
            ['@text.mark.checked'] = {link = 'GruvboxGreen'},
            ['@text.mark.unchecked'] = {link = 'GruvboxRed'},
            ['@parameter.bash'] = {link = 'Normal'}
        }
    }
    vim.cmd.colorscheme('gruvbox')
else -- Fallback
    vim.cmd.colorscheme('desert')
end

vim.cmd.highlight {'clear', 'ColorColumn'}
