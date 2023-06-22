if pcall(require, 'gruvbox') then
    package.loaded.gruvbox.setup {
        overrides = {
            GruvboxAquaBold = {bold = false},
            GruvboxGreenBold = {bold = false},
            GruvboxOrangeBold = {bold = false},
            GruvboxPurpleBold = {bold = false},
            GruvboxRedBold = {bold = false},
            GruvboxYellowBold = {bold = false},
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
            CSVDelimiter = {link = 'GruvboxAqua'},
            CSVColumnEven = {link = 'GruvboxGreen'},
            CSVColumnOdd = {link = 'GruvboxYellow'},
            CSVColumnHeaderEven = {link = 'GruvboxRedBold'},
            CSVColumnHeaderOdd = {link = 'GruvboxOrangeBold'},
            FocusedSymbol = {link = 'GruvboxYellowBold'},
            LightBulbVirtualText = {link = 'DiagnosticVirtualTextHint'},
            ['@decorator'] = {link = 'PreProc'},
            ['@namespace'] = {link = 'GruvboxAquaBold'},
            ['@lsp.type.class'] = {link = '@type'},
            ['@lsp.type.enum'] = {link = '@enum'},
            ['@lsp.type.interface'] = {link = '@type'},
            ['@lsp.type.struct'] = {link = '@type'},
            ['@lsp.type.macro'] = {link = '@constant'},
            ['@lsp.type.namespace'] = {link = '@namespace'},
            ['@lsp.type.variable'] = {link = '@variable'},
            ['@text.todo.comment'] = {link = 'DiagnosticHint'},
            ['@text.note.comment'] = {link = 'DiagnosticInfo'},
            ['@text.warning.comment'] = {link = 'DiagnosticWarn'},
            ['@text.danger.comment'] = {link = 'DiagnosticError'},
            ['@type.qualifier'] = {link = 'StorageClass'},
            ['@text.todo.checked'] = {link = 'GruvboxGreen'},
            ['@text.todo.unchecked'] = {link = 'GruvboxRed'},
            ['@parameter.bash'] = {link = 'Normal'},
            ['@function.rst'] = {link = 'GruvboxRed'},
            ['@text.quote'] = {italic = true},
        }
    }
    vim.cmd.colorscheme('gruvbox')
else -- Fallback
    vim.cmd.colorscheme('desert')
end

vim.cmd.highlight {'clear', 'ColorColumn'}
