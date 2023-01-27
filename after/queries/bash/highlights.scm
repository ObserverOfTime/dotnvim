; extends

((variable_name) @property
 (#lua-match? @property "^[^A-Z]"))

((command
   argument: (word) @string.special)
 (#lua-match? @string.special "^-"))

((command
   argument: (concatenation
               (word) @string.special))
 (#lua-match? @string.special "^-"))
