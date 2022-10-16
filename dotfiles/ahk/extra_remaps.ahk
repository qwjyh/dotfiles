; extra key remaps
; mainly for inputting special characters

; Play/Pause
sc121::
	Send {Media_Play_Pause}
	return


; Henkan/Muhenkan + - -> en, em dash
vk1D & vkBD::
	Send {U+2013} ; en dash
	return
vk1C & vkBD::
	Send {U+2014} ; em dash
	return

; Henkan/Muhenkan + {Space} -> ZWSP, ZWJ
vk1D & Space::
	Send {U+200B} ; ZWSP
	return
vk1C & Space::
	Send {U+200D} ; ZWJ
	return

