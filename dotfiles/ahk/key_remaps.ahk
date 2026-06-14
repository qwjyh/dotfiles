; basic key remapping for windows(JIS keyboard)
; using AutoHotKey
#SingleInstance Force
SendMode("Input")
SetWorkingDir A_ScriptDir

; KeyHistory

#UseHook

; ==========================================
; 変換/無変換 + ASDF/HJKLのショートカット
vk1D::Send("{vk1D}")

vk1C::Send("{vk1C}")

; 十字キーの設定
; hjkl like vim
vk1D & h::
vk1C & h::Send("{Blind}{Left}")

vk1D & j::
vk1C & j::Send("{Blind}{Down}")

vk1D & k::
vk1C & k::Send("{Blind}{Up}")

vk1D & l::
vk1C & l::Send("{Blind}{Right}")

; Home,End,PgUp,PgDnの設定
; a    p    n    f
; Home PgUp PgDn End
vk1D & a::
vk1C & a::Send("{Blind}{Home}")

vk1D & f::
vk1C & f::Send("{Blind}{End}")

vk1D & p::
vk1C & p::Send("{Blind}{PgUp}")

vk1D & n::
vk1C & n::Send("{Blind}{PgDn}")

; Multi-Line Up/Down
; (experimental)
vk1D & u::
vk1C & u::Send("{Blind}{Up 5}")
vk1D & d::
vk1C & d::Send("{Blind}{Down 5}")
; vk1D & v::
; vk1C & v::
; Send,{Blind}{Down}
; Sleep, 1
; Send,{Blind}{Down}
; Sleep, 1
; Send,{Blind}{Down}
; Sleep, 1
; Send,{Blind}{Down}
; Sleep, 1
; Send,{Blind}{Down}
; Sleep, 1
; return
; vk1D & b::
; vk1C & b::
; Send,{Blind}{Down down}
; Send,{Blind}{Down down}
; Send,{Blind}{Down down}
; Send,{Blind}{Down down}
; Send,{Blind}{Down down}
; Send,{Blind}{Down up}
; return


; ==========================================
; include extra key remaps
#Include "extra_remaps.ahk"

; ==========================================
; HankakuZenkaku to esc
return ; V1toV2: remove if unnecessary
sc029::
{ ; V1toV2: Added opening brace for [sc029]
global ; V1toV2: Made function global
  Send("{Escape}")
} ; V1toV2: Added closing brace for [sc029] (NO CLEAR EXIT FOUND)
