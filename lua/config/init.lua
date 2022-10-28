local config = {}

--- Debuggable filetypes
config.debug_fts = {
    'c', 'cpp', 'python', 'java', 'javascript'
}

--- Colorable filetypes
config.color_fts = {
    'css', 'html', 'htmldjango',
    'javascript', 'less', 'pug',
    'scss', 'stylus', 'svg', 'svelte'
}

--- Text filetypes
config.text_fts = {
    'asciidoc', 'mail', 'markdown',
    'rmd', 'rnoweb', 'rst', 'tex', 'text'
}

--- LSP filetypes
config.lsp_fts = {
    'sh', 'c', 'cpp', 'css', 'scss', 'less',
    'stylus', 'dockerfile', 'groovy', 'html',
    'python', 'json', 'kotlin', 'r', 'rst',
    'lua', 'svelte', 'tex', 'bib', 'toml',
    'javascript', 'typescript', 'vim', 'yaml'
}

--- Emmet filetypes
config.emmet_fts = {
    'html', 'htmldjango', 'pug',
    'svelte', 'svg', 'xml',
    'css', 'scss', 'less'
}

-- Python host program
vim.g.python3_host_prog = '/usr/bin/python3'

-- Zip extensions
vim.g.zipPlugin_ext = '*.zip,*.jar,*.war,*.cbz,*.epub,*.whl,*.aix'

-- Shell folding
vim.g.sh_fold_enabled = 3

-- TeX flavour
vim.g.tex_flavor = 'latex'

-- C header syntax
vim.g.c_syntax_for_h = true

-- Disable FZF
vim.g.loaded_fzf = false

--#region Netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_sizestyle = 'H'
vim.g.netrw_browse_split = 4
vim.g.netrw_home = vim.fn.stdpath('state')
--#endregion

--#region Unicode
vim.g.Unicode_no_default_mappings = true
--#endregion

--#region SplitJoin
vim.g.splitjoin_quiet = 1
vim.g.splitjoin_trailing_comma = 0
vim.g.splitjoin_curly_brace_padding = 0
vim.g.splitjoin_html_attributes_hanging = 1
--#endregion

--#region Emmet
vim.g.emmet_html5 = true
vim.g.user_emmet_mode = 'i'
vim.g.user_emmet_leader_key = '<C-e>'
vim.g.user_emmet_complete_tag = true
vim.g.user_emmet_settings = {
    html = {
        empty_element_suffix = '>',
        quote_char = '"',
    },
    xml = {
        snippets = {
            ['!!!'] = '<?xml version="1.1" encoding="${charset}"?>'
        }
    },
    svelte = {
        extends = 'html',
        empty_element_suffix = '/>'
    },
    svg = {
        extends = 'xml',
        snippets = {
            ['svg'] = vim.fn.join({
                '<svg xmlns="http://www.w3.org/2000/svg">',
                '  ${cursor}',
                '</svg>'
            }, '\n')
        }
    }
}
--#endregion

--#region CSV
vim.g.csv_delim = ','
vim.g.csv_hiGroup = 'IncSearch'
vim.g.csv_no_conceal = true
vim.g.csv_strict_columns = true
--#endregion

--#region UndoTree
vim.g.undotree_HighlightChangedWithSign = false
vim.g.undotree_SetFocusWhenToggle = true
vim.g.undotree_ShortIndicators = true
vim.g.undotree_HelpLine = false
if vim.g.in_term then
    vim.g.undotree_TreeNodeShape = ''
    vim.g.undotree_TreeReturnShape = '╲'
    vim.g.undotree_TreeVertShape = '│'
    vim.g.undotree_TreeSplitShape = '╱'
end
--#endregion

--#region Discord
vim.g.discord_activate_on_enter = false
--#endregion

--- Configure Colorizer
function config:colorizer()
    require('colorizer').setup {
        filetypes = self.color_fts,
        user_default_options = {css = true}
    }
end

--- Configure VirtColumn
function config.virtcolumn()
    require('virt-column').setup {char = '│'}
    vim.api.nvim_create_autocmd('BufEnter', {
        once = true, pattern = '*',
        group = 'VirtColumnAutogroup',
        command = 'VirtColumnRefresh'
    })
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        group = 'VirtColumnAutogroup',
        callback = function()
            package.loaded['virt-column'].clear_buf(0)
        end
    })
end
-- }}}

--- Configure Notify
function config.notify()
    local notify = require 'notify'
    local icons = require 'config.icons'
    notify.setup {icons = icons.log}
    vim.notify = notify.notify
end

--- Configure Comment
function config.comment()
    local ft = require 'Comment.ft'
    require('Comment').setup()
    ft.set('pug', {'//-%s'})
    ft.set('htmldjango', {
        '{#%s#}', '{% comment %}%s{% endcomment %}'
    })
end

-- Configure AutoPairs
function config.autopairs()
    local pairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'
    pairs.setup()
    pairs.add_rules {
        Rule('{%', '%}', 'htmldjango')
            :set_end_pair_length(2)
            :replace_endpair(function() return '  %' end),
        Rule('{{', '}}', 'htmldjango')
            :set_end_pair_length(2)
            :replace_endpair(function() return '  }' end),
        Rule('$', '$', 'tex')
            :with_pair(cond.not_before_text('\\')),
        Rule('\\[', '\\]', 'tex'),
        Rule('\\(', '\\)', 'tex'),
    }
end

--- Configure GitSigns
function config.gitsigns()
    local i = require('config.icons').git
    require('gitsigns').setup {
        signs = {
            add          = {text = i.hunks.A},
            change       = {text = i.hunks.M},
            delete       = {text = i.hunks.D},
            topdelete    = {text = i.hunks.D},
            changedelete = {text = i.hunks.M}
        }
    }
end

--- Configure TodoComments
function config.todocomments()
    local i = require('config.icons').todo
    require('todo-comments').setup {
        keywords = {
            FIX  = {icon = i.FIX},
            TODO = {icon = i.TODO},
            HACK = {icon = i.HACK},
            WARN = {icon = i.WARN, alt = {'WARNING'}},
            PERF = {icon = i.PERF},
            NOTE = {icon = i.NOTE, alt = {'XXX', 'INFO'}}
        },
        highlight = {
            keyword = 'fg',
            after = ''
        }
    }
end

-- Configure PrettyFold
function config.prettyfold()
    local char = vim.opt.fillchars:get().fold or '-'

    require('pretty-fold').setup {
        fill_char = char,
        remove_fold_markers = true,
        process_comment_signs = 'delete',
        sections = {
            left = {char:rep(3), 'content'},
            right = {
                ' ', 'number_of_folded_lines',
                ' '..char:rep(2)
            }
        }
    }
end

-- Configure FZF
function config.fzf()
    local i = require 'config.icons'
    local fzf = require 'fzf-lua'
    fzf.setup {
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
                Error       = {icon = i.lsp.diag.Error, color = 'red'},
                Warning     = {icon = i.lsp.diag.Warn, color  = 'yellow'},
                Information = {icon = i.lsp.diag.Info, color  = 'cyan'},
                Hint        = {icon = i.lsp.diag.Hint, color  = 'blue'},
            }
        },
        git = {
            icons = {
              ['?'] = {icon = i.git.status.X, color = 'magenta'},
              ['A'] = {icon = i.git.status.A, color = 'green'},
              ['C'] = {icon = i.git.status.C, color = 'cyan'},
              ['D'] = {icon = i.git.status.D, color = 'red'},
              ['M'] = {icon = i.git.status.M, color = 'yellow'},
              ['R'] = {icon = i.git.status.R, color = 'cyan'},
              ['T'] = {icon = i.git.status.T, color = 'blue'},
              ['U'] = {icon = i.git.status.R, color = 'cyan'}
            }
        }
    }
    fzf.register_ui_select()
end

--- Configure symbols outline
function config.symbols()
    local i = require 'config.icons'
    require('symbols-outline').setup {
        preview_bg_highlight = 'NormalFloat',
        symbols = vim.tbl_map(function(val)
            return {icon = val}
        end, i.lsp.kind)
    }
end

--- Configure dressing
function config.dressing()
    require('dressing').setup {
        input = {winblend = 0},
        select = {enabled = false}
    }
end

--- Configure surround
function config.surround()
    require('nvim-surround').setup {
        move_cursor = false
    }
end

--- Configure coverage
function config.coverage()
    require('coverage').setup {
        commands = false,
        highlights = {
            covered   = {fg = '#00DD00'},
            uncovered = {fg = '#FF0000'}
        },
        signs = {
            covered   = {text = '▍', priority = 1},
            uncovered = {text = '▍', priority = 1}
        }
    }
end

--- Configure Neogen
function config.neogen()
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

--- Configure EditorConfig
function config.editorconfig()
    local ec = require 'editorconfig'
    -- XXX: editorconfig/editorconfig#315
    ec.properties.spell_language = function(bufnr, val)
        vim.bo[bufnr].spelllang = val
    end
end

return config
