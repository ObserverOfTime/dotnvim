com! DelTrail  :%s/\s\+$//e
com! CopyFile  :silent w !xclip -i -sel c
com! VertiTab  :setl splitright | :vnew
com! HorizTab  :setl splitbelow | :new
com! Gundo     :GitGutterUndoHunk
com! Gprev     :GitGutterPrevHunk
com! Gnext     :GitGutterNextHunk
com! MaxLength :match ErrorMsg '\%>80v.\+'

if g:os ==# 'linux' && !g:_is_uni
    com! SudoEdit  :e suda://%
    com! SudoWrite :w suda://%
endif

com! -complete=file W           :call mkdir(expand("%:p:h"), "p") | w
com! -nargs=? ListLangs         :echo getcompletion(<args>, 'filetype')
com! -nargs=* Grep              :silent VSearch <q-args> %:p

