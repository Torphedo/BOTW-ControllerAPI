; In my example code I checked R, ZR, and Y. All listed buttons are half-words (2 bytes)
; unless stated otherwise. This means you need to load them into a register with a lhz instruction.
; Double-word inputs need to be loaded into 2 separate registers instead of 1, like so:

; lwz r4, Stick_L_Vector2f@ha (r3)
; lwz r5, Stick_L_Vector2f@l (r3)
; cmpw cr0, r4, r6
; beq ExitCodecave
; cmpw cr0, r5, r6
; beq ExitCodecave

; In this case 1 of the registers holds the X axis data for LS, and the other holds Y axis data.

; Here's a list of all the inputs you can check:

; Button_A
; Button_B
; Button_X
; Button_Y
; Button_L
; Button_R
; Button_ZL
; Button_ZR
; Stick_L_Click
; Stick_L_Vector2f (double word)
; Stick_L_Up
; Stick_L_Down
; Stick_L_Left
; Stick_L_Right
; Stick_R_Click
; Stick_R_Vector2f (double word)
; Stick_R_Up
; Stick_R_Down
; Stick_R_Left
; Stick_R_Right
; Button_Select
; Button_Select_2
; Button_Start
; Button_Start_2
; Button_Touchscreen
; Button_DPad_Down
; TimeSinceLastInput (single word, read with this instruction: lwz r4, TimeSinceLastInput@l (r3))


; These names are variables, representing hex offsets (from r3) to a short (2 byte number) tracking
; how long a button has been held for. When it equals 0, that means it's been held for 0 frames.
; Since these counters are shorts, the code only loads half words. The counter for any given button
; will increment by 0x01 each frame. You could use this knowledge to set up an event that will only
; trigger if you hold a set of buttons for 1 second, or something like that.
;
; The half-words at 0x38, 0x48, 0x4C, and 0x4E are in the same section as the others listed above, but
; don't seem to correspond to any button. There's another set of offsets starting at 0x68, which appear
; to be in the same order (in memory) as the ones above. These ones appear to increment by 0x222 each
; frame, which is strange.
;
; The bytes at 0x10D and 0x10C will have different values depending on the rotation of the left and
; right stick respectively, but only if they're past a certain threshold from the center.