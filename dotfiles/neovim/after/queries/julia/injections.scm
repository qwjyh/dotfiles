;; extends

(prefixed_string_literal
  prefix: (identifier) @_prefix
  (content) @injection.content
  (#eq? @_prefix "sql")
  (#set! injection.language "sql"))
