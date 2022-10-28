; extends

((directive
   name: (type) @_type
   body: (body (arguments) @_language (content) @bash))
 (#any-of? @_language "sh" "shell")
 (#any-of? @_type "code" "code-block" "sourcecode"))
