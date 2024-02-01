; extends

((string_literal
   ["$" "${" "}"] @punctuation.special)
 (#set! "priority" 130))

((simple_identifier) @constant
 (#lua-match? @constant "^[A-Z][A-Z0-9_]+$")
 (#set! "priority" 130))
