; extends

(fenced_code_block
  (info_string (language) @_language)
  (#any-of? @_language "sh" "shell")
  (code_fence_content) @bash)

(fenced_code_block
  (info_string (language) @_language)
  (#eq? @_language "js")
  (code_fence_content) @javascript)

(fenced_code_block
  (info_string (language) @_language)
  (#eq? @_language "ts")
  (code_fence_content) @typescript)
