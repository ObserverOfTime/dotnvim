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
                Added = {fg = '#00D700'},
                Removed = {fg = '#FF0000'},
                Changed = {fg = '#D78700'},
                WinSeparator = {fg = '#BDAE93'},
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
                Todo = {bg = 'NONE'},
                FoldColumn = {bg = 'NONE'},
                SignColumn = {bg = 'NONE'},
                diffAdded = {link = 'Added'},
                diffRemoved = {link = 'Removed'},
                diffChanged = {link = 'Changed'},
                NormalFloat = {link = 'Normal'},
                Quote = {link = 'GruvboxOrange'},
                Operator = {link = 'GruvboxGreen'},
                Delimiter = {link = 'GruvboxOrange'},
                LspInlayHint = {link = 'GruvboxBg4'},
                CSVDelimiter = {link = 'GruvboxAqua'},
                CSVColumnEven = {link = 'GruvboxGreen'},
                CSVColumnOdd = {link = 'GruvboxYellow'},
                CSVColumnHeaderEven = {link = 'GruvboxRedBold'},
                CSVColumnHeaderOdd = {link = 'GruvboxOrangeBold'},
                FocusedSymbol = {link = 'GruvboxYellowBold'},
                ['@module'] = {link = 'GruvboxAquaBold'},
                ['@type.qualifier'] = {link = 'StorageClass'},
                ['@lsp.type.class'] = {link = '@type'},
                ['@lsp.type.enum'] = {link = '@type'},
                ['@lsp.type.interface'] = {link = '@type'},
                ['@lsp.type.struct'] = {link = '@type'},
                ['@lsp.type.macro'] = {link = '@constant'},
                ['@lsp.type.namespace'] = {link = '@namespace'},
                ['@lsp.type.variable'] = {link = '@variable'},
                ['@lsp.type.keyword'] = {link = '@keyword'},
                ['@lsp.type.operator'] = {link = '@operator'},
                ['@lsp.type.string'] = {link = '@string'},
                ['@lsp.type.generic'] = {link = '@punctuation'},
                ['@lsp.type.property.kotlin'] = {link = '@none'},
                ['@lsp.type.parameter.dockerfile'] = {link = '@none'},
                ['@comment.todo.comment'] = {link = 'DiagnosticHint'},
                ['@comment.note.comment'] = {link = 'DiagnosticInfo'},
                ['@comment.warning.comment'] = {link = 'DiagnosticWarn'},
                ['@comment.error.comment'] = {link = 'DiagnosticError'},
                ['@punctuation.delimiter.test'] = {link = 'LspInlayHint'},
                ['@variable.parameter.bash'] = {link = 'Normal'},
                ['@variable.parameter.powershell'] = {link = 'Normal'},
                ['@function.rst'] = {link = 'GruvboxRed'},
                ['@markup.quote'] = {italic = true},
            }
        },
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd.colorscheme('gruvbox')
            vim.cmd.highlight({'clear', 'ColorColumn'})
        end
    }
}
