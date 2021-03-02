if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @issPascal syntax/pascal.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax keyword issTypesFlags full compact custom
syntax keyword issParam ExternalSize
syntax keyword pascalStatement
            \ try except finally not and
            \ containedin=issPascal
syntax match pascalType
            \ /\c\<TArrayOf\w\+\>/
            \ containedin=issPascal
syntax region issPascal
            \ matchgroup=issDirective
            \ start=/\[Code\]/ end=/^\[\w\+\]$/
            \ keepend containedin=ALL contains=@issPascal
