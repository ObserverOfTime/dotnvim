; extends

(invocation
  name: (identifier) @function.builtin)

((invocation
  parameter: (field) @constant)
 (#eq? @constant "MONTH"))

(invocation
  parameter: (literal) @field)

(term
  alias: (identifier) @field)

"\"" @punctuation.delimiter

(group_by
  (field
    name: (identifier) @field))

((ERROR) @keyword
 (#any-of? @keyword "GO" "OR ALTER"))
