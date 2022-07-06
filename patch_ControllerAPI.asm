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
li r6, 0
lhz r4, 0x44 (r3) ; Check R
cmpw cr0, r4, r6
beq ExitCodecave
lhz r4, 0x32 (r3) ; Check ZR
cmpw cr0, r4, r6
beq ExitCodecave
lhz r4, 0x30 (r3) ; Check Y
cmpw cr0, r4, r6
beq ExitCodecave

mtlr r5
blr ; Return and play event

; //////////////////////////////////////////////
; ||     Button Name     ||     Hex Code      ||
; ||==========================================||
; ||          A          ||       0x28        ||
; ||          B          ||       0x2A        ||
; ||          X          ||       0x2E        ||
; ||          Y          ||       0x30        ||
; ||          L          ||       0x42        ||
; ||          R          ||       0x44        ||
; ||          ZL         ||       0x2C        ||
; ||          ZR         ||       0x32        ||
; ||   Left Stick Click  ||       0x36        ||
; ||  Right Stick Click  ||       0x34        ||
; ||      Select / -     ||   0x3A / 0x40     ||
; ||      Start / +      ||   0x3C / 0x3E     ||
; ||      Touchscreen    ||       0x46        ||
; ||      D-Pad Down     ||       0x4A        ||
; //////////////////////////////////////////////
