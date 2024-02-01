-- Disable for git mergetool
if vim.g._mergetool then return end

--#region Borders
local border = {
      {'┏', 'FloatBorder'},
      {'━', 'FloatBorder'},
      {'┓', 'FloatBorder'},
      {'┃', 'FloatBorder'},
      {'┛', 'FloatBorder'},
      {'━', 'FloatBorder'},
      {'┗', 'FloatBorder'},
      {'┃', 'FloatBorder'},
}

---@type vim.lsp.Handler
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {border = border}
)

---@type vim.lsp.Handler
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {border = border}
)
--#endregion

--#region Diagnostics
---@type vim.lsp.Handler
vim.lsp.handlers['textDocument/diagnostic'] = vim.lsp.diagnostic.on_diagnostic

vim.diagnostic.config {
    float = {border = 'single'},
    virtual_text = {severity = vim.diagnostic.severity.ERROR}
}

---@module 'config'
local c = package.loaded.config

for type, icon in pairs(c.icons.lsp.diag) do
    local hl = 'DiagnosticSign'..type
    vim.api.nvim_set_hl(0, hl, {link = 'Diagnostic'..type})
    vim.fn.sign_define(hl, {text = icon, texthl = hl})
end
--#endregion

--#region Notifications
local levels = {'ERROR', 'WARN', 'INFO', 'DEBUG'}

---@type vim.lsp.Handler
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    vim.notify(result.message, levels[result.type], {
        title = ('LSP (%s)'):format(client.name)
    })
end
--#endregion

--#region Clients
local lsp = vim.api.nvim_create_augroup('LSP', {clear = true})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local map = vim.keymap.set

---Create an LSP client
---@param fts string[]
---@param opts lsp.ClientConfig
---@param func? fun(client_id: integer, bufnr: integer)
local function new_client(fts, opts, func)
    if opts.root_dir == nil then return end
    vim.api.nvim_create_autocmd('FileType', {
        group = lsp,
        pattern = fts,
        ---@param args AutocmdArgs
        callback = function(args)
            local file = vim.api.nvim_buf_get_name(args.buf)
            local ok, stats = pcall(vim.loop.fs_stat, file)
            if ok and stats ~= nil and stats.size > 5e5 then return end
            local client_id = vim.lsp.start(
                vim.tbl_deep_extend('keep', opts, {
                    name = opts.cmd[1],
                    capabilities = capabilities
                })
            )
            if func and client_id then
                func(client_id, args.buf)
            end
        end
    })
end

---Find the root directory
---@param files? string[]
---@param base? boolean
---@return string
local function find_root(files, base)
    local u = require 'null-ls.utils'
    -- TODO: use vim.fs.find
    local cwd = assert(vim.uv.cwd())
    local root = u.root_pattern(unpack(files or {'.git'}))
    return root(base and vim.api.nvim_buf_get_name(0) or cwd) or cwd
end

---Find a file using fd
---@param args string
---@return string|nil
local function find_file(args)
    local exec = 'fd --max-results 1 -d 3 '
    local res = assert(vim.fn.systemlist(exec..args))
    return vim.tbl_isempty(res) and nil or res[1]
end

new_client({'sh'}, {
    cmd = {'bash-language-server', 'start'},
    settings = {
        bashIde = {
            globPattern = '*.sh',
            shellcheckArguments = {
                '-e', 'SC1090,SC2034,SC2128,SC2148,SC2164',
                '-o', 'add-default-case,require-double-brackets'
            }
        }
    },
    root_dir = find_root()
})

new_client({'c', 'cpp'}, {
    cmd = {
        'clangd', '--clang-tidy',
        '--completion-style=detailed'
    },
    root_dir = find_root({'.clangd', 'Makefile', 'CMakeLists.txt'}),
    capabilities = {
        offsetEncoding = {'utf-8', 'utf-16'},
        textDocument = {
            completion = {
                editsNearCursor = true
            }
        }
    },
    handlers = {
        ---@type vim.lsp.Handler
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
}, function(client_id, bufnr)
    local client = vim.lsp.get_client_by_id(client_id)
    if not client then
        error(('Client %d not found'):format(client_id))
    end

    vim.keymap.set('n', 'gls', function()
        ---@diagnostic disable-next-line: invisible
        client.request('textDocument/switchSourceHeader', {
            uri = vim.uri_from_bufnr(bufnr)
        }, nil, bufnr)
    end, {buffer = bufnr, desc = 'textDocument/switchSourceHeader'})
end)

new_client({'cmake'}, {
    cmd = {'neocmakelsp', 'stdio'},
    root_dir = find_root({'CMakeLists.txt'}),
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true
            }
        }
    }
})

new_client({'css', 'scss', 'less'}, {
    cmd = {'vscode-css-languageserver', '--stdio'},
    root_dir = find_root({'package.json', '.git'}),
    settings = {
        css = {validate = true},
        scss = {validate = true},
        less = {validate = true}
    }
})

new_client({'dockerfile'}, {
    cmd = {'docker-langserver', '--stdio'},
    root_dir = find_root({'Dockerfile'}, true)
})

new_client({
    'html', 'xml', 'pug',
    'css', 'less', 'scss', 'stylus',
    'htmldjango', 'svelte', 'svg'
}, {
    cmd = {'emmet-language-server', '--stdio'},
    root_dir = find_root(),
    init_options = {
        showSuggestionsAsSnippets = true,
        variables = {charset = 'UTF-8'}
    }
})

new_client({'rst'}, {
    cmd = {'esbonio'},
    root_dir = find_root({
        'README.rst', 'setup.py',
        'pyproject.toml', '.git'
    })
})

new_client({'html'}, {
    cmd = {'vscode-html-languageserver', '--stdio'},
    root_dir = find_root({'package.json', '.git'}),
    settings = {},
    init_options = {
        provideFormatter = true,
        embeddedLanguages = {css = true, javascript = true},
        configurationSection = {'html', 'css', 'javascript'}
    }
})

new_client({'json', 'jsonc'}, {
    cmd = {'vscode-json-languageserver', '--stdio'},
    root_dir = find_root(),
    init_options = {
        provideFormatter = true
    },
    settings = {
        json = {
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
                    url = 'https://raw.githubusercontent.com/sumneko/'..
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

new_client({'kotlin'}, {
    cmd = {'kotlin-language-server'},
    root_dir = find_root({'build.gradle', 'build.gradle.kts'}),
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

new_client({'xml', 'svg'}, {
    cmd = {'lemminx'},
    root_dir = find_root(),
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

new_client({'tex'}, {
    name = 'ltex',
    cmd = {'ltex-ls'},
    root_dir = find_root({'.latexmkrc'}, true),
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
                    ['\\nocite{}'] = 'ignore',
                    ['\\ktfile[]{}'] = 'ignore',
                    ['\\android{}'] = 'ignore',
                    ['\\jdk{}'] = 'ignore',
                    ['\\IfLanguageName{}{}{}'] = 'ignore',
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
}, function()
    require('ltex_extra').setup { path = '.idea/ltex' }
end)

new_client({'lua'}, {
    cmd = {'lua-language-server'},
    root_dir = find_root({'.luarc.json', 'lua', '.luacheckrc'}, true),
    ---@param client lsp.Client
    on_init = function(client)
        require('neodev.config').setup {setup_jsonls = false}
        local settings = require('neodev.luals').setup().settings
        ---@cast settings table
        table.insert(
            settings.Lua.workspace.library,
            client.config.root_dir..'/lua'
        )
        client.config.settings = vim.tbl_deep_extend(
            'keep', client.config.settings, settings
        )
        client.notify('workspace/didChangeConfiguration', {
            settings = client.config.settings
        })
    end,
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

new_client({'python'}, {
    name = 'pyright',
    cmd = {'pyright-langserver', '--stdio'},
    root_dir = find_root({
        'setup.py', 'pyproject.toml',
        'pyrightconfig.json'
    }),
    settings = {
        python = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = 'off',
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true
                }
            }
        }
    }
})

new_client({'r', 'rmd'}, {
    name = 'r-languageserver',
    root_dir = find_root(),
    cmd = {'R', '--vanilla', '-s', '-e', 'languageserver::run()'}
})

new_client({'rust'}, {
    cmd = {'rust-analyzer'},
    root_dir = find_root({'Cargo.toml'}, true),
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy'
            }
        }
    }
})

new_client({'svelte'}, {
    cmd = {'svelteserver', '--stdio'},
    root_dir = find_root({'package.json'})
})

new_client({'toml'}, {
    cmd = {'taplo', 'lsp', 'stdio'},
    root_dir = find_root(),
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

new_client({'bib', 'tex', 'rnoweb'}, {
    cmd = {'texlab'},
    root_dir = find_root({'.latexmkrc'}, true),
    ---@param client lsp.Client
    on_init = function(client)
        local rc = find_file('-H .latexmkrc')
        if rc ~= nil then
            client.config.settings.texlab.build = {
                args = {'-r', rc}
            }
        end
        local aux = find_file('--no-ignore -e aux')
        if aux ~= nil then
            aux = vim.fn.fnamemodify(aux, ':h')
            client.config.settings.texlab.auxDirectory = aux
        end
        client.notify('workspace/didChangeConfiguration', {
            settings = client.config.settings
        })
    end,
    handlers = {
        ---@type vim.lsp.Handler
        ['textDocument/forwardSearch'] = function(err, res)
            if err then
                vim.notify(
                    tostring(err),
                    vim.log.levels.ERROR,
                    {title = 'LSP (texlab)'}
                )
            else
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
        ---@type vim.lsp.Handler
        ['textDocument/build'] = function(err, res)
            if err then
                vim.notify(
                    tostring(err),
                    vim.log.levels.ERROR,
                    {title = 'LSP (texlab)'}
                )
            else
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
}, function(client_id, bufnr)
    local client = vim.lsp.get_client_by_id(client_id)
    if not client then
        error(('Client %d not found'):format(client_id))
    end

    vim.keymap.set('n', 'gls', function()
        local params = {
            textDocument = {uri = vim.uri_from_bufnr(bufnr)},
            position = {line = vim.fn.line('.') - 1, character = vim.fn.col('.')},
        }
        client.request('textDocument/forwardSearch', params, nil, bufnr)
    end, {buffer = bufnr, desc = 'textDocument/forwardSearch'})

    vim.keymap.set('n', 'glb', function()
        local params = {
            textDocument = {uri = vim.uri_from_bufnr(bufnr)}
        }
        client.request('textDocument/build', params, nil, bufnr)
    end, {buffer = bufnr, desc = 'textDocument/build'})
end)

--[[
new_client({'typescript'}, {
    cmd = {'deno', 'lsp'},
    cmd_env = {
        NO_COLOR = true
    },
    root_dir = find_root({'deno.json', 'deno.jsonc'}),
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
})
--]]

new_client({'javascript', 'typescript'}, {
    cmd = {'typescript-language-server', '--stdio'},
    root_dir = find_root({'package.json', 'tsconfig.json', 'jsconfig.json'}),
    settings = {
        javascript = {
            inlayHints = {
                includeInlayVariableTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true
            }
        }
    },
    init_options = {
        hostInfo = 'neovim'
    }
})

new_client({'vim'}, {
    cmd = {'vim-language-server', '--stdio'},
    root_dir = find_root(),
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

new_client({'yaml'}, {
    cmd = {'yaml-language-server', '--stdio'},
    root_dir = find_root(),
    settings = {
        yaml = {
            telemetry = {enabled = false},
            schemas = {
                -- FIXME: redhat-developer/yaml-language-server#422
                -- ['https://json.schemastore.org/github-issue-forms.json'] = '.github/ISSUE_TEMPLATE/*.yml',
                ['https://json.schemastore.org/github-issue-config.json'] = '.github/ISSUE_TEMPLATE/config.yml',
                ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
                ['https://json.schemastore.org/github-funding.json'] = '.github/FUNDING.yml',
                ['https://json.schemastore.org/github-action.json'] = 'action.yml',
                ['https://json.schemastore.org/appveyor.json'] = 'appveyor.yml',
                ['https://json.schemastore.org/jekyll.json'] = '_config.yml',
                ['https://json.schemastore.org/codecov.json'] = 'codecov.yml',
                ['https://json.schemastore.org/clangd.json'] = '.clangd',
                ['https://json.schemastore.org/clang-format.json'] = '.clang-format',
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] =
                    '.gitlab-ci.yml',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
                    'docker-compose.yml',
            }
        }
    }
})
--#endregion

--#region LspAttach callback
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp,
    ---@param args LspAttachArgs
    callback = function(args)
        local fzf = require 'fzf-lua'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if not vim.b[args.buf]._lsp_attached then
            vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'
            vim.bo[args.buf].formatexpr = 'v:lua.vim.lsp.buf.formatexpr'
        end

        if client.supports_method('textDocument/inlayHint', {bufnr = args.buf}) then
            vim.lsp.inlay_hint.enable(args.buf, true)
            map('n', 'glH', function()
                local toggle = vim.lsp.inlay_hint.is_enabled(args.buf)
                vim.lsp.inlay_hint.enable(args.buf, not toggle)
            end, {
                desc = 'toggle inlay hints', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/codeAction', {bufnr = args.buf}) then
            map('n', 'gla', fzf.lsp_code_actions, {
                desc = 'textDocument/codeAction', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/rename', {bufnr = args.buf}) then
            map('n', 'glr', vim.lsp.buf.rename, {
                desc = 'textDocument/rename', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/references', {bufnr = args.buf}) then
            map('n', 'glR', fzf.lsp_references, {
                desc = 'textDocument/references', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/implementation', {bufnr = args.buf}) then
            map('n', 'gli', vim.lsp.buf.implementation, {
                desc = 'textDocument/implementation', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/signatureHelp', {bufnr = args.buf}) then
            map('n', 'glh', vim.lsp.buf.signature_help, {
                desc = 'textDocument/signatureHelp', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/typeDefinition', {bufnr = args.buf}) then
            map('n', 'glT', vim.lsp.buf.type_definition, {
                desc = 'textDocument/typeDefinition', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/formatting', {bufnr = args.buf}) then
            map({'n', 'v'}, 'glf', function() vim.lsp.buf.format() end, {
                desc = 'textDocument/formatting', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/documentSymbol', {bufnr = args.buf}) then
            local symbols = require 'symbols-outline'
            map('n', 'gO', symbols.open_outline, {
                desc = 'symbols outline', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/declaration', {bufnr = args.buf}) then
            map('n', 'gD', vim.lsp.buf.declaration, {
                desc = 'textDocument/declaration', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/definition', {bufnr = args.buf}) then
            map('n', 'gd', fzf.lsp_definitions, {
                desc = 'textDocument/definition', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/hover', {bufnr = args.buf}) then
            map('n', 'K', vim.lsp.buf.hover, {
                desc = 'textDocument/hover', buffer = args.buf
            })
        end

        if client.supports_method('textDocument/documentColor', {bufnr = args.buf}) then
            require('ccc.highlighter').new(false):enable(args.buf)
        end

        vim.b[args.buf]._lsp_attached = true
    end
})
--#endregion

--#region LspAddWorkspace command
---@param args CommandArgs
vim.api.nvim_create_user_command('LspAddWorkspace', function(args)
    vim.lsp.buf.add_workspace_folder(args.args)
end, {
    nargs = 1, complete = 'dir',
    desc = 'add a workspace folder'
})
--#endregion
