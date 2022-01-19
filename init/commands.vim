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
" Show syntax highlighting groups for word under cursor
com! SynStack  :echo map(synstack(line('.'), col('.')),
            \ 'synIDattr(v:val, "name")')

" Highlight lines longers than n(=80) characters
com! -nargs=? MaxLength :exec 'match ErrorMsg /\%>'.
            \ (len(<q-args>) ? <q-args> : '80') .'v.\+/'

" Save a file creating parent directories
com! -complete=file -nargs=? W :call mkdir(expand('%:p:h'), 'p') | w

" Open a REPL with the specified command
com! -complete=shellcmd -nargs=* Repl :bot 10new |
            \ :let t:_repl_id=termopen(len(<q-args>) ? <q-args> :
            \   (&shell ==# '/bin/bash' ? 'bash -l' : &shell))

" Execute command in the opened REPL
com! -complete=shellcmd -nargs=+ Rcmd :call
            \ chansend(t:_repl_id, [<q-args>, ''])
