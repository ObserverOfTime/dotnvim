--#region Utilities
--- Check if file is text
local function is_text()
    local fts = require('config').text_fts
    return vim.tbl_contains(fts, vim.bo.filetype)
end

--- Check if file is CSV
local function is_csv()
    return vim.bo.filetype == 'csv'
end

--- Expandtab option
local function expandtab()
    return vim.bo.expandtab and '' or ''
end

--- Binary option
local function binary()
    return vim.bo.binary and '' or ''
end

--- Spell option
local function spell()
    return vim.wo.spell and '' or ''
end

--- Paste option
local function paste()
    return vim.go.paste and '' or ''
end

--- Trailing whitespace
local function trailing()
    local trail = vim.fn.search([[\s\+$]], 'nwc')
    return trail == 0 and '' or '✹ '..trail
end

--- Word count
local function wordcount()
    return ' '..vim.fn.wordcount().words
end

--- File mode
local function mode(name)
    return name:sub(1, 1)
end

--- File encoding
local function encoding(name)
    return name == 'utf-8' and '' or name:upper()
end

--- Clock (HH:MM)
local function clock()
    return os.date('%H:%M')
end

--- CSV column name & number
local function csv_col()
    return ('[%s%s]'):format(
        vim.fn.CSV_WCol('Name'),
        vim.fn.CSV_WCol()
    )
end

--#region Components
local comp = {
    filetype = {'filetype'},
    diagnostics = {'diagnostics'},
    mode = {'mode', fmt = mode},
    encoding = {'encoding', fmt = encoding},
    fileformat = {'fileformat', symbols = {unix = ''}},
    branch = {'b:gitsigns_head', icon = ''},
    wordcount = {wordcount, cond = is_text},
    csv_col = {csv_col, cond = is_csv},
    lines = '%{""} %L',
    column = '%v',
    filename = {
        'filename',
        path = 1,
        symbols = {
            modified = '',
            readonly = ''
        }
    },
    expandtab = expandtab,
    trailing = trailing,
    binary = binary,
    spell = spell,
    paste = paste,
    clock = clock
}
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

--#region Quickfix
require('lualine.extensions.quickfix').sections.lualine_a = {
    function()
        local loclist = vim.fn.getloclist(0, {filewinid = 1})
        return loclist.filewinid == 0 and 'Q' or 'L'
    end
}
--#endregion

--#region Clock
if not _G._clock_timer then
    local refresh = vim.schedule_wrap(function()
        vim.cmd.redrawstatus()
    end)

    _G._clock_timer = vim.loop.new_timer()
    _G._clock_timer:start(0, 3e4, refresh)
end
--#endregion

--#region Config
require('lualine').setup {
    options = {
        theme = grayscale,
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
    },
    extensions = {'quickfix'},
    sections = {
        lualine_a = {
            comp.mode,
            comp.spell,
            comp.paste
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
--#endregion
