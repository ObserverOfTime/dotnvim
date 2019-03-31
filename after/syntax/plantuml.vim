syn keyword Keyword scale

function! s:PlantumlClass(access, symbol) abort
    exec 'syn match plantumlClass'. a:access
                \ .' /^\s*'. a:symbol .'\s*'
                \ .'{\(static\|classifier\|abstract\)}'
                \ '\s*\w\+/ contained contains='
                \ .'plantumlStatic,plantumlAbstract'
    exec 'hi! link plantumlClass'. a:access .' Macro'
endfunction
call s:PlantumlClass('Public', '+')
call s:PlantumlClass('Private', '-')
call s:PlantumlClass('Protected', '#')
call s:PlantumlClass('PackPrivate', '\~')
syn match plantumlStatic /{\(static\|classifier\)}/ contained
syn match plantumlAbstract /{abstract}/ contained

syn match plantumlHidden /[.-]\+\[hidden\]\(up\|down\|left\|right\)[.-]\+/
syn match Identifier /\%([.-]\)\@<=|\?>/
syn match Number /\d\+\(\.\d\+\)\?/

hi plantumlStatic ctermfg=109 guifg=#83a598
hi plantumlStatic cterm=underline gui=undercurl
hi plantumlAbstract ctermfg=109 guifg=#83a598
hi plantumlAbstract cterm=italic gui=italic
hi plantumlHidden ctermfg=181 guifg=#d7afaf

hi! link plantumlStereotype Special
hi! link plantumlColonLine SpecialComment

