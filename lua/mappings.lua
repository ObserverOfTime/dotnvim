local map = vim.keymap.set

--#region Move up/down in wrapped text
map('n', '<UP>', 'gk')
map('n', '<DOWN>', 'gj')
--#endregion

-- Disable tag click
map('n', '<C-LeftMouse>', '<NOP>')

-- Clear search highlighting
map('n', '<Leader>/', '<Cmd>nohlsearch<CR>')

-- Fix file indentation
map('n', '<Leader><Tab>', [[m`gg=Gg``]])

-- Close file
map('n', '<C-q>', '<Cmd>quit<CR>', {noremap = true})

-- Save file
map({'n', 'i'}, '<C-s>', '<Cmd>write ++p<CR>', {noremap = true})

-- Undo
map({'n', 'i'}, '<C-z>', '<Cmd>undo<CR>', {noremap = true})

--#region Copy to clipboard
map('v', '<C-c>', '"+y', {noremap = true})
map('v', '<C-Insert>', '"+y', {noremap = true})
--#endregion

--#region Fix outer quote motions
map('x', [[a']], [[2i']], {noremap = true})
map('x', [[a"]], [[2i"]], {noremap = true})
map('x', [[a`]], [[2i`]], {noremap = true})
--#endregion

--#region Add more motions
map({'o', 'x'}, 'a/', ':<C-U>normal F/vf/<CR>', {silent = true})
map({'o', 'x'}, 'i/', ':<C-U>normal T/vt/<CR>', {silent = true})

map({'o', 'x'}, 'a+', ':<C-U>normal F+vf+<CR>', {silent = true})
map({'o', 'x'}, 'i+', ':<C-U>normal T+vt+<CR>', {silent = true})

map({'o', 'x'}, 'a@', ':<C-U>normal F@vf@<CR>', {silent = true})
map({'o', 'x'}, 'i@', ':<C-U>normal T@vt@<CR>', {silent = true})

map({'o', 'x'}, 'a|', ':<C-U>normal F|vf|<CR>', {silent = true})
map({'o', 'x'}, 'i|', ':<C-U>normal T|vt|<CR>', {silent = true})
--#endregion

--#region Actually delete text
map('n', 'X', 'D', {noremap = true})
map('n', 'dd', '"_dd', {noremap = true})
map({'n', 'x'}, 'd', '"_d', {noremap = true})
map({'n', 'x'}, 'D', '"_D', {noremap = true})
map({'n', 'x'}, '<Del>', '"_x', {noremap = true})
--#endregion

--#region Map Greek letters
map('n', 'ο', 'o')
map('n', 'Ο', 'O')
map('n', 'ι', 'i')
map('n', 'Ι', 'I')
map('n', 'α', 'a')
map('n', 'Α', 'A')
map('n', 'ζ=', 'z=')
map('n', 'ζγ', 'zg')
--#endregion

-- Open file explorer
map('n', '<Leader>e', '<Cmd>Lexplore<CR>')

-- Run in terminal
map('x', '<Leader>t', '<Cmd>TermExec<CR>')

-- Escape terminal
map('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

--#region Diagnostics
map('n', 'gld', vim.diagnostic.open_float, {
    desc = 'open diagnostic float'
})
map('n', '[d', function()
    vim.diagnostic.jump {count = -1, float = true}
end, {
    desc = 'go to previous diagnostic'
})
map('n', ']d', function()
    vim.diagnostic.jump {count = 1, float = true}
end, {
    desc = 'go to next diagnostic'
})
map('n', '<Leader>l', function()
    vim.diagnostic.setloclist {open = false}
    require('fzf-lua').loclist()
end, {desc = 'list diagnostics'})
--#endregion
