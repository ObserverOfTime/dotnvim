local langs = {
    awk = {'awk'},
    bash = {'bash', 'sh'},
    bibtex = {'bibtex'},
    c = {'c'},
    cmake = {'cmake'},
    cpp = {'cpp'},
    css = {'css'},
    diff = {},
    dockerfile = {'dockerfile'},
    gitattributes = {'gitattributes'},
    gitcommit = {'gitcommit'},
    gitignore = {'gitignore'},
    html = {'html'},
    -- htmldjango = {'htmldjango'},
    http = {'http'},
    -- ini = {'confini', 'dosini'},
    java = {'java'},
    javascript = {'javascript'},
    jsdoc = {},
    json = {'json'},
    jsonc = {'jsonc'},
    kotlin = {'kotlin'},
    latex = {'tex'},
    lua = {'lua'},
    luap = {},
    -- make = {'make'},
    markdown = {'markdown', 'rmd'},
    markdown_inline = {},
    perl = {'perl'},
    po = {'po'},
    python = {'python'},
    query = {'query'},
    r = {'r'},
    regex = {},
    rnoweb = {'rnoweb'},
    rst = {'rst'},
    rust = {'rust'},
    scss = {'scss'},
    svelte = {'svelte'},
    toml = {'toml'},
    typescript = {'typescript'},
    vim = {'vim'},
    vimdoc = {'help'},
    xml = {'xml'},
    yaml = {'yaml'},
    zathurarc = {'zathurarc'}
}

---@param buf number
local function hugefile(_, buf)
    local file = vim.api.nvim_buf_get_name(buf)
    local ok, stats = pcall(vim.loop.fs_stat, file)
    return ok and stats ~= nil and stats.size > 5e5
end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        dev = true,
        priority = 55,
        build = ':TSUpdate',
        ---@type TSConfig
        opts = {
            auto_install = false,
            indent = {
                enable = true,
                disable = hugefile
            },
            highlight = {
                enable = true,
                disable = hugefile
            },
            textobjects = {
                select = {
                    enable = true,
                    disable = hugefile,
                    keymaps = {
                        ['aB'] = '@block.outer',
                        ['iB'] = '@block.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['aa'] = '@call.outer',
                        ['ia'] = '@call.inner',
                        ['aP'] = '@parameter.outer',
                        ['iP'] = '@parameter.inner',
                        ['aI'] = '@conditional.outer',
                        ['iI'] = '@conditional.inner',
                        ['aL'] = '@loop.outer',
                        ['iL'] = '@loop.inner',
                        ['aC'] = '@comment.outer',
                        ['ar'] = '@regex.outer',
                        ['ir'] = '@regex.inner',
                        ['in'] = '@number.inner',
                    }
                },
                swap = {
                    enable = true,
                    disable = hugefile,
                    swap_next = {
                        ['gss'] = '@parameter.inner'
                    },
                    swap_previous = {
                        ['gsS'] = '@parameter.inner'
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    disable = hugefile,
                    goto_next_start = {
                        [']k'] = '@class.outer',
                        [']m'] = '@function.outer',
                        [']a'] = '@parameter.outer'
                    },
                    goto_next_end = {
                        [']K'] = '@class.outer',
                        [']M'] = '@function.outer',
                        [']A'] = '@parameter.outer'
                    },
                    goto_previous_start = {
                        ['[k'] = '@class.outer',
                        ['[m'] = '@function.outer',
                        ['[a'] = '@parameter.outer'
                    },
                    goto_previous_end = {
                        ['[K'] = '@class.outer',
                        ['[M'] = '@function.outer',
                        ['[A'] = '@parameter.outer'
                    },
                },
            },
            refactor = {
                smart_rename = {
                    enable = true,
                    disable = hugefile,
                    keymaps = {
                        smart_rename = 'gsr'
                    }
                },
                navigation = {
                    enable = true,
                    disable = hugefile,
                    keymaps = {
                        goto_definition      = 'gsd',
                        goto_next_usage      = 'gsn',
                        goto_previous_usage  = 'gsp',
                        list_definitions_toc = 'gst'
                    }
                }
            },
            ensure_installed = vim.tbl_keys(langs)
        },
        config = function(_, opts)
            vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            local ok, nvimts = pcall(require, 'nvim-treesitter.configs')
            if ok then return nvimts.setup(opts) end

            ---@diagnostic disable-next-line: redundant-parameter
            require('nvim-treesitter').setup {
                ensure_install = vim.tbl_keys(langs)
            }
            vim.opt.indentexpr = [[v:lua.require('nvim-treesitter').indentexpr()]]
            vim.api.nvim_create_autocmd('FileType', {
              pattern = vim.tbl_flatten(vim.tbl_values(langs)),
              ---@param args AutocmdArgs
              callback = function(args)
                if not hugefile('', args.buf) then
                    vim.treesitter.start(args.buf)
                end
              end
            })
        end,
        dependencies = {
            'nvim-treesitter-refactor',
            'nvim-treesitter-textobjects'
        }
    },
    {
        'nvim-treesitter/nvim-treesitter-refactor',
        dev = true,
        enabled = function()
            return pcall(require, 'nvim-treesitter.configs')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dev = true,
        enabled = function()
            return pcall(require, 'nvim-treesitter.configs')
        end
    }
}
