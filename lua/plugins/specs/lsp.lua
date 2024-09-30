local c = require 'config'
local kind = c.icons.lsp.kind

---@param val string
---@return {icon: string}
local function symbol(val)
    return {icon = val}
end

---@type LazyPluginSpec[]
return {
    {
        'hedyhli/outline.nvim',
        lazy = true,
        enabled = c.not_mergetool,
        opts = {
            keymaps = {
                toggle_preview = 'p'
            },
            symbols = {
                icons = vim.tbl_map(symbol, kind)
            }
        }
    },
    {
        'JosefLitos/reform.nvim',
        ft = {'bash', 'sh'},
        build = 'make',
        config = true
    },
    {
        'uga-rosa/ccc.nvim',
        lazy = true,
        enabled = c.not_mergetool,
        config = true
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = {'java'},
        enabled = c.not_mergetool,
        config = function(_, opts)
            opts.root_dir = vim.fs.root(0, {'pom.xml', 'build.gradle.kts'})
            require('jdtls').start_or_attach(opts)
        end,
        opts = {
            cmd = {'jdtls'},
            init_options = {
                bundles = {
                    '/usr/share/java-debug/com.microsoft.java.debug.plugin.jar'
                }
            },
            settings = {
                java = {
                    configuration = {
                        maven = {
                            userSettings = vim.env.XDG_CONFIG_HOME..'/maven/settings.xml'
                        }
                    },
                    import = {
                        maven = {
                            enabled = true
                        },
                        gradle = {
                            enabled = true,
                            home = vim.env.GRADLE_USER_HOME
                        }
                    },
                    runtimes = {
                        {
                            name = 'JavaSE-11',
                            path = '/usr/lib/jvm/java-11-openjdk'
                        },
                        {
                            name = 'JavaSE-17',
                            path = '/usr/lib/jvm/java-17-openjdk'
                        },
                        {
                            name = 'JavaSE-23',
                            path = '/usr/lib/jvm/java-23-openjdk'
                        }
                    }
                }
            }
        },
        dependencies = {'nvim-dap'}
    }
}
