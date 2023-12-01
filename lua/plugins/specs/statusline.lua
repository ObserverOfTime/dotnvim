--#region Utilities
local in_term = require('config').in_term

local text_fts = {
    'asciidoc', 'mail', 'markdown',
    'rmd', 'rnoweb', 'rst', 'tex', 'text'
}

---Check if file is text
local function is_text()
    return vim.tbl_contains(text_fts, vim.bo.filetype)
end

---Check if file is CSV
local function is_csv()
    return vim.bo.filetype == 'csv'
end

---Check if file is writable
local function is_writable()
    return not vim.bo.readonly
end

---Expandtab option
local function expandtab()
    return vim.bo.expandtab and '' or '󰌒'
end

---Binary option
local function binary()
    return vim.bo.binary and '' or ''
end

---Spell option
local function spell()
    return vim.wo.spell and '󰍕' or ''
end

---Trailing whitespace
local function trailing()
    local trail = vim.fn.search([[\s\+$]], 'nwc')
    return trail == 0 and '' or '✹ '..trail
end

---Word count
local function wordcount()
    return '󰈭 '..vim.fn.wordcount().words
end

---CSV column name & number
local function csv_col()
    return ('[%s%s]'):format(
        vim.fn.CSV_WCol('Name'),
        vim.fn.CSV_WCol()
    )
end

---Clock (HH:MM)
local function clock()
    return os.date('%H:%M')
end

---File mode
---@param name string
local function mode(name)
    return ({
        ['NORMAL'] = '',
        ['VISUAL'] = '',
        ['INSERT'] = '',
        ['COMMAND'] = '',
        ['REPLACE'] = '',
        ['TERMINAL'] = '',
        ['O-PENDING'] = '',
        ['V-LINE'] = '',
        ['V-BLOCK'] = '',
        ['V-REPLACE'] = '',
        ['SELECT'] = '',
        ['V-SELECT'] = '',
        ['S-LINE'] = '',
        ['S-BLOCK'] = '',
        ['EX'] = '',
        ['MORE'] = '󰍻',
        ['CONFIRM'] = '',
        ['SHELL'] = '',
    })[name]
end

---File encoding
---@param name string
local function encoding(name)
    return name == 'utf-8' and '' or name:upper()
end
--#endregion

--#region Click handlers
---Diagnostics click handler
local function diagnostics_click()
    require('fzf-lua').diagnostics_document()
end

---Branch click handler
local function branch_click()
    require('fzf-lua').git_commits()
end

---Filename click handler
local function filename_click()
    require('fzf-lua').files()
end
--#endregion

--#region Components
local comp = {
    filetype = {'filetype'},
    mode = {'mode', fmt = mode},
    encoding = {'encoding', fmt = encoding},
    fileformat = {'fileformat', symbols = {unix = ''}},
    expandtab = {expandtab, cond = is_writable},
    trailing = {trailing, cond = is_writable},
    wordcount = {wordcount, cond = is_text},
    csv_col = {csv_col, cond = is_csv},
    lines = '%{""} %L',
    column = '%v',
    diagnostics = {
        'diagnostics',
        on_click = diagnostics_click
    },
    branch = {
        'FugitiveHead',
        icon = '',
        on_click = branch_click
    },
    filename = {
        'filename',
        path = 1,
        symbols = {
            new = '',
            unnamed = '',
            modified = '',
            readonly = ''
        },
        on_click = filename_click
    },
    binary = binary,
    spell = spell,
    clock = clock
}
--#endregion

--#region Quickfix extension
local quickfix = {
    filetypes = {'qf'},
    sections = {}
}

quickfix.init = function()
  vim.g.qf_disable_statusline = true
end

quickfix.sections.lualine_a = {
    ---Quickfix/loclist mode
    function()
        local loclist = vim.fn.getloclist(0, {filewinid = 1})
        return loclist.filewinid == 0 and '󰁨' or ''
    end
}

quickfix.sections.lualine_b = {
    function()
        local loclist = vim.fn.getloclist(0, {filewinid = 1})
        if loclist.filewinid == 0 then
            return vim.fn.getqflist({ title = 0 }).title
        end
        return vim.fn.getloclist(0, {title = 0}).title
    end
}

quickfix.sections.lualine_y = {'%{""} %l'}

quickfix.sections.lualine_z = {clock}
--#endregion

--#region Lazy extension
local lazy = {
    filetypes = {'lazy'},
    sections = {}
}

lazy.sections.lualine_a = {'%{"󰒲"}'}

lazy.sections.lualine_b = {
    ---Lazy plugin count
    function()
        local stats = require('lazy').stats()
        return ('󱐥 %d/%d'):format(stats.loaded, stats.count)
    end,
    {
        ---Lazy plugins to be updated
        function()
            ---@module 'lazy.manage.checker'
            local checker = package.loaded['lazy.manage.checker']
            return ('󰚰 %d'):format(#checker.updated)
        end,
        cond = function()
            local checker = require('lazy.manage.checker')
            checker.fast_check {report = false}
            return #checker.updated > 0
        end
    }
}

lazy.sections.lualine_y = {
    ---Lazy startup time
    function()
        local time = require('lazy').stats().startuptime
        return ('󰔛 %.3fs'):format(time / 1e3)
    end
}

lazy.sections.lualine_z = {clock}
--#endregion

--#region FZF extension
local fzf = {
    filetypes = {'fzf'},
    sections = {}
}

fzf.sections.lualine_a = {'%{"󱈅"}'}

fzf.sections.lualine_b = {
    ---FZF picker
    function()
        return require('fzf-lua').get_info().fnc or ''
    end
}

fzf.sections.lualine_c = {
    ---FZF selected entry
    function()
        local info = require('fzf-lua').get_info()
        return info.fnc ~= 'diagnostics' and info.selected or ''
    end
}

fzf.sections.lualine_z = {clock}
--#endregion

--#region DAP extension
local dap = {
    filetypes = {
        'dap-repl',
        'dapui_console',
        'dapui_watches',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_scopes',
    },
    sections = {}
}

dap.sections.lualine_a = {
    function()
        return ({
            ['dap-repl'] = '',
            ['dapui_console'] = '',
            ['dapui_stacks'] = '',
            ['dapui_scopes'] = '',
            ['dapui_watches'] = '',
            ['dapui_breakpoints'] = ''
        })[vim.bo.filetype]
    end
}

dap.sections.lualine_b = {
    ---DAP adapter name
    function()
        local session = require('dap').session()
        return session and session.config.name or ''
    end
}

dap.sections.lualine_c = {
    ---DAP current file
    function()
        local session = require('dap').session()
        if not session or not session.current_frame
            or not session.current_frame.source then
            return ''
        end
        return session.current_frame.source.name
    end
}

dap.sections.lualine_x = {
    ---DAP filetype
    function()
        local session = require('dap').session()
        if not session then return '' end
        local ft = session.filetype
        ---@module 'nvim-web-devicons'
        local icons = package.loaded['nvim-web-devicons']
        return ('%s %s'):format(icons.get_icon_by_filetype(ft), ft)
    end
}

dap.sections.lualine_y = {
    ---DAP current line
    function()
        local session = require('dap').session()
        if not session or not session.current_frame then
            return ''
        end
        return (' %d'):format(session.current_frame.line)
    end,
    ---DAP current column
    function()
        local session = require('dap').session()
        if not session or not session.current_frame then
            return ''
        end
        return (' %d'):format(session.current_frame.column)
    end
}

dap.sections.lualine_z = {clock}
--#endregion

--#region Man extension
local man = {
    filetypes = {'man'},
    sections = {}
}

man.sections.lualine_a = {'%{"󰧮"}'}

man.sections.lualine_b = {
    {'filename', file_status = false}
}

man.sections.lualine_z = {clock}
--#endregion

--#region Netrw extension
local netrw = {
    filetypes = {'netrw'},
    sections = {}
}

netrw.sections.lualine_a = {'%{"󰙅"}'}

netrw.sections.lualine_b = {
    {'filename', file_status = false}
}

netrw.sections.lualine_c = {{
    'b:netrw_curdir',
    ---@param name string
    fmt = function(name)
        return vim.fn.fnamemodify(name, ':~:.')
    end
}}

netrw.sections.lualine_z = {clock}
--#endregion

--#region Theme
local grayscale = {
  normal = {
    a = {bg = '#8E8E8E', fg = '#252525'},
    b = {bg = '#464646', fg = '#E3E3E3'},
    c = {bg = '#252525', fg = '#999999'}
  },
  insert = {
    a = {bg = '#686868', fg = '#252525'},
    b = {bg = '#464646', fg = '#E3E3E3'},
    c = {bg = '#252525', fg = '#999999'}
  },
  visual = {
    a = {bg = '#747474', fg = '#252525'},
    b = {bg = '#464646', fg = '#E3E3E3'},
    c = {bg = '#252525', fg = '#999999'}
  },
  replace = {
    a = {bg = '#7C7C7C', fg = '#252525'},
    b = {bg = '#464646', fg = '#E3E3E3'},
    c = {bg = '#252525', fg = '#999999'}
  },
  command = {
    a = {bg = '#8E8E8E', fg = '#252525'},
    b = {bg = '#252525', fg = '#999999'},
    c = {bg = '#464646', fg = '#E3E3E3'}
  },
  inactive = {
    a = {bg = '#252525', fg = '#B9B9B9'},
    b = {bg = '#252525', fg = '#B9B9B9'},
    c = {bg = '#252525', fg = '#B9B9B9'}
  }
}
--#endregion

---@type LazyPluginSpec[]
return {
    {
        'nvim-lualine/lualine.nvim',
        cond = in_term,
        opts = {
            options = {
                theme = grayscale,
                component_separators = {left = '', right = ''},
                section_separators = {left = '', right = ''}
            },
            extensions = {
                lazy, quickfix, fzf, dap, man, netrw
            },
            sections = {
                lualine_a = {
                    comp.mode,
                    comp.spell,
                },
                lualine_b = {
                    comp.branch,
                    comp.diagnostics
                },
                lualine_c = {
                    comp.filename,
                    comp.csv_col
                },
                lualine_x = {
                    comp.filetype,
                    comp.encoding,
                    comp.fileformat,
                    comp.binary
                },
                lualine_y = {
                    comp.expandtab,
                    comp.trailing,
                    comp.wordcount
                },
                lualine_z = {
                    comp.lines,
                    comp.column,
                    comp.clock
                }
            },
            inactive_sections = {
                lualine_c = {comp.filename}
            }
        }
    }
}
