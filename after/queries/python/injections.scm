; extends

((call
  function: (attribute
              attribute: (identifier) @_method)
  arguments: (argument_list
               (keyword_argument
                 value: (string
                          (string_content) @injection.content))))
 (#eq? @_method "RunSQL")
 (#set! injection.language "sql"))
