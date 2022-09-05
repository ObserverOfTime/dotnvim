local map = vim.keymap.set

-- Clear search highlighting
map('n', ',/', '<Cmd>nohlsearch<CR>')

--#region Move up/down in wrapped text
map('n', '<UP>', 'gk')
map('n', '<DOWN>', 'gj')
--#endregion

-- Close file
map('n', '<C-q>', '<Cmd>quit<CR>', {noremap = true})

-- Save file
map({'n', 'i'}, '<C-s>', '<Cmd>write<CR>', {noremap = true})

-- Undo
map({'n', 'i'}, '<C-z>', '<Cmd>undo<CR>', {noremap = true})

-- Fix file indentation
map('n', '<Leader><Tab>', 'mzgg=G`z', {noremap = true})

--#region Copy to clipboard
map('v', '<C-c>', '"+y', {noremap = true})
map('v', '<C-Insert>', '"+y', {noremap = true})
--#endregion

--#region Fix outer quote motions
map('x', [[a']], [[2i']], {noremap = true})
map('x', [[a"]], [[2i"]], {noremap = true})
map('x', [[a`]], [[2i`]], {noremap = true})
--#endregion

--#region Actually delete text
map('n', 'X', 'D', {noremap = true})
map('n', 'dd', '"_dd', {noremap = true})
map({'n', 'x'}, 'd', '"_d', {noremap = true})
map({'n', 'x'}, 'D', '"_D', {noremap = true})
map({'n', 'x'}, '<Del>', '"_x', {noremap = true})
--#endregion

-- Escape terminal
map('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

-- Open undo tree
map('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>')

-- Open todo list
map('n', '<Leader>T', '<Cmd>TodoQuickFix<CR>')

-- Generate docs
map('n', '<Leader>d', '<Cmd>Neogen<CR>')

-- Open equation preview
map('n', '<Leader>p', function()
    require('nabla').popup {border = 'rounded'}
end)

--#region Git
map('n', '[h', '<Cmd>Gitsigns prev_hunk<CR>')
map('n', ']h', '<Cmd>Gitsigns next_hunk<CR>')
map('n', '<Leader>gd', '<Cmd>Gitsigns diffthis<CR>')
map('n', '<Leader>ga', '<Cmd>Gitsigns stage_hunk<CR>')
map('n', '<Leader>gr', '<Cmd>Gitsigns reset_hunk<CR>')
map('n', '<Leader>gs', '<Cmd>Gitsigns select_hunk<CR>')
map('n', '<Leader>gb', '<Cmd>Gitsigns toggle_current_line_blame<CR>')
--#endregion

--#region Diagnostics
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<Leader>l', function()
    vim.diagnostic.setloclist {open = false}
    package.loaded['fzf-lua'].loclist()
end)
--#endregion
