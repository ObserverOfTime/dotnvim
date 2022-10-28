" Running in a proper terminal
let g:in_term = $TERM !=? 'linux'

" Load modules {{{
lua <<EOF
require('settings')
require('filetypes')
require('mappings')
require('plugins')
require('lsp')
EOF
" }}}

" Define custom commands {{{
" Copy file to the clipboard
command! CopyFile :silent w !xclip -i -sel c

" Delete trailing whitespace
command! DelTrail :silent %s/\s\+$//e

" Show syntax groups under cursor
command! SynStack :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

" Open a terminal with the specified command
command! -complete=shellcmd -nargs=* Term
            \ :bot 12new | let t:_repl=termopen(len(<q-args>) ? <q-args> : "bash -l")

" Execute lines in the opened terminal
command! -range TermExec :call chansend(t:_repl, getline(<line1>, <line2>) + [''])
" }}}

" Source local .nvimrc {{{
" WARNING: This can be a security vulnerability.
" When editing files from an untrusted source,
" always check the directories for .nvimrc
" files and verify their contents.
function! s:SourceRC()
    " Abort if running as root
    if $USER ==# 'root' | return | endif
    if get(g:, '_exrc', '') !=# '' | return | endif
    let l:exrc = fnamemodify(findfile('.nvimrc', '.;'), ':p')
    if l:exrc ==# '' | return | endif
    if filereadable(l:exrc)
        exec 'source '. l:exrc
        let g:_exrc = l:exrc
    endif
endfunction
" }}}

" Init augroup {{{
augroup VimInit
    au!
    " Source .nvimrc on enter
    au VimEnter * call <SID>SourceRC()
    " Set formatoptions (:h 'formatoptions')
    au BufEnter * set formatoptions=cqn1j
    " Jump to last cursor position
    au BufWinEnter * try | exec 'norm g`"' | catch | endtry
    " Fix cursor on exit
    au VimLeave * set guicursor=a:hor25
augroup END
" }}}
