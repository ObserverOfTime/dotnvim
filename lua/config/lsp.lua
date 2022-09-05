--#region Imports
local lsp = require 'lspconfig'
local cmp = require 'cmp_nvim_lsp'
local fzf = require 'fzf-lua'
local i = require('config.icons')
--#endregion

--#region Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp.update_capabilities(capabilities)
capabilities.offsetEncoding = {'utf-16'}
--#endregion

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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {border = border})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {border = border})
--#endregion

--#region Notifications
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({'ERROR', 'WARN', 'INFO', 'DEBUG'})[result.type]
    vim.notify(result.message, lvl, {title = 'LSP ('..client.name..')'})
end
--#endregion

--#region Signs
for type, icon in pairs(i.lsp.diag) do
    local hl = 'DiagnosticSign'..type
    vim.api.nvim_set_hl(0, hl, {background = nil})
    vim.fn.sign_define(hl, {text = icon, texthl = hl})
end
--#endregion

--- Client attach callback
local function on_attach(_, bufnr)
    local get_var = vim.api.nvim_buf_get_var
    if pcall(get_var, bufnr, '_lsp_attached') then return end
    vim.api.nvim_buf_set_var(bufnr, '_lsp_attached', true)

    local map = vim.keymap.set
    local opts = {buffer = bufnr}
    local symbols = require 'symbols-outline'
    local lightbulb = require 'nvim-lightbulb'

    vim.api.nvim_create_autocmd(
        {'CursorHold', 'CursorHoldI'}, {
            callback = function()
                lightbulb.update_lightbulb {
                    sign = {enabled = false},
                    virtual_text = {
                        enabled = true,
                        text = i.lsp.hint
                    }
                }
            end, buffer = bufnr
        })

    vim.api.nvim_buf_set_option(
        bufnr, 'formatexpr', 'v:lua.vim.lsp.buf.formatexpr')

    map('n', 'gli', vim.lsp.buf.implementation, opts)
    map('n', 'glT', vim.lsp.buf.type_definition, opts)
    map('n', 'glR', vim.lsp.buf.references, opts)
    map('n', 'glr', vim.lsp.buf.rename, opts)
    map('n', 'glf', vim.lsp.buf.format, opts)
    map('n', 'glh', vim.lsp.buf.signature_help, opts)
    map('n', 'gla', fzf.lsp_code_actions, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', fzf.lsp_definitions, opts)
    map('n', 'gO', symbols.open_outline, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
end

--- Initialise Lua settings
local function lua_init(client)
    local lua_dir = (client.config.root_dir or '.')..'/lua'
    if vim.fn.isdirectory(lua_dir) == 1 then
        local luadev = require 'lua-dev.sumneko'
        local path = vim.split(package.path, ';')
        table.remove(path, 1)
        table.insert(path, 1, 'lua/?.lua')
        table.insert(path, 2, 'lua/?/init.lua')
        client.config.settings.Lua.runtime.path = path
        client.config.settings.Lua.diagnostics = {globals = {'vim'}}
        client.config.settings.Lua.workspace = {
            maxPreload = 1000,
            library = luadev.library {
                library = {
                    types = true,
                    plugins = false,
                    vimruntime = true
                }
            }
        }
        client.notify('workspace/didChangeConfiguration', {
            settings = client.config.settings
        })
    end
    return true
end

-- Initialise TexLab settings
local function texlab_init(client)
    local function find_file(args)
        local exec = 'fd --max-results 1 -d 3 '
        local res = vim.fn.systemlist(exec..args)
        return vim.tbl_isempty(res) and nil or res[1]
    end
    local rc = find_file('-H .latexmkrc')
    if rc ~= nil then
        client.config.settings.texlab.build.args = {'-r', rc}
    end
    local aux = find_file('--no-ignore -e aux')
    if aux ~= nil then
        aux = vim.fn.fnamemodify(aux, ':h')
        client.config.settings.texlab.auxDirectory = aux
    end
    client.notify('workspace/didChangeConfiguration', {
        settings = client.config.settings
    })
end

--#region bash
lsp.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd_env = {
        GLOB_PATTERN = '*.sh',
        SHELLCHECK_PATH = ''
    }
}
--#endregion

--#region Servers
lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        'clangd', '--clang-tidy',
        '--completion-style=detailed'
    },
    filetypes = {'c', 'cpp'}
}

lsp.cmake.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'vscode-css-languageserver', '--stdio'},
    filetypes = {'css', 'scss', 'less', 'stylus'}
}

lsp.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.esbonio.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.gradle_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'vscode-html-languageserver', '--stdio'}
}

lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'vscode-json-languageserver', '--stdio'},
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
                    url = 'https://raw.githubusercontent.com/mozilla/contribute.json/master/schema.json'
                },
                {
                    fileMatch = {'app.json'},
                    url = 'https://raw.githubusercontent.com/SchemaStore/schemastore/06174ef/src/schemas/json/app.json'
                },
                {
                    fileMatch = {'openapi.json'},
                    url = 'https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json'
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
                    url = 'https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json'
                },
                {
                    fileMatch = {'pyrightconfig.json'},
                    url = 'https://raw.githubusercontent.com/microsoft/pyright/main/'..
                          'packages/vscode-pyright/schemas/pyrightconfig.schema.json'
                }
            }
        }
    }
}

lsp.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        xml = {
            server = {
                workdir = vim.env.XDG_CACHE_HOME..'/lemminx'
            },
            fileAssociations = {
                {
                    pattern = '**/*.svg',
                    systemId = 'https://raw.githubusercontent.com/'..
                               'dumistoklus/svg-xsd-schema/master/svg.xsd'
                },
                {
                    pattern = 'AndroidManifest.xml',
                    systemId = 'https://gist.github.com/ObserverOfTime/'..
                               '4bd03e49a3c267281cfa88853be53b1e/raw/AndroidManifest.xsd'
                },
                {
                    pattern = 'pom.xml',
                    systemId = 'https://maven.apache.org/xsd/maven-4.0.0.xsd'
                },
                {
                    pattern = 'opensearch.xml',
                    systemId = 'https://gitlab.com/gitlab-org/gitlab-foss/-/'..
                               'raw/ab077b8/spec/fixtures/OpenSearchDescription.xsd'
                },
            }
        }
    }
}

lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = 'off',
                autoImportCompletions = true,
                useLibraryCodeForTypes = true
            }
        }
    }
}

lsp.r_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.sumneko_lua.setup {
    on_init = lua_init,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            completion = {showWord = 'Disable'}
        }
    }
}

lsp.svelte.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.texlab.setup {
    on_init = texlab_init,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set('n', 'gs', '<Cmd>TexlabForward<CR>', {buffer = bufnr})
    end,
    capabilities = capabilities,
    single_file_support = false,
    root_dir = function()
        return vim.loop.cwd()
    end,
    settings = {
        texlab = {
            forwardSearch = {
                executable = 'zathura',
                args = {'--synctex-forward', '%l:1:%f', '%p'}
            }
        }
    }
}

lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'javascript', 'typescript'}
}

lsp.vimls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lsp.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                -- FIXME: redhat-developer/yaml-language-server#422
                -- ['https://json.schemastore.org/github-issue-forms.json'] = '.github/ISSUE_TEMPLATE/*.yml',
                -- ['https://json.schemastore.org/github-issue-config.json'] = '.github/ISSUE_TEMPLATE/config.yml',
                ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
                ['https://json.schemastore.org/github-funding.json'] = '.github/FUNDING.yml',
                ['https://json.schemastore.org/github-action.json'] = 'action.yml',
                ['https://json.schemastore.org/appveyor.json'] = 'appveyor.yml',
                ['https://json.schemastore.org/jekyll.json'] = '_config.yml',
                ['https://json.schemastore.org/codecov.json'] = 'codecov.yml',
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] =
                    '.gitlab-ci.yml',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
                    'docker-compose.yml',
            }
        }
    }
}
--#endregion

--#region Null LS
require('null-ls').setup {on_attach = on_attach}
--#endregion
