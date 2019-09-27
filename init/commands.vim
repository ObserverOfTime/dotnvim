" Delete trailing whitespace
com! DelTrail  :%s/\s\+$//e
" Copy file to clipboard
com! CopyFile  :silent exec 'w !xclip -i -sel c'
" Undo git hunk
com! Gundo     :GitGutterUndoHunk
" Go to previous git hunk
com! Gprev     :GitGutterPrevHunk
" Go to next git hunk
com! Gnext     :GitGutterNextHunk
" Highlight lines longers than 80 characters
com! MaxLength :match ErrorMsg /\%>80v.\+/
" Show syntax highlighting groups for word under cursor
com! SynStack  :echo map(synstack(line('.'), col('.')),
            \ 'synIDattr(v:val, "name")')

" Use suda to edit/save as root
if exists('*suda#init')
    com! SudoEdit  :e suda://%
    com! SudoWrite :w suda://%
endif

" Save a file creating parent directories
com! -complete=file W :call mkdir(expand('%:p:h'), 'p') | w

" Open a REPL with the specified command
com! -complete=shellcmd -nargs=* Repl :bot 10new |
            \ :let t:_repl_id=termopen(len(<q-args>) ? <q-args> : &shell)
" Execute command in the opened REPL
com! -complete=shellcmd -nargs=+ Rcmd :call
            \ chansend(t:_repl_id, [<q-args>, ''])
