syn region pythonDocString matchgroup=pythonTripleQuotes
        \ start=+^\s*\z('''\|"""\)+ end="\z1" keepend fold
        \ contains=pythonDocStringRst,pythonEscape,
        \ pythonSpaceError,pythonDoctest,@Spell
syn match pythonDocRst contained /:[^:]*:/

hi link pythonDocString String
hi link pythonDocRst SpecialComment

au FileType python setl foldmethod=syntax foldlevel=0
            \ foldtext=getline(v:foldstart+1).'\ '

