[YourNameHereCustomCombos]
moduleMatches = 0x6267bfd0
.origin = codecave

0x2d5b82c = bla ComboInit

; Set your event name / entry point name here.
FaroreFlowName:
.string "FaroreFlow"

FaroreEntryPoint:
.string "Trigger"

; sead::SafeStringBase struct deifinitions.
SafeStringFaroreFlow:
.int FaroreFlowName ; String defined above
.int 0x10263910 ; vtable pointer for sead::SafeStringBase class. Required to construct a SafeString object.

SafeStringFaroreEntry:
.int FaroreEntryPoint
.int 0x10263910

DogFlowName:
.string "GoodBoy"

DogEntryPoint:
.string "Talk"

SafeStringDogFlow:
.int DogFlowName
.int 0x10263910

SafeStringDogEntry:
.int DogEntryPoint
.int 0x10263910

CheckCombos:
li r6, 0
bla Combo1
bla Combo2
b ExitCodecave

Combo1:
mflr r15
lis r14, StoreComboLR@ha
stw r15, StoreComboLR@l(r14)
; Read controller data
bla Check_R
bla Check_ZR
bla Check_Y
; Proceed to play event, only if all of the checked buttons are being pressed
b PlayEvent


Combo2:
mflr r15
lis r14, StoreComboLR@ha
stw r15, StoreComboLR@l(r14)
; Read controller data
bla Check_L
bla Check_ZL
bla Check_Y
; Proceed to play event, only if all of the checked buttons are being pressed
b PlayDogPet

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

; Here's a list of all the inputs you can check:

; Stick_L_Vector2f (double word)
; Stick_R_Vector2f (double word)

; There's another set of offsets starting at 0x68, which appear
; to be in the same order (in memory) as the ones above. These ones appear to increment by 0x222 each
; frame, which is strange.
;
; The bytes at 0x10D and 0x10C will have different values depending on the rotation of the left and
; right stick respectively, but only if they're past a certain threshold from the center.
;

PlayEvent:
li r3, 0                            ; Actor nullptr
lis r4, SafeStringFaroreFlow@ha      ; Load SafeStringEventName
addi r4, r4,  SafeStringFaroreFlow@l ; struct into r4
lis r5, SafeStringFaroreEntry@ha     ; Load SafeStringEntryPoint
addi r5, r5, SafeStringFaroreEntry@l ; struct into r5
li r6, 1                            ; bool isPauseOtherActors (overridden by eventinfo)
li r7, 0                            ; bool skipIsStartableAirCheck (overridden by eventinfo)

; Load jump address into count register
lis r8, 0x02DD
ori r8, r8, 0xF744
mtctr r8

; Branch to ksys::evt::callEvent()
bctrl
b ExitCodecave

PlayDogPet:
li r3, 0                            ; Actor nullptr
lis r4, SafeStringDogFlow@ha      ; Load SafeStringEventName
addi r4, r4,  SafeStringDogFlow@l ; struct into r4
lis r5, SafeStringDogEntry@ha     ; Load SafeStringEntryPoint
addi r5, r5, SafeStringDogEntry@l ; struct into r5
li r6, 0                            ; bool isPauseOtherActors (overridden by eventinfo)
li r7, 0                            ; bool skipIsStartableAirCheck (overridden by eventinfo)

; Load jump address into count register
lis r8, 0x02DD
ori r8, r8, 0xF744
mtctr r8

; Branch to ksys::evt::callEvent()
bctrl
b ExitCodecave
