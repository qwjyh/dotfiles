;; extends

((prefixed_string_literal
  prefix: (identifier) @_prefix) @injection.content
  (#eq? @_prefix "md")
  (#set! injection.language "markdown")
  (#offset! @injection.content 0 2 0 -1))
