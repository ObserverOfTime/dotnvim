local langs = {
    awk = {'awk'},
    bash = {'bash', 'sh'},
    bibtex = {'bibtex'},
    c = {'c'},
    cmake = {'cmake'},
    cpp = {'cpp'},
    css = {'css'},
    diff = {},
    desktop = {'desktop'},
    disassembly = {'xxd'},
    dockerfile = {'dockerfile'},
    doxygen = {},
    editorconfig = {'editorconfig'},
    git_config = {'gitconfig'},
    gitattributes = {'gitattributes'},
    gitcommit = {'gitcommit'},
    gitignore = {'gitignore'},
    go = {'go'},
    gomod = {'gomod'},
    gpg = {'gpg'},
    groovy = {'groovy'},
    hlsplaylist = {'hlsplaylist'},
    html = {'html'},
    htmldjango = {'htmldjango'},
    http = {'http'},
    -- ini = {'confini', 'dosini'},
    java = {'java'},
    javascript = {'javascript'},
    jsdoc = {},
    json = {'json'},
    jsonc = {'jsonc'},
    jq = {'jq'},
    kconfig = {'kconfig'},
    kotlin = {'kotlin'},
    latex = {'tex'},
    lua = {'lua'},
    luap = {},
    -- make = {'make'},
    markdown = {'markdown', 'rmd'},
    markdown_inline = {},
    meson = {'meson'},
    -- nginx = {'nginx'},
    pascal = {'pascal'},
    pem = {'pem'},
    perl = {'perl'},
    po = {'po'},
    powershell = {'powershell'},
    printf = {},
    properties = {'jproperties'},
    pymanifest = {'pymanifest'},
    python = {'python'},
    -- pug = {'pug'},
    query = {'query'},
    r = {'r'},
    readline = {'readline'},
    regex = {},
    requirements = {'requirements'},
    rnoweb = {'rnoweb'},
    rst = {'rst'},
    rust = {'rust'},
    scss = {'scss'},
    smali = {'smali'},
    sql = {'sql'},
    ssh_config = {'sshconfig'},
    svelte = {'svelte'},
    swift = {'swift'},
    toml = {'toml'},
    typescript = {'typescript'},
    udev = {'udevrules'},
    vim = {'vim'},
    vimdoc = {'help'},
    xcompose = {'xcompose'},
    xml = {'xml'},
    yaml = {'yaml'},
    zathurarc = {'zathurarc'},
    zig = {'zig'},
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
                pattern = vim.iter(langs):fold({}, function(acc, _, fts)
                    for _, v in pairs(fts) do
                        table.insert(acc, v)
                    end
                    return acc
                end),
                ---@param args vim.api.keyset.create_autocmd.callback_args
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
        'tree-sitter-grammars/tree-sitter-test',
        build = 'make parser/test.so',
        ft = 'test',
        dev = true
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
