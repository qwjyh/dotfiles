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
; a    s    d    f
; Home PgUp PgDn End
vk1D & a::
vk1C & a::
Send,{Blind}{Home}
return
vk1D & f::
vk1C & f::
Send,{Blind}{End}
return
vk1D & s::
vk1C & s::
Send,{Blind}{PgUp}
return
vk1D & d::
vk1C & d::
Send,{Blind}{PgDn}
return


; ==========================================
; HankakuZenkaku to esc
sc029::
  Send, {Escape}
