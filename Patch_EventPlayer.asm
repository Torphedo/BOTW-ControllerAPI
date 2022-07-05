[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave
0x2d5b82c = bla ButtonComboCheck

ButtonComboCheck:
mflr r0
stw r0, 0x04 (r1)    ; Stash LR data
stwu r1, -0x018 (r1) ; Set up stack
mr r30, r3 ; Vanilla instruction

; Set function parameters
li r10, 1
addi r3, r1, 8
stw r10, 8 (r1)

; Branch to MaskController::getControllerSafe()
lis r4, 0x02DE
ori r4, r4, 0x207C
mtctr r4
bctrl

; TODO: Read returned data, find face button bit field
mr r4, r3
lis r12, 0x1048
lwzu r8, +0x6450 (r12)
lis r4, 0x1049
; lfs f0, 0x27(r3)
cmpwi r8, 0
subi r4, r4, 0x49d0

bne ResetAndReturn

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

; Load jump address into count register
lis r3, 0x02DD
ori r3, r3, 0xF744

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

ResetAndReturn:
mr r3, r30
addi r1, r1, 0x0018  ; Increment stack
lwz r0, 0x04 (r1)    ; Retreive stashed LR data
mtlr r0              ; Retreive stashed LR data
blr
