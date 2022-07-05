[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave

float_0:
.float 0.0

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
lis r12, float_0@ha
cmpwi r3, 0
lfs f31, float_0@l (r12)

lfs f0, 0x118(r3)
fcmpu cr0, f0, f31
bne ExitCodecave
lfs f0, 0x11C(r3)
fcmpu cr0, f0, f31
bne ExitCodecave

mtlr r5
blr
