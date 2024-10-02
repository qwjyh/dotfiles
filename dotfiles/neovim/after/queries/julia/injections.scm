;; extends

((prefixed_string_literal
  prefix: (identifier) @_prefix) @injection.content
  (#eq? @_prefix "md")
  (#set! injection.language "markdown")
  (#offset! @injection.content 0 2 0 -1))

; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "sql")
;   (#set! injection.language "sql")
;   (#offset! @injection.content 0 4 0 -1))
;
; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "s")
;   (#set! injection.language "sql")
;   (#offset! @injection.content 0 3 0 -1))
;
; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "t")
;   (#set! injection.language "regex")
;   (#offset! @injection.content 0 2 0 -1))
;
; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "ts")
;   (#set! injection.language "regex")
;   (#offset! @injection.content 0 2 0 -1))
;
; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "tu")
;   (#set! injection.language "regex")
;   (#offset! @injection.content 0 3 0 -1))
;
; ((prefixed_string_literal
;   prefix: (identifier) @_prefix) @injection.content
;   (#eq? @_prefix "sql")
;   ; (#offset! @injection.content 0 2 0 -1)
;   ; (#offset! @injection.content 0 6 0 -3)
;   (#gsub! @injection.content "^\"%\"" "%1")
;   (#set! injection.language "sql")
;   )
