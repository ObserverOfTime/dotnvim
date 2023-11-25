local in_term = require('config').in_term

---@type LazyPluginSpec[]
return {
    {
        'ellisonleao/gruvbox.nvim',
        cond = in_term,
        lazy = false,
        priority = 90,
        ---@type GruvboxConfig
        opts = {
            overrides = {
                GruvboxAquaBold = {bold = false},
                GruvboxGreenBold = {bold = false},
                GruvboxOrangeBold = {bold = false},
                GruvboxPurpleBold = {bold = false},
                GruvboxRedBold = {bold = false},
                GruvboxYellowBold = {bold = false},
                DiagnosticUnnecessary = {italic = true},
                String = {italic = false},
                diffAdded = {fg = '#00D700'},
                diffRemoved = {fg = '#FF0000'},
                diffChanged = {fg = '#D78700'},
                WinBar = {bg = '#252525'},
                WinBarNC = {bg = '#353535'},
                Folded = {bg = '#1C1C1C'},
                Visual = {bg = '#3A3A3A'},
                MatchParen = {bg = '#353535'},
                Pmenu = {bg = '#121212'},
                PmenuSel = {
                    bg = '#3A3A3A',
                    fg = '#EEEEEE'
                },
                WinSeparator = {fg = '#BDAE93'},
                Todo = {bg = 'NONE'},
                FoldColumn = {bg = 'NONE'},
                SignColumn = {bg = 'NONE'},
                DiagnosticSignError = {bg = 'NONE'},
                DiagnosticSignWarn = {bg = 'NONE'},
                DiagnosticSignInfo = {bg = 'NONE'},
                DiagnosticSignHint = {bg = 'NONE'},
                DiagnosticSignOk = {bg = 'NONE'},
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
                ['@decorator'] = {link = 'PreProc'},
                ['@namespace'] = {link = 'GruvboxAquaBold'},
                ['@lsp.type.class'] = {link = '@type'},
                ['@lsp.type.enum'] = {link = '@enum'},
                ['@lsp.type.interface'] = {link = '@type'},
                ['@lsp.type.struct'] = {link = '@type'},
                ['@lsp.type.macro'] = {link = '@constant'},
                ['@lsp.type.namespace'] = {link = '@namespace'},
                ['@lsp.type.variable'] = {link = '@variable'},
                ['@lsp.type.keyword'] = {link = '@keyword'},
                ['@lsp.type.operator'] = {link = '@operator'},
                ['@lsp.type.string'] = {link = '@string'},
                ['@lsp.type.generic'] = {link = '@punctuation'},
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
        },
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd.colorscheme('gruvbox')
            vim.cmd.highlight({'clear', 'ColorColumn'})
        end
    }
}
