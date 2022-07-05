[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave

Button_A:
.float -170141183460469231731687303715884105728.000000

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

; Set A button data to f31
lis r12, Button_A@ha
lfs f31, Button_A@l (r12)

; Read controller data
lfs f0, 0x27(r3)
fcmpu cr0, f0, f31
beq ExitCodecave

mtlr r5
blr

; Left Stick:
;    lfs f0, 0x118(r3)
;    fcmpu cr0, f0, f31
;    bne ExitCodecave
;    lfs f0, 0x11C(r3)
;    fcmpu cr0, f0, f31
;    bne ExitCodecave
;
; A Button:
;   lfs f0, 0x27(r3)
;   fcmpu cr0, f0, f31
;   beq ExitCodecave
;
