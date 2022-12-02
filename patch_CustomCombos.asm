[FaroreCustomCombos]
moduleMatches = 0x6267bfd0
.origin = codecave

; Set your event name / entry point name here.
FaroreFlowName:
.string "FaroreFlow"

FaroreEntryPoint:
.string "Trigger"

CheckCombos:
li r6, 0

; Reload controller pointer
lis r4, ControllerPointer@ha
lwz r3, ControllerPointer@l(r4)

bla RuneEntry
b restore_registers

RuneEntry:
; Stash LR data
mflr r15
lis r14, StoreComboLR@ha
stw r15, StoreComboLR@l(r14)

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

; Read controller data
bla Check_L
; Proceed to play event, only if all of the checked buttons are being pressed
b PlayEvent
