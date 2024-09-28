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
        'nvim-neotest/nvim-nio',
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
        'rohit-s8/floating-input.nvim',
        event = {'VeryLazy'},
        cond = c.in_term
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
                },
                fzf = {
                    ['ctrl-w']    = 'toggle-preview-wrap',
                    ['ctrl-p']    = 'toggle-preview'
                }
            },
            previewers = {
                builtin = {
                    extensions = {
                        class = {'cfr'},
                        png = {'identify', '-verbose'},
                        jpg = {'identify', '-verbose'},
                        jpeg = {'identify', '-verbose'}
                    }
                },
                git_diff = {pager = 'diff-so-fancy'}
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
                },
                branches = {cmd = 'git branch --color'},
                bcommits = {preview_pager = 'diff-so-fancy'},
                commits = {preview_pager = 'diff-so-fancy'},
                status = {preview_pager = 'diff-so-fancy'}
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
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        opts = {
            enable_autocmd = false
        }
    }
}
