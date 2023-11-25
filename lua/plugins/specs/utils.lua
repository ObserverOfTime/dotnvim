local c = require 'config'
local diag = c.icons.lsp.diag
local status = c.icons.git.status

---@type LazyPluginSpec[]
return {
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        cond = c.in_term
    },
    {
        'rcarriga/nvim-notify',
        event = {'VeryLazy'},
        ---@type notify.Config
        opts = {
            icons = c.icons.log,
            background_colour = 'Normal'
        },
        config = function(_, opts)
            local notify = require 'notify'
            notify.setup(opts)
            vim.notify = notify.notify
        end
    },
    {
        'ObserverOfTime/notifications.nvim',
        dev = true,
        lazy = true,
        module = false
    },
    {
        'stevearc/dressing.nvim',
        event = {'VeryLazy'},
        cond = c.in_term,
        opts = {
            input = {
                win_options = {winblend = 0}
            },
            select = {enabled = false}
        }
    },
    {
        'ibhagwan/fzf-lua',
        cmd = {'FzfLua'},
        keys = {
            {
                'z=',
                function()
                    require('fzf-lua').spell_suggest()
                end,
                desc = 'spell suggest'
            }
        },
        config = function(_, opts)
            local fzf = require 'fzf-lua'
            fzf.setup(opts)
            fzf.register_ui_select()
        end,
        opts = {
            fzf_bin = 'sk',
            winopts = {
                preview = {
                    wrap = 'wrap',
                    hidden = 'hidden',
                    scrollchars = {'┃', '' }
                }
            },
            keymap = {
                builtin = {
                    ['?']        = 'toggle-help',
                    ['<C-d>']    = 'toggle-fullscreen',
                    ['<C-w>']    = 'toggle-preview-wrap',
                    ['<C-p>']    = 'toggle-preview',
                    ['<S-Down>'] = 'preview-page-down',
                    ['<S-Up>']   = 'preview-page-up',
                    ['<C-r>']    = 'preview-page-reset'
                }
            },
            lsp = {
                async_or_timeout = 3000,
                icons = {
                    Error       = {icon = diag.Error, color = 'red'},
                    Warning     = {icon = diag.Warn, color  = 'yellow'},
                    Information = {icon = diag.Info, color  = 'cyan'},
                    Hint        = {icon = diag.Hint, color  = 'blue'},
                }
            },
            git = {
                icons = {
                  ['?'] = {icon = status.X, color = 'magenta'},
                  ['A'] = {icon = status.A, color = 'green'},
                  ['C'] = {icon = status.C, color = 'cyan'},
                  ['D'] = {icon = status.D, color = 'red'},
                  ['M'] = {icon = status.M, color = 'yellow'},
                  ['R'] = {icon = status.R, color = 'cyan'},
                  ['T'] = {icon = status.T, color = 'blue'},
                  ['U'] = {icon = status.R, color = 'cyan'}
                }
            }
        }
    },
    {
        'smjonas/live-command.nvim',
        lazy = true,
        main = 'live-command',
        opts = {
            commands = {
                S = {cmd = 'Subvert'}
            }
        }
    }
}
