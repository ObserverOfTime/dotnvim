" Delete trailing whitespace
com! DelTrail  :%s/\s\+$//e
" Copy file to clipboard
com! CopyFile  :silent w !xclip -i -sel c
" Undo git hunk
com! Gundo     :GitGutterUndoHunk
" Go to previous git hunk
com! Gprev     :GitGutterPrevHunk
" Go to next git hunk
com! Gnext     :GitGutterNextHunk
" Highlight lines longers than 80 characters
com! MaxLength :match ErrorMsg '\%>80v.\+'

" Use suda to edit/save as root
if g:os ==# 'linux' && !g:_is_uni
    com! SudoEdit  :e suda://%
    com! SudoWrite :w suda://%
endif

" Save a file creating parent directories
com! -complete=file W                 :call mkdir(expand("%:p:h"), "p") | w
" Open a REPL with the specified command
com! -complete=shellcmd -nargs=* Repl :botright 10split | terminal <args>

