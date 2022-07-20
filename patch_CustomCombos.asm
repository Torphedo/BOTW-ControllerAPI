[YourNameHereCustomCombos]
moduleMatches = 0x6267bfd0
.origin = codecave

; Set your event name / entry point name here.
FaroreFlowName:
.string "FaroreFlow"

FaroreEntryPoint:
.string "Trigger"

DogFlowName:
.string "GoodBoy"

DogEntryPoint:
.string "Talk"

CheckCombos:
li r6, 0
bla Combo1
bla Combo2
b ExitCodecave

Combo1:
lis r15, EventName@ha
addi r15, r15,  EventName@l
lis r16, EntryPoint@ha
addi r16, r16,  EntryPoint@l

lis r14, FaroreFlowName@ha
addi r14, r14,  FaroreFlowName@l
stw r14, 0x0(r15)
lis r14, FaroreEntryPoint@ha
addi r14, r14,  FaroreEntryPoint@l
stw r14, 0x0(r16)
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
lis r15, EventName@ha
addi r15, r15,  EventName@l
lis r16, EntryPoint@ha
addi r16, r16,  EntryPoint@l

lis r14, DogFlowName@ha         ; String defined at
addi r14, r14,  DogFlowName@l   ; the top of the file
stw r14, 0x0(r15)
lis r14, DogEntryPoint@ha       ; String defined at
addi r14, r14,  DogEntryPoint@l ; the top of the file
stw r14, 0x0(r16)
mflr r15
lis r14, StoreComboLR@ha
stw r15, StoreComboLR@l(r14)    ; Stash LR data
; Read controller data
bla Check_L
bla Check_ZL
bla Check_Y
; Proceed to play event, only if all of the checked buttons are being pressed
b PlayEvent
