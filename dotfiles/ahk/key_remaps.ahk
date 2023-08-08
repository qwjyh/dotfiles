; basic key remapping for windows(JIS keyboard)
; using AutoHotKey
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%1

; KeyHistory

#UseHook

; ==========================================
; 変換/無変換 + ASDF/HJKLのショートカット
vk1D::
Send, {vk1D}
Return

vk1C::
Send, {vk1C}
Return

; 十字キーの設定
; hjkl like vim
vk1D & h::
vk1C & h::
Send,{Blind}{Left}
return
vk1D & j::
vk1C & j::
Send,{Blind}{Down}
return
vk1D & k::
vk1C & k::
Send,{Blind}{Up}
return
vk1D & l::
vk1C & l::
Send,{Blind}{Right}
return

; Home,End,PgUp,PgDnの設定
; a    p    n    f
; Home PgUp PgDn End
vk1D & a::
vk1C & a::
Send,{Blind}{Home}
return
vk1D & f::
vk1C & f::
Send,{Blind}{End}
return
vk1D & p::
vk1C & p::
Send,{Blind}{PgUp}
return
vk1D & n::
vk1C & n::
Send,{Blind}{PgDn}
return

; Multi-Line Up/Down
; (experimental)
vk1D & u::
vk1C & u::
Send,{Blind}{Up 5}
return
vk1D & d::
vk1C & d::
Send,{Blind}{Down 5}
return
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
#Include extra_remaps.ahk

; ==========================================
; HankakuZenkaku to esc
sc029::
  Send, {Escape}
