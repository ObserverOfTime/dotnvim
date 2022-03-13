if exists("b:current_syntax")
  finish
endif

syntax case match

syn match assSection       "^\[.*\]"
syn match assSourceComment "^;.*$"
syn match assLine          "^[^;][^:]*:.*$"  contains=assHeader,assComment,assDialog
syn match assHeader        "^[^;][^:]*:\s*"  contained nextgroup=assHeaderText
syn match assHeaderText    ".*$"             contained
syn match assComment       "^Comment:\s*"    contained nextgroup=assCommentText
syn match assCommentText   ".*$"             contained
syn match assDialog        "^Dialogue:\s*"   contained nextgroup=assDialogTimes
syn match assDialogTimes   "\([^,]*,\)\{4}"  contained nextgroup=assDialogActor
syn match assDialogActor   "[^,]*"           contained nextgroup=assDialogEffects
syn match assDialogEffects ",\([^,]*,\)\{4}" contained nextgroup=assDialogText
syn match assDialogText    ".*$"             contained contains=assTextComment,assTextSubCode
syn match assTextComment   "{[^}]*}"         contained
syn match assTextSubCode   "{\\[^}]*}"       contained

hi def link assSection         Function
hi def link assSourceComment   Comment
hi def link assHeader          Statement
hi def link assComment         Statement
hi def link assDialog          Statement
hi def link assHeaderText      Constant
hi def link assCommentText     Comment
hi def link assDialogTimes     Type
hi def link assDialogActor     Title
hi def link assDialogEffects   Function
hi def link assDialogText      Identifier
hi def link assTextComment     Comment
hi def link assTextSubCode     Comment

let b:current_syntax = "ass"
