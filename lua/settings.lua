---Append newline to file
vim.opt.fixendofline = true
---Do smart autoindenting
vim.opt.smartindent = true
---Convert tabs to spaces
vim.opt.expandtab = true
---Save undo history to a file
vim.opt.undofile = true
---Don't wrap lines
vim.opt.wrap = false
---Show line numbers
vim.opt.number = true
---Show special characters
vim.opt.list = true
---Enable local configuration
vim.opt.exrc = true
---Use truecolor if available
vim.opt.termguicolors = vim.env.COLORTERM == 'truecolor'

---Maximum number of undoable changes
vim.opt.undolevels = 250
---Number of spaces to use for indent
vim.opt.shiftwidth = 4
---Number of spaces to use for tabs
vim.opt.softtabstop = 4
---Minimum completion menu width
vim.opt.pumwidth = 5
---Don't hide any folds
vim.opt.foldlevelstart = 99
-- Use a single statusline
vim.opt.laststatus = 3

---Default commentstring
vim.opt.commentstring = '# %s'
---Default folding method
vim.opt.foldmethod = 'marker'
---Use dark background
vim.opt.background = 'dark'
---Set colorcolumn to textwidth
vim.opt.colorcolumn = '+1'
---Set foldcolumn size
vim.opt.foldcolumn = 'auto:1'
---Show substitution preview
vim.opt.inccommand = 'nosplit'
-- Show fast spell suggestions
vim.opt.spellsuggest = 'fast'
---Disable right click menu
vim.opt.mousemodel = 'extend'
---Use ripgrep as grep
vim.opt.grepprg = [[rg -S --vimgrep --no-heading $*]]

---Enable mouse in all modes
vim.opt.mouse = 'ar'
---Short message options (`:h 'shortmess'`)
vim.opt.shortmess = 'aoOtTcF'

---Spellcheck languages
vim.opt.spelllang = {'en', 'el'}
-- Set backup directory
vim.opt.backupdir = {
    vim.fn.stdpath('state')..'/backup'
}
---Switch to open buffers or tabs
vim.opt.switchbuf = {
    'useopen', 'usetab'
}
---Grep output format (`:h 'grepformat'`)
vim.opt.grepformat = {
    '%f:%l:%c:%m', '%f:%l:%m'
}
---Display options (`:h 'display'`)
vim.opt.display = {'truncate', 'uhex'}
---Session options (`:h 'sessionoptions'`)
vim.opt.sessionoptions = {
    'buffers',
    'curdir',
    'tabpages',
    'winsize'
}
---Cursor styling (`:h 'guicursor'`)
vim.opt.guicursor = {
    'v-sm:block',
    'i-ci-ve:ver10',
    'r-o-n-c-cr:hor10'
}

--#region Special characters
if vim.g._in_term then
    ---Fill characters (`:h 'fillchars'`)
    vim.opt.fillchars = {
        vert = '┊',
        fold = '┄',
        foldsep = ' ',
        foldopen = '',
        foldclose = ''
    }
    ---List characters (`:h 'fillchars'`)
    vim.opt.listchars = {
        tab      = '‣‣',
        trail    = '·',
        nbsp     = '⍽',
        precedes = '«',
        extends  = '»'
    }
    ---Line wrap character
    vim.opt.showbreak = '↪'
else
    ---Fill characters (`:h 'fillchars'`)
    vim.opt.fillchars = {
        vert = '|',
        fold = '-',
        foldsep = ' ',
        foldopen = 'v',
        foldclose = '>'
    }
    ---List characters (`:h 'fillchars'`)
    vim.opt.listchars = {
        tab      = '>>',
        trail    = '~',
        nbsp     = '_',
        precedes = '@',
        extends  = '#'
    }
    ---Line wrap character
    vim.opt.showbreak = '^'
end
--#endregion

--#region Git mergetool overrides
if vim.o.diff then
    vim.opt.laststatus = 3
    vim.opt.foldcolumn = '0'
    vim.opt.signcolumn = 'no'
    vim.opt.colorcolumn = ''
    vim.opt.undofile = false
end
--#endregion
