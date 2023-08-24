; extends

((fenced_code_block
  (info_string (language) @_language)
  (code_fence_content) @injection.content)
  (#any-of? @_language "sh" "shell")
  (#set! injection.language "bash"))

((fenced_code_block
  (info_string (language) @_language)
  (code_fence_content) @injection.content)
  (#any-of? @_language "js")
  (#set! injection.language "javascript"))

((fenced_code_block
  (info_string (language) @_language)
  (code_fence_content) @injection.content)
  (#any-of? @_language "ts")
  (#set! injection.language "typescript"))

((fenced_code_block
  (info_string (language) @_language)
  (code_fence_content) @injection.content)
  (#any-of? @_language "=latex")
  (#set! injection.language "latex"))
