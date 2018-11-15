if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @vimPython syntax/python.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax region vimPython matchgroup=vimCommand
            \ start=/^\s*py3\? << EOF/ end=/EOF/
            \ keepend containedin=ALL contains=@vimPython

