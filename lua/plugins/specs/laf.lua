local c = require 'config'
local todo = c.icons.todo
local fold_char = vim.opt.fillchars:get().fold or '-'

---@type LazyPluginSpec[]
return {
    {
        'luukvbaal/statuscol.nvim',
        cond = c.in_term,
        config = function()
            local b = require 'statuscol.builtin'

            require('statuscol').setup {
                clickmod = 'a',
                segments = {
                    {
                        sign = {
                            name = {'coverage*'},
                            maxwidth = 1,
                            auto = true
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        text = {b.foldfunc},
                        click = 'v:lua.ScFa'
                    },
                    {
                        sign = {
                            name = {'.*'},
                            maxwidth = 1,
                            auto = false
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        sign = {
                            namespace = {'diagnostic'},
                            maxwidth = 1,
                            auto = true
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        sign = {
                            namespace = {'gitsign'},
                            maxwidth = 1,
                            auto = true
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        sign = {
                            name = {'Dap'},
                            maxwidth = 1,
                            auto = true
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        text = {b.lnumfunc, ' '},
                        click = 'v:lua.ScLa'
                    }
                }
            }

            vim.opt.signcolumn = 'auto:1-3'
        end
    },
    {
        'lukas-reineke/virt-column.nvim',
        cond = c.in_term,
        ---@type virtcolumn.config
        opts = {char = '│'}
    },
    {
        'bbjornstad/pretty-fold.nvim',
        cond = c.in_term,
        opts = {
            fill_char = fold_char,
            remove_fold_markers = true,
            process_comment_signs = 'delete',
            sections = {
                left = {fold_char:rep(3), 'content'},
                right = {
                    ' ', 'number_of_folded_lines',
                    ' '..fold_char:rep(2)
                }
            }
        }
    },
    {
        'prichrd/netrw.nvim',
        cond = c.in_term,
        ft = {'netrw'},
        init = function()
            vim.g.netrw_banner = 0
            vim.g.netrw_winsize = 25
            vim.g.netrw_liststyle = 3
            vim.g.netrw_sizestyle = 'H'
            vim.g.netrw_browse_split = 4
            vim.g.netrw_home = vim.fn.stdpath('state')
        end,
        opts = {
            -- TODO: add some mappings
            mappings = {}
        }
    },
    {
        'folke/todo-comments.nvim',
        lazy = false,
        keys = {
            {'<Leader>Q', '<Cmd>TodoQuickFix<CR>', desc = 'todo quickfix'}
        },
        ---@type TodoOptions
        opts = {
            keywords = {
                FIX  = {icon = todo.FIX},
                TODO = {icon = todo.TODO},
                HACK = {icon = todo.HACK},
                WARN = {icon = todo.WARN, alt = {'WARNING'}},
                PERF = {icon = todo.PERF},
                NOTE = {icon = todo.NOTE, alt = {'XXX', 'INFO'}}
            },
            highlight = {
                keyword = 'fg',
                after = ''
            }
        }
    }
}
