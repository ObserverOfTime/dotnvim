if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @mailHTML syntax/html.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax region mailHTML start=/<html>/ end=/<\/html>$/
            \ keepend containedin=ALL contains=@mailHTML

