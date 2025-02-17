local c = require 'config'
local hunks = c.icons.git.hunks

---@type LazyPluginSpec[]
return {
    {
        'danymat/neogen',
        cmd = {'Neogen'},
        keys = {
            {'<Leader>d', '<Cmd>Neogen<CR>', desc = 'generate docs'}
        },
        config = function()
            local py_template = vim.g.neogen_py_template or 'reST'
            require('neogen').setup {
                enable_placeholders = true,
                snippet_engine = 'snippy',
                languages = {
                    python = {
                        template = {
                            annotation_convention = py_template
                        }
                    }
                }
            }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        priority = 60,
        cond = c.in_term,
        keys = {
            {'[h',         '<Cmd>Gitsigns prev_hunk<CR>',                 desc = 'go to previous hunk'},
            {']h',         '<Cmd>Gitsigns next_hunk<CR>',                 desc = 'go to next hunk'},
            {'<Leader>gd', '<Cmd>Gitsigns diffthis<CR>',                  desc = 'view diff'},
            {'<Leader>ga', '<Cmd>Gitsigns stage_hunk<CR>',                desc = 'stage hunk'},
            {'<Leader>gr', '<Cmd>Gitsigns reset_hunk<CR>',                desc = 'reset hunk'},
            {'<Leader>gs', '<Cmd>Gitsigns select_hunk<CR>',               desc = 'select hunk'},
            {'<Leader>gp', '<Cmd>Gitsigns preview_hunk_inline<CR>',       desc = 'preview hunk'},
            {'<Leader>gb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'toggle blame'}
        },
        ---@type Gitsigns.Config
        opts = {
            signs = {
                add          = {text = hunks.A},
                change       = {text = hunks.M},
                delete       = {text = hunks.D},
                topdelete    = {text = hunks.D},
                changedelete = {text = hunks.M},
                untracked    = {text = hunks.A},
            },
            signs_staged_enable = false,
            worktrees = {{
                toplevel = vim.env.HOME,
                gitdir = vim.env.XDG_CONFIG_HOME..'/dotfiles.git'
            }}

        }
    },
    {
        'pwntester/octo.nvim',
        cmd = {'Octo'},
        cond = c.in_term,
        opts = {
            picker = 'fzf-lua',
            default_merge_method = 'rebase',
            default_to_projects_v2 = true,
            ui = {
                use_signcolumn = false,
                use_signstatus = false
            }
        },
        dependencies = {'plenary.nvim'}
    },
    {
        'ObserverOfTime/nvimcord',
        dev = true,
        enabled = c.not_mergetool,
        config = function(_, opts)
            local cwd = assert(vim.uv.cwd())
            for dir in vim.fs.parents(cwd) do
                dir = vim.fs.basename(dir)
                if dir == 'Code' or dir == 'IntelliJ' then
                    opts.autostart = true
                    break
                end
            end
            opts.log_level = vim.log.levels.DEBUG
            require('nvimcord').setup(opts)
        end
    },
    {
        'RaafatTurki/hex.nvim',
        cmd = {'HexDump', 'HexAssemble', 'HexToggle'},
        config = true
    },
    {
        -- XXX: no alternative
        'mbbill/undotree',
        keys = {
            {'<Leader>u', '<Cmd>UndotreeToggle<CR>', desc = 'toggle undotree'}
        },
        cmd = {'UndotreeToggle'},
        init = function()
            vim.g.undotree_HighlightChangedWithSign = false
            vim.g.undotree_SetFocusWhenToggle = true
            vim.g.undotree_ShortIndicators = true
            vim.g.undotree_HelpLine = false
            if vim.g._in_term then
                vim.g.undotree_TreeNodeShape = ''
                vim.g.undotree_TreeReturnShape = '╲'
                vim.g.undotree_TreeVertShape = '│'
                vim.g.undotree_TreeSplitShape = '╱'
            end
        end
    },
    {
        -- XXX: no alternative
        'tpope/vim-abolish',
        event = {'VeryLazy'},
        keys = {
            {
                'cr',
                '<Plug>(abolish-coerce-word)',
                mode = 'n',
                desc = 'coerce case (word)'
            },
            {
                'R',
                '<Plug>(abolish-coerce)',
                mode = 'v',
                desc = 'coerce case (visual)'
            }
        },
        init = function()
            vim.g.abolish_no_mappings = 1
        end,
        dependencies = {'live-command.nvim'}
    },
    {
        -- XXX: no good alternative
        'tpope/vim-fugitive'
    },
    {
        -- XXX: no good alternative
        'wsdjeg/vim-fetch'
    }
}
