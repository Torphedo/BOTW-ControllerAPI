[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave
0x2d5b82c = bla TorphMain

TorphMain:
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

b CustomCombos

PlayEvent:
mflr r2 ; Stash LR data

bla EventFnParams ; Set function parameters (placed in other patch file so advanced users can tamper with it easier)
; Load jump address into count register
lis r8, 0x02DD
ori r8, r8, 0xF744
mtctr r8

; Branch to ksys::evt::callEvent()
bctrl

mtlr r2
blr

ExitCodecave:
mr r3, r30
addi r1, r1, 0x0018  ; Increment stack
lwz r0, 0x04 (r1)    ; Retreive stashed LR data
mtlr r0              ; Retreive stashed LR data
blr
