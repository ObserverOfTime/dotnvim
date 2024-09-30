return {
    in_term = function()
        return vim.g._in_term
    end,

    not_mergetool = function()
        return not vim.o.diff
    end,

    icons = {
        log = {
            TRACE = '',
            DEBUG = '󰠭',
            INFO  = '',
            WARN  = '',
            ERROR = '',
            OFF   = '',
        },
        todo = {
            FIX  = '',
            TODO = '',
            HACK = '',
            WARN = '',
            PERF = '',
            NOTE = '',
        },
        git = {
            status = {
                A = '󰐙',
                C = '󰙢',
                D = '󰅚',
                M = '󰝶',
                R = '󰁗',
                T = '󰍷',
                U = '󰙧',
                X = '󰘥',
            },
            hunks = {
                A = '',
                D = '',
                I = '',
                M = '',
            }
        },
        cmp = {
            async_path = '󰝰',
            buffer     = '',
            git        = '',
            nvim_lsp   = '',
            omni       = '',
            snippy     = '',
        },
        ---@format disable-next
        tests = {
            failed  = '',
            passed  = '',
            running = '',
            skipped = '',
            unknown = '',
            running_animated = {
                '⠋', '⠙', '⠹', '⠸', '⠼',
                '⠴', '⠦', '⠧', '⠇', '⠏',
            }
        },
        lsp = {
            kind = {
                Array         = '󰅪',
                Boolean       = '',
                Class         = '󰠲',
                Color         = '󰏘',
                Constant      = '󰏿',
                Constructor   = '',
                Enum          = '󰕅',
                EnumMember    = 'ϵ',
                Event         = '󱐋',
                Field         = '󰓹',
                File          = '󰈙',
                Folder        = '󰉋',
                Function      = '󰊕',
                Interface     = '󱦜',
                Key           = '󰌋',
                Method        = '󰆧',
                Module        = '󰏖',
                Namespace     = '󰚡',
                Number        = '󰎠',
                Null          = '󰟢',
                Object        = '󰅩',
                Operator      = '󰆕',
                Property      = '',
                Reference     = '',
                Snippet       = '󰩫',
                String        = '󰀬',
                Struct        = '',
                Text          = '󰉿',
                TypeParameter = '𝙏',
                Unit          = '',
                Value         = '',
                Variable      = '󰀫',
            },
            diag = {
                Error = '󰅝',
                Warn  = '󰀪',
                Hint  = '󰌶',
                Info  = '󰋽',
            }
        }
    }
}
