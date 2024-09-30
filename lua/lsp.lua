-- Disable for git mergetool
if vim.o.diff then return end

---@module 'config'
local c = package.loaded.config

--#region Diagnostics
vim.diagnostic.config {
    float = {border = 'single'},
    virtual_text = {severity = vim.diagnostic.severity.ERROR},
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = c.icons.lsp.diag.Error,
            [vim.diagnostic.severity.HINT] = c.icons.lsp.diag.Hint,
            [vim.diagnostic.severity.INFO] = c.icons.lsp.diag.Info,
            [vim.diagnostic.severity.WARN] = c.icons.lsp.diag.Warn,
        }
    }
}

for type, _ in pairs(c.icons.lsp.diag) do
    local hl = 'DiagnosticSign'..type
    vim.api.nvim_set_hl(0, hl, {link = 'Diagnostic'..type})
end
--#endregion

--#region Notifications
local levels = {'ERROR', 'WARN', 'INFO', 'DEBUG'}

---@type lsp.Handler
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    vim.notify(result.message, levels[result.type], {
        title = ('LSP (%s)'):format(client.name)
    })
end
--#endregion

--#region Clients
local lsp = vim.api.nvim_create_augroup('LSP', {clear = true})

local map = vim.keymap.set

---Configure an LSP client
---@param name string
---@param opts vim.lsp.Config
---@param enable? boolean
local function new_client(name, opts, enable)
    vim.lsp.config[name] = opts
    vim.lsp.enable(name, enable)
end

vim.lsp.config('*', {
    root_markers = {'.git'},
    capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
    )
})

new_client('bash-language-server', {
    cmd = {'bash-language-server', 'start'},
    filetypes = {'sh', 'bash'},
    root_markers = {'.git', '.bash_profile'},
    settings = {
        bashIde = {
            globPattern = '*.sh',
            shellcheckArguments = {
                '-e', 'SC1090,SC2034,SC2128,SC2148,SC2164',
                '-o', 'add-default-case,require-double-brackets'
            },
            shfmt = {
                caseIndent = true,
                simplifyCode = true,
                spaceRedirects = true
            }
        }
    }
})

new_client('clangd', {
    cmd = {
        'clangd', '--clang-tidy',
        '--header-insertion=never',
        '--completion-style=detailed'
    },
    filetypes = {'c', 'cpp'},
    root_markers = {'.clangd', 'Makefile', 'CMakeLists.txt'},
    capabilities = {
        offsetEncoding = {'utf-8', 'utf-16'},
        textDocument = {
            completion = {
                editsNearCursor = true
            }
        }
    },
    handlers = {
        ---@type lsp.Handler
        ['textDocument/switchSourceHeader'] = function(err, res)
            if err then
                vim.notify(
                    tostring(err),
                    vim.log.levels.ERROR,
                    {title = 'LSP (clangd)'}
                )
            elseif not res then
                vim.notify(
                    'Corresponding file cannot be determined',
                    vim.log.levels.WARN,
                    {title = 'LSP (clangd)'}
                )
            else
                vim.cmd.edit(vim.uri_to_fname(res))
            end
        end
    }
})

new_client('css', {
    cmd = {'vscode-css-languageserver', '--stdio'},
    filetypes = {'css', 'scss', 'less'},
    root_markers = {'package.json', '.git'},
    settings = {
        css = {validate = true},
        scss = {validate = true},
        less = {validate = true}
    }
})

new_client('djlsp', {
    cmd = {'djlsp'},
    filetypes = {'htmldjango'},
    root_markers = {'.venv', '.env'},
    init_options = {
        djlsp = {
            django_settings_module = vim.env.DJANGO_SETTINGS_MODULE
        }
    }
})

new_client('deno', {
    cmd = {'deno', 'lsp'},
    filetypes = {'typescript'},
    cmd_env = {
        NO_COLOR = true
    },
    root_markers = {'deno.json', 'deno.jsonc'},
    settings = {
        deno = {
            enable = true,
            inlayHints = {
                parameterNames = {
                    enabled = 'literals'
                },
            },
            suggest = {
                autoImports = true,
                completeFunctionCalls = true,
                names = true,
                paths = true
            },
            lint = true
        }
    }
}, false)

new_client('docker-langserver', {
    cmd = {'docker-langserver', '--stdio'},
    filetypes = {'dockerfile'},
    root_markers = {'Dockerfile'}
})

new_client('efm-langserver', {
    cmd = {
        'efm-langserver', '-c',
        vim.fn.stdpath('config')..'/efm-config.yaml'
    },
    filetypes = {
        'css', 'html', 'htmldjango', 'less',
        'lua', 'pug', 'python', 'rst', 'scss',
        'svelte', 'svg', 'vim', 'xml'
    },
    root_markers = {'.git'},
    init_options = {
        hover = false,
        codeAction = false,
        completion = false,
        documentSymbol = false
    },
})

new_client('emmet', {
    cmd = {'emmet-language-server', '--stdio'},
    filetypes = {
        'css', 'html', 'htmldjango', 'less', 'pug',
        'scss', 'stylus', 'svelte', 'svg', 'xml'
    },
    init_options = {
        showSuggestionsAsSnippets = true,
        variables = {charset = 'UTF-8'}
    }
})

new_client('eslint', {
    cmd = {'eslint-language-server', '--stdio'},
    filetypes = {'javascript', 'typescript', 'svelte'},
    root_markers = {
        'eslint.config.js',
        'eslint.config.mjs',
        'package.json'
    },
    settings = {
        run = 'onSave',
        nodePath = '',
        validate = 'on',
        probe = {
            'javascript', 'typescript', 'svelte'
        },
        workingDirectories = {
            {mode = 'location'}
        },
        experimental = {
            useFlatConfig = false
        },
        problems = {
            shortenToSingleLine = true
        },
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = 'separateLine'
            },
            showDocumentation = {
                enable = true
            }
        },
        rulesCustomizations = {}
    },
    capabilities = {
        workspace = {
            didChangeWorkspaceFolders = {
                dynamicRegistration = true
            }
        }
    },
    ---@param client vim.lsp.Client
    on_init = function(client)
        local files = {'eslint.config.js', 'eslint.config.mjs'}
        if #vim.fs.find(files, {path = client.root_dir, limit = 1}) > 0 then
            ---@diagnostic disable-next-line: inject-field
            client.config.settings.experimental.useFlatConfig = true
        end
        client:notify('workspace/didChangeConfiguration', {
            settings = client.config.settings
        })
    end,
    handlers = {
        ---@type lsp.Handler
        ['eslint/openDoc'] = function(_, result)
            if result then vim.ui.open(result.url) end
            return {}
        end,
        ---@type lsp.Handler
        ['eslint/noConfig'] = function()
            vim.notify('Missing eslint config', vim.log.levels.WARN, {
                title = 'eslint', icon = '󰱺'
            })
            return {}
        end
    }
})

new_client('esbonio', {
    cmd = {'esbonio'},
    filetypes = {'rst'},
    root_markers = {'README.rst', 'setup.py'}
})

new_client('gopls', {
    cmd = {'gopls'},
    filetypes = {'go', 'gomod'},
    root_markers = {'go.mod'},
})

new_client('html', {
    cmd = {'vscode-html-languageserver', '--stdio'},
    filetypes = {'html'},
    root_markers = {'package.json', '.git'},
    init_options = {
        provideFormatter = true,
        embeddedLanguages = {css = true, javascript = true},
        configurationSection = {'html', 'css', 'javascript'}
    }
})

new_client('json', {
    cmd = {'vscode-json-languageserver', '--stdio'},
    filetypes = {'json', 'jsonc'},
    init_options = {
        provideFormatter = true
    },
    settings = {
        json = {
            format = {
                enable = true
            },
            validate = {
                enable = true
            },
            schemas = {
                {
                    fileMatch = {'package.json'},
                    url = 'https://json.schemastore.org/package.json'
                },
                {
                    fileMatch = {'[tj]sconfig.json'},
                    url = 'https://json.schemastore.org/tsconfig.json'
                },
                {
                    fileMatch = {'tree-sitter.json'},
                    url = 'https://tree-sitter.github.io/'..
                        'tree-sitter/assets/schemas/config.schema.json'
                },
                {
                    fileMatch = {'contribute.json'},
                    url = 'https://raw.githubusercontent.com/mozilla/'..
                        'contribute.json/master/schema.json'
                },
                {
                    fileMatch = {'openapi.json'},
                    url = 'https://raw.githubusercontent.com/OAI/'..
                        'OpenAPI-Specification/main/schemas/v3.0/schema.json'
                },
                {
                    fileMatch = {'compile_commands.json'},
                    url = 'https://json.schemastore.org/compile-commands.json'
                },
                {
                    fileMatch = {'manifest.webmanifest'},
                    url = 'https://json.schemastore.org/web-manifest-combined.json'
                },
                {
                    fileMatch = {'.luarc.json'},
                    url = 'https://raw.githubusercontent.com/LuaLS/'..
                        'vscode-lua/master/setting/schema.json'
                },
                {
                    fileMatch = {'pkg.json', 'packspec.json'},
                    url = 'https://raw.githubusercontent.com/neovim/'..
                        'packspec/master/schema/packspec_schema.json'
                },
                {
                    fileMatch = {'pyrightconfig.json'},
                    url = 'https://raw.githubusercontent.com/microsoft/pyright/main/'..
                        'packages/vscode-pyright/schemas/pyrightconfig.schema.json'
                },
                {
                    fileMatch = {'grammar.json'},
                    url = 'https://raw.githubusercontent.com/tree-sitter/'..
                        'tree-sitter/master/cli/src/generate/grammar-schema.json'
                },
                {
                    fileMatch = {'deno.json', 'deno.jsonc'},
                    url = 'https://raw.githubusercontent.com/denoland/'..
                        'deno/main/cli/schemas/config-file.v1.json'
                },
                {
                    fileMatch = {'conventionalcommit.json'},
                    url = 'https://raw.githubusercontent.com/lppedd/idea-conventional-commit/'..
                        'master/src/main/resources/defaults/conventionalcommit.schema.json'
                },
                {
                    fileMatch = {'vercel.json'},
                    url = 'https://openapi.vercel.sh/vercel.json'
                }
            }
        }
    }
})

new_client('kotlin-language-server', {
    cmd = {'kotlin-language-server'},
    filetypes = {'kotlin'},
    root_markers = {
        'settings.gradle', 'settings.gradle.kts'
    },
    settings = {
        kotlin = {
            completion = {
                snippets = {
                    enabled = true
                }
            },
            indexing = {
                enabled = true
            },
            externalSources = {
                useKlsScheme = true,
                autoConvertToKotlin = false
            },
            inlayHints = {
                typeHints = true,
                parameterHints = true
            }
        }
    }
})

new_client('lemminx', {
    cmd = {'lemminx'},
    filetypes = {'xml', 'svg'},
    settings = {
        xml = {
            server = {
                workDir = vim.env.XDG_CACHE_HOME..'/lemminx'
            },
            validation = {
                noGrammar = 'ignore'
            },
            fileAssociations = {
                {
                    pattern = '**/*.svg',
                    systemId = 'https://raw.githubusercontent.com/'..
                        'dumistoklus/svg-xsd-schema/master/svg.xsd'
                },
                {
                    pattern = 'pom.xml',
                    systemId = 'https://maven.apache.org/xsd/maven-4.0.0.xsd'
                },
                {
                    pattern = 'persistence.xml',
                    systemId = 'https://www.oracle.com/webfolder/technetwork/'..
                        'jsc/xml/ns/persistence/persistence_2_2.xsd'
                },
                {
                    pattern = 'opensearch.xml',
                    systemId = 'https://gitlab.com/gitlab-org/gitlab-foss/-/'..
                        'raw/ab077b8/spec/fixtures/OpenSearchDescription.xsd'
                },
                {
                    pattern = 'ComicInfo.xml',
                    systemId = 'https://raw.githubusercontent.com/anansi-project/'..
                        'comicinfo/main/drafts/v2.1/ComicInfo.xsd'
                }
            }
        }
    }
})

new_client('ltex', {
    cmd = {'ltex-ls'},
    filetypes = {'tex'},
    root_markers = {'.latexmkrc'},
    get_language_id = function() return 'latex' end,
    settings = {
        ltex = {
            language = 'en-US',
            motherTongue = 'el-GR',
            completionEnabled = true,
            checkFrequency = 'save',
            latex = {
                commands = {
                    ['\\setmainfont[]{}'] = 'ignore',
                    ['\\setsansfont[]{}'] = 'ignore',
                    ['\\setmonofont{}'] = 'ignore',
                    ['\\setminted{}'] = 'ignore',
                    ['\\setmintedinline{}'] = 'ignore',
                    ['\\newmintinline[]{}{}'] = 'ignore',
                    ['\\newmintedfile[]{}{}'] = 'ignore',
                    ['\\titleformat{}[]{}{}{}'] = 'ignore',
                    ['\\textcolor{}'] = 'ignore',
                    ['\\nocite{}'] = 'ignore',
                    ['\\citefield{}{}'] = 'dummy',
                    ['\\acs{}'] = 'dummy',
                }
            },
            disabledRules = {
                ['en-US'] = {'REP_PASSIVE_VOICE'}
            },
            dictionary = {
                ['en-US'] = vim.fn.readfile(
                    vim.fn.stdpath('config')..'/spell/en.utf-8.add'
                )
            },
            java = {
                path = '/usr/lib/jvm/default'
            },
            ['ltex-ls'] = {
                path = '/usr/share/ltex-ls'
            }
        }
    }
})

new_client('lua-language-server', {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    root_markers = {
        '.luarc.json', '.luacheckrc', '.git'
    },
    settings = {
        Lua = {
            hint = {
                enable = true,
                paramName = 'Disable'
            },
            diagnostics = {
                disable = {'missing-fields'}
            },
            completion = {showWord = 'Disable'},
            workspace = {checkThirdParty = false}
        }
    }
})

new_client('neocmakelsp', {
    cmd = {'neocmakelsp', 'stdio'},
    filetypes = {'cmake'},
    root_markers = {'CMakeLists.txt'},
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true
            }
        }
    }
})

new_client('pyright', {
    cmd = {'pyright-langserver', '--stdio'},
    filetypes = {'python'},
    root_markers = {
        'setup.py',
        'pyproject.toml',
        'pyrightconfig.json'
    },
    settings = {
        pyright = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = 'off',
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly'
            }
        }
    }
})

new_client('r-languageserver', {
    name = 'r-languageserver',
    filetypes = {'r', 'rmd'},
    cmd = {'R', '--vanilla', '-s', '-e', 'languageserver::run()'}
}, false)

new_client('ruff', {
    cmd = {'ruff', 'server'},
    filetypes = {'python'},
    root_markers = {'pyproject.toml'},
}, false)

new_client('rust-analyzer', {
    cmd = {'rust-analyzer'},
    filetypes = {'rust'},
    root_markers = {'Cargo.toml'},
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = 'clippy'
            },
            diagnostics = {
                disabled = {
                    'inactive-code'
                }
            }
        }
    }
})

new_client('sourcekit-lsp', {
    cmd = {'sourcekit-lsp'},
    filetypes = {'swift'},
    root_markers = {'Package.swift'}
})

new_client('sqls', {
    cmd = {
        'sqls',
        '-config',
        vim.env.XDG_CONFIG_HOME..'/sqls/config.yml'
    },
    filetypes = {'sql'}
})

new_client('svelteserver', {
    cmd = {'svelteserver', '--stdio'},
    filetypes = {'svelte'},
    root_markers = {'svelte.config.js', 'package.json'}
})

new_client('taplo', {
    cmd = {'taplo', 'lsp', 'stdio'},
    filetypes = {'toml'},
    settings = {
        taplo = {
            schema = {
                catalogs = {},
                associations = {
                    ['Cargo\\.toml$'] = 'https://json.schemastore.org/Cargo.json',
                    ['pyproject\\.toml$'] = 'https://json.schemastore.org/pyproject.json'
                }
            }
        }
    }
})

new_client('texlab', {
    cmd = {'texlab'},
    filetypes = {'bib', 'tex', 'rnoweb'},
    root_markers = {'.git', '.latexmkrc'},
    ---@param client vim.lsp.Client
    on_init = function(client)
        local rc = vim.fs.find('.latexmkrc', {
            limit = 1, type = 'file'
        })[1]
        if rc ~= nil then
            ---@diagnostic disable-next-line: inject-field
            client.config.settings.texlab.build = {
                args = {'-r', rc}
            }
        end
        local aux = vim.fs.find(function(name)
            return vim.endswith(name, '.aux')
        end, {limit = 1, type = 'file'})[1]
        if aux ~= nil then
            ---@diagnostic disable-next-line: inject-field
            client.config.settings.texlab.auxDirectory = vim.fs.dirname(aux)
        end
        client:notify('workspace/didChangeConfiguration', {
            settings = client.config.settings
        })
    end,
    handlers = {
        ---@type lsp.Handler
        ['textDocument/forwardSearch'] = function(_, res)
            if res then
                vim.notify(
                    ('Search %s'):format(({
                        'Success',
                        'Error',
                        'Failure',
                        'Unconfigured'
                    })[res.status + 1]),
                    res.status + 2,
                    {title = 'LSP (texlab)'}
                )
            end
        end,
        ---@type lsp.Handler
        ['textDocument/build'] = function(_, res)
            if res then
                vim.notify(
                    ('Build %s'):format(({
                        'Success',
                        'Error',
                        'Failure',
                        'Cancelled'
                    })[res.status + 1]),
                    res.status + 2,
                    {title = 'LSP (texlab)'}
                )
            end
        end
    },
    settings = {
        texlab = {
            chktex = {
                onOpenAndSave = true
            },
            forwardSearch = {
                executable = 'zathura',
                args = {'--synctex-forward', '%l:1:%f', '%p'}
            }
        }
    }
})

new_client('ts_query_ls', {
    cmd = {'ts_query_ls'},
    filetypes = {'query'},
    root_markers = {'queries'},
    settings = {
        parser_install_directories = {
            vim.fn.stdpath('data')..'/site/lazy/nvim-treesitter/parser'
        },
        parser_aliases = {
            ecma = 'javascript'
        }
    }
})

new_client('typescript-language-server', {
    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {'javascript', 'typescript'},
    root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json'
    },
    settings = {
        diagnostics = {
            ignoredCodes = {80001}
        },
        implicitProjectConfiguration = {
            checkJs = true
        },
        javascript = {
            inlayHints = {
                includeInlayFunctionLikeReturnTypeHints = true
            }
        }
    },
    init_options = {
        hostInfo = 'neovim',
        preferences = {
            interactiveInlayHints = false,
            includeInlayFunctionParameterNameHints = 'literals'
        }
    }
})

new_client('vim-language-server', {
    cmd = {'vim-language-server', '--stdio'},
    filetypes = {'vim'},
    init_options = {
        isNeovim = true,
        iskeyword = vim.bo.iskeyword,
        snippetSupport = true,
        indexes = {
            projectRootPatterns = {'.git'}
        },
        suggest = {
            fromVimruntime = true,
            fromRuntimepath = true
        }
    }
})

new_client('yaml-language-server', {
    cmd = {'yaml-language-server', '--stdio'},
    filetypes = {'yaml'},
    settings = {
        yaml = {
            telemetry = {enabled = false},
            schemas = {
                -- FIXME: redhat-developer/yaml-language-server#422
                -- ['https://json.schemastore.org/github-issue-forms.json'] = '.github/ISSUE_TEMPLATE/*',
                ['https://json.schemastore.org/github-issue-config.json'] = '.github/ISSUE_TEMPLATE/config.yml',
                ['https://json.schemastore.org/github-discussion.json'] = '.github/DISCUSSION_TEMPLATE/*',
                ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
                ['https://json.schemastore.org/github-funding.json'] = '.github/FUNDING.yml',
                ['https://json.schemastore.org/github-action.json'] = 'action.yml',
                ['https://json.schemastore.org/dependabot-2.0.json'] = 'dependabot.yml',
                ['https://json.schemastore.org/appveyor.json'] = 'appveyor.yml',
                ['https://json.schemastore.org/jekyll.json'] = '_config.yml',
                ['https://json.schemastore.org/codecov.json'] = 'codecov.yml',
                ['https://json.schemastore.org/clangd.json'] = '.clangd',
                ['https://json.schemastore.org/clang-format.json'] = '.clang-format',
                ['https://json.schemastore.org/detekt-1.22.0.json'] = 'detekt.yml',
                ['https://json.schemastore.org/pubspec.json'] = 'pubspec.yaml',
                ['https://render.com/schema/render.yaml.json'] = 'render.yaml',
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] =
                '.gitlab-ci.yml',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
                'docker-compose.yml',
            }
        }
    }
})

new_client('zls', {
    cmd = {'zls'},
    filetypes = {'zig'},
    root_markers = {'build.zig'}
})
--#endregion

--#region LspAttach callback
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp,
    ---@param args vim.api.keyset.create_autocmd.callback_args
    callback = function(args)
        local fzf = require 'fzf-lua'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'
        vim.bo[args.buf].formatexpr = 'v:lua.vim.lsp.buf.formatexpr'

        if client:supports_method('textDocument/inlayHint', args.buf) then
            vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
            map('n', 'glH', function()
                local toggle = vim.lsp.inlay_hint.is_enabled {bufnr = args.buf}
                vim.lsp.inlay_hint.enable(not toggle, {bufnr = args.buf})
            end, {
                desc = 'toggle inlay hints', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/codeAction', args.buf) then
            map('n', 'gla', fzf.lsp_code_actions, {
                desc = 'textDocument/codeAction', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/rename', args.buf) then
            map('n', 'glr', vim.lsp.buf.rename, {
                desc = 'textDocument/rename', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/references', args.buf) then
            map('n', 'glR', fzf.lsp_references, {
                desc = 'textDocument/references', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/implementation', args.buf) then
            map('n', 'gli', vim.lsp.buf.implementation, {
                desc = 'textDocument/implementation', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/signatureHelp', args.buf) then
            map('n', 'glh', function()
                vim.lsp.buf.signature_help {border = 'single'}
            end, {desc = 'textDocument/signatureHelp', buffer = args.buf})
        end

        if client:supports_method('textDocument/typeDefinition', args.buf) then
            map('n', 'glT', vim.lsp.buf.type_definition, {
                desc = 'textDocument/typeDefinition', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/formatting', args.buf) then
            map({'n', 'v'}, 'glf', function() vim.lsp.buf.format() end, {
                desc = 'textDocument/formatting', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/documentSymbol', args.buf) then
            local outline = require 'outline'
            map('n', 'gO', outline.open_outline, {
                desc = 'symbols outline', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/declaration', args.buf) then
            map('n', 'gD', vim.lsp.buf.declaration, {
                desc = 'textDocument/declaration', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/definition', args.buf) then
            map('n', 'gd', fzf.lsp_definitions, {
                desc = 'textDocument/definition', buffer = args.buf
            })
        end

        if client:supports_method('textDocument/hover', args.buf) then
            map('n', 'K', function()
                vim.lsp.buf.hover {border = 'single'}
            end, {desc = 'textDocument/hover', buffer = args.buf})
        end

        if client:supports_method('textDocument/documentColor', args.buf) then
            require('ccc.highlighter'):enable(args.buf)
        end

        if client:supports_method('textDocument/switchSourceHeader', args.buf) then
            map('n', 'gls', function()
                local win = vim.api.nvim_get_current_win()
                local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
                client:request('textDocument/switchSourceHeader', params, nil, args.buf)
            end, {desc = 'textDocument/switchSourceHeader', buffer = args.buf})
        end

        if client.name == 'texlab' then
            map('n', 'glS', function()
                local win = vim.api.nvim_get_current_win()
                local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
                client:request('textDocument/forwardSearch', params, nil, args.buf)
            end, {desc = 'textDocument/forwardSearch', buffer = args.buf})

            map('n', 'glB', function()
                client:request('textDocument/build', {
                    textDocument = {uri = vim.uri_from_bufnr(args.buf)}
                }, nil, args.buf)
            end, {desc = 'textDocument/build', buffer = args.buf})
        end
    end
})
--#endregion

--#region LspAddWorkspace command
---@param args vim.api.keyset.create_user_command.command_args
vim.api.nvim_create_user_command('LspAddWorkspace', function(args)
    vim.lsp.buf.add_workspace_folder(args.args)
end, {nargs = 1, complete = 'dir', desc = 'add a workspace folder'})
--#endregion
