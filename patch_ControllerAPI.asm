[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave

GetControllerData:
mflr r5

; Set function parameters
li r10, 1
addi r3, r1, 8
stw r10, 8 (r1)

; Branch to MaskController::getControllerSafe()
lis r4, 0x02DE
ori r4, r4, 0x207C
mtctr r4
bctrl

; Read controller data
lwz r4, 0x28 (r3)
li r6, 0
cmpw cr0, r4, r6
beq ExitCodecave ; Resets stack and goes back to vanilla code

mtlr r5
blr ; Return and play event

; Left Stick:
;    lfs f0, 0x118(r3)
;    fcmpu cr0, f0, f31
;    bne ExitCodecave
;    lfs f0, 0x11C(r3)
;    fcmpu cr0, f0, f31
;    bne ExitCodecave
;
; A Button:
;    lwz r4, 0x28 (r3)
;    li r6, 0
;    cmpw cr0, r4, r6
;    beq ExitCodecave
