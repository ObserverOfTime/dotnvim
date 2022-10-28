; extends

((escape_sequence) @conceal
 (#eq? @conceal "\\\"")
 (#set! conceal "\""))
