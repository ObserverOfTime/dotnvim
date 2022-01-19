if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @luajitC syntax/c.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax region luajitC
            \ matchgroup=luaStringLongTag
            \ start=/ffi\.cdef\zs\[\[/ end=/\]\]$/
            \ keepend containedin=ALL contains=@luajitC

hi! link luaStringLongTag String
hi! link luaOperator Keyword
