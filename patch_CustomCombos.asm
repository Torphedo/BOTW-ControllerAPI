[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave
0x02D5B824 = bla Wrapper

; Set your event name / entry point name here.
EventFlowName:
.string "FaroreFlow"

EntryPointName:
.string "Trigger"

CustomCombos:
; Check if extended memory is enabled, and jump to
; the appropriate address depending on the result.
lis r6, 0x6000     ; nop = 60 00 00 00, checking for a patched instruction at 0x0340F320
lis r3, 0x0340     ; 0x0340 +
ori r3, r3, 0xF320 ; 0xF320 = 0x0340F320
lwz r3, 0x0 (r3)   ; Load instruction to be checked
cmpw cr0, r3, r6   ; Perform nop check
bla ExtendedMemory
ori r3, r3, 0xC580

; Read controller data
li r6, 0
lhz r4, Button_R (r3) ; Check R
cmpw cr0, r4, r6
beq ExitCodecave
lhz r4, Button_ZR (r3) ; Check ZR
cmpw cr0, r4, r6
beq ExitCodecave
lhz r4, Button_Y (r3) ; Check Y
cmpw cr0, r4, r6
beq ExitCodecave

; Proceed to play event, only if none of the branches to ExitCodecave are triggered
bla PlayEvent
b ExitCodecave

; In the example code above, I checked R, ZR, and Y. All listed buttons are half-words (2 bytes)
; unless stated otherwise. This means you need to load them into a register with a lhz instruction.
; Double-word inputs need to be loaded into 2 separate registers instead of 1, like so:
;
; lwz r4, Stick_L_Vector2f@ha (r3)
; lwz r5, Stick_L_Vector2f@l (r3)
; cmpw cr0, r4, r6
; beq ExitCodecave
; cmpw cr0, r5, r6
; beq ExitCodecave
;
; In this case 1 of the registers holds the X axis data for LS, and the other holds Y axis data.
;
; Here's a list of all the inputs you can check:
;
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

; Advanced Info:
;
; These names are just variables, representing hex values. Those values are offsets (from r3) to data
; tracking how long a button has been held for. When it equals a register set to 0x00000000, that
; means it's been held for 0 frames (not pressed). Each button gets 2 bytes for counting how long
; it's been held, which is why the code only loads half words. The value for any given button will
; increment by 0x01 each frame. You could use this knowledge to set up an event that will only trigger
; if you hold a set of buttons for 1 second, or something like that.
;
; The half-words at 0x38, 0x48, 0x4C, and 0x4E are in the same section as the others listed above, but
; don't seem to correspond to any button. There's another set of offsets starting at 0x68, which appear
; to be in the same order (in memory) as the ones above. These ones appear to increment by 0x222 each
; frame, which is strange.
;
; The bytes at 0x10D and 0x10C will have different values depending on the rotation of the left and
; right stick respectively, but only if they're past a certain threshold from the center.
;




; Options for advanced users.
SafeStringEventName:
.int EventFlowName ; String defined at top of this file
.int 0x10263910 ; vtable pointer for sead::SafeStringBase class. Required to construct a SafeString object.

SafeStringEntryPoint:
.int EntryPointName
.int 0x10263910

ExtendedMemory:
bne NoExtendedMemory
lis r3, 0x6AC9
blr

NoExtendedMemory:
lis r3, 0x41BA
blr

PlayEvent:
mflr r2 ; Stash LR data

; Set parameters for callEvent() function
li r3, 0                            ; Actor nullptr
lis r4, SafeStringEventName@ha
addi r4, r4,  SafeStringEventName@l
lis r5, SafeStringEntryPoint@ha
addi r5, r5, SafeStringEntryPoint@l
li r6, 0                            ; bool isPauseOtherActors (overridden by eventinfo)
li r7, 0                            ; bool skipIsStartableAirCheck (overridden by eventinfo)

; Load jump address into count register
lis r8, 0x02DD
ori r8, r8, 0xF744
mtctr r8

; Branch to ksys::evt::callEvent()
bctrl

mtlr r2
blr

Button_A = 0x28
Button_B = 0x2A
Button_X = 0x2E
Button_Y = 0x30
Button_L = 0x42
Button_R = 0x44
Button_ZL = 0x2C
Button_ZR = 0x32
Stick_L_Click = 0x36
Stick_L_Vector2f = 0x118
Stick_L_Up = 0x50
Stick_L_Down = 0x52
Stick_L_Left = 0x54
Stick_L_Right = 0x56
Stick_R_Click = 0x34
Stick_R_Vector2f = 0x123
Stick_R_Up = 0x58
Stick_R_Down = 0x5A
Stick_R_Left = 0x5C
Stick_R_Right = 0x5E
Button_Select = 0x3A
Button_Select_2 = 0x40
Button_Start = 0x3C
Button_Start_2 = 0x3E
Button_Touchscreen = 0x46
Button_DPad_Down = 0x4A
TimeSinceLastInput = 0x108



; Wrapper stuff. This basically just saves the contents of every normal
; register into the codecave's memory, then restores them all at the end.

storeLR:
.int 0
storeR0:
.int 0
storeR1:
.int 0
storeR2:
.int 0
storeR3:
.int 0
storeR4:
.int 0
storeR5:
.int 0

Wrapper:
mflr r7
lis r6, storeLR@ha
stw r7, storeLR@l(r6)
lis r6, storeR0@ha
stw r0, storeR0@l(r6)
lis r6, storeR1@ha
stw r1, storeR1@l(r6)
lis r6, storeR2@ha
stw r2, storeR2@l(r6)
lis r6, storeR3@ha
stw r3, storeR3@l(r6)
lis r6, storeR4@ha
stw r4, storeR4@l(r6)
lis r6, storeR5@ha
stw r5, storeR5@l(r6)
b CustomCombos

ExitCodecave:

lis r6, storeLR@ha
lwz r7, storeLR@l(r6)
mtlr r7
lis r6, storeR0@ha
lwz r0, storeR0@l(r6)
lis r6, storeR1@ha
lwz r1, storeR1@l(r6)
lis r6, storeR2@ha
lwz r2, storeR2@l(r6)
lis r6, storeR3@ha
lwz r3, storeR3@l(r6)
lis r6, storeR4@ha
lwz r4, storeR4@l(r6)
lis r6, storeR5@ha
lwz r5, storeR5@l(r6)
lis r6, 0
lis r7, 0
mr r31, r4 ; Vanilla instruction
blr
