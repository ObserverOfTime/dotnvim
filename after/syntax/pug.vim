if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @pugJS syntax/javascript.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syn region pugJS start=/^\z(\s*\)-\s*$/ end=/^\%(\z1\s\|\s*$\)\@!/
            \ keepend contains=@pugJS containedin=ALL
syn region pugJS start=/\z(`[^`]*\)/ end=/\(%\z1`\)\@!/
            \ keepend contains=@pugJS containedin=ALL

