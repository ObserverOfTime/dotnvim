" Running in a proper terminal
let g:in_term = $TERM !=? 'linux'

" Load modules {{{
lua <<EOF
vim.loader.enable()

require('settings')
require('filetypes')
require('mappings')
require('plugins')
require('lsp')
EOF
" }}}

" Disable unused providers {{{
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
" }}}

" Define custom commands {{{
" Copy file to the clipboard
command! CopyFile :silent %y+

" Delete trailing whitespace
command! DelTrail :silent %s/\s\+$//e

" Show syntax groups under cursor
command! SynStack :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

" Open a terminal with the specified command
command! -complete=shellcmd -nargs=* Term
            \ :bot 12new | let t:_repl=termopen(len(<q-args>) ? <q-args> : 'bash -l')

" Execute lines in the opened terminal
command! -range TermExec :call chansend(t:_repl, getline(<line1>, <line2>) + [''])
" }}}

" Init augroup {{{
augroup VimInit
    au!
    " Set formatoptions (:h 'formatoptions')
    au FileType * set formatoptions=cqn1j
    " Set signcolumn (:h 'signcolumn')
    au VimEnter * set signcolumn=auto:1-3
    " Jump to last cursor position
    au BufWinEnter * try | exec 'norm g`"' | catch | endtry
    " Fix cursor on exit
    au VimLeave * set guicursor=a:hor25-blinkon500
augroup END
" }}}
