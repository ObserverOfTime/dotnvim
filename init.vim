" Running in a proper terminal
let g:_in_term = $TERM !=? 'linux'

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
let g:loaded_ruby_provider = v:false
let g:loaded_node_provider = v:false
let g:loaded_perl_provider = v:false
" }}}

" Python host program
let g:python3_host_prog = '/usr/bin/python3'

" Zip extensions
let g:zipPlugin_ext = '*.zip,*.jar,*.war,*.cbz,*.epub,*.whl,*.aix'

" Shell folding
let g:sh_fold_enabled = 3

" TeX flavour
let g:tex_flavor = 'latex'

" C header syntax
let g:c_syntax_for_h = v:true

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_sizestyle = 'H'
let g:netrw_browse_split = 4
let g:netrw_home = stdpath('state')
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
    " Jump to last cursor position
    au BufWinEnter * try | exec 'norm g`"' | catch | endtry
    " Fix cursor on exit
    au VimLeave * set guicursor=a:hor25-blinkon500
augroup END
" }}}
