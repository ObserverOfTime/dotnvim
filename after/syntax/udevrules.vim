syn match udevrulesComma /,/
syn match udevrulesLineBreak /\\$/

hi! link udevrulesComma Delimiter
hi! link udevrulesRuleTest Operator
hi! link udevrulesEStringEq Operator
hi! link udevrulesLineBreak SpecialKey
