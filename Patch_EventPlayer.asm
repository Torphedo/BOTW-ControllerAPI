[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave
0x2d5b82c = bla ButtonComboCheck

EventFlowName:
.string "FaroreFlow"
SafeStringEventName:
.int EventFlowName
.int 0x10263910

EntryPointName:
.string "Trigger"
SafeStringEntryPoint:
.int EntryPointName
.int 0x10263910

ButtonComboCheck:
mflr r0
stw r0, 0x04 (r1)    ; Stash LR data
stwu r1, -0x018 (r1) ; Set up stack
mr r30, r3 ; Vanilla instruction

lis r3, GetControllerData@ha
ori r3, r3, GetControllerData@l
mtctr r3
bctrl ; Branch to GetControllerData in patch_ControllerAPI.asm
bne ExitCodecave
b PlayEvent

PlayEvent:
; Load jump address into count register
lis r3, 0x02DD
ori r3, r3, 0xF744
mtctr r3

; Set parameters for function call
li r3, 0                            ; Actor nullptr
lis r4, SafeStringEventName@ha
addi r4, r4,  SafeStringEventName@l
lis r5, SafeStringEntryPoint@ha
addi r5, r5, SafeStringEntryPoint@l
li r6, 0                            ; bool isPauseOtherActors
li r7, 0                            ; bool skipIsStartableAirCheck

; Branch to ksys::evt::callEvent()
bctrl
b ExitCodecave

ExitCodecave:
mr r3, r30
addi r1, r1, 0x0018  ; Increment stack
lwz r0, 0x04 (r1)    ; Retreive stashed LR data
mtlr r0              ; Retreive stashed LR data
blr
