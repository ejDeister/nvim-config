; extends

((comment) @_comment
  (#lua-match? @_comment "html")
  .
  (template_string
    (string_fragment) @injection.content)
  (#set! injection.language "html"))
