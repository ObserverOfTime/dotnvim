syn match jsSemiColon /;$/ contained keepend containedin=jsNoise

hi jsDestructuringPropertyValue ctermfg=109 guifg=#83A598
hi jsDestructuringBlock ctermfg=109 guifg=#83A598
hi jsObjectBraces ctermfg=222 guifg=#FFD787
hi jsObjectProp ctermfg=109 guifg=#83A598
hi jsFuncCall ctermfg=39 guifg=#00AFFF

hi! link jsDestructuringBraces SpecialKey
hi! link jsTernaryIfOperator Delimiter
hi! link jsGlobalNodeObjects Constant
hi! link jsOperatorKeyword Keyword
hi! link jsGlobalObjects Constant
hi! link jsObjectKey SpecialChar
hi! link jsSwitchColon Delimiter
hi! link jsObjectColon Delimiter
hi! link jsSemiColon SpecialKey
hi! link jsOperator Delimiter
hi! link jsArrowFuncArgs Type
hi! link jsFuncArgs Type
