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

; This table has hex offsets for every button I could find. They should be used as an
; offset from r3 to load a halfword into another register, like this example to check A:
;
;                      lhz r4, 0x28 (r3)
;
; Then do a compare between the register you wrote to and a register that's been set to 0:
;
;                      li r6, 0
;                      cmpw cr0, r4, r6
;
; An equal result would mean the targeted button isn't being pressed, so you should follow
; this up with a Branch If Equal instruction:
;
;                      beq ExitCodecave
;
; TLDR: Copy the instructions listed above, and paste a hex code from the table below over 
; 0x28 to check for your preferred button. To check a multi-button combo, repeat these
; instructions with a different hex code.

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

; 
