local map = vim.keymap.set

-- Clear search highlighting
map('n', ',/', '<Cmd>nohlsearch<CR>')

--#region Move up/down in wrapped text
map('n', '<UP>', 'gk')
map('n', '<DOWN>', 'gj')
--#endregion

-- Close file
map('n', '<C-q>', '<Cmd>q<CR>', {noremap = true})

-- Save file
map({'n', 'i'}, '<C-s>', '<Cmd>w<CR>', {noremap = true})

-- Fix file indentation
map('n', '<Leader><Tab>', 'mzgg=G`z', {noremap = true})

--#region Undo
map('n', '<C-z>', 'u')
map('i', '<C-z>', '<ESC>ua')
--#endregion

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

--#region Diagnostics
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<Leader>l', function()
    vim.diagnostic.setloclist {open = false}
    require('fzf-lua').loclist {}
end)
--#endregion
