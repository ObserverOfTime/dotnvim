if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @rstHTML syntax/html.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax region rstHTML start=/^\s*</ end=/>$/
            \ keepend containedin=ALL contains=@rstHTML
