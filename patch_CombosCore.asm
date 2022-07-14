[CustomCombosCore]
moduleMatches = 0x6267bfd0
.origin = codecave

; This acts like a C header file. All the functions and
; variables are defined here to make the main file more
; readable.

; Initialize register storage variables
StoreComboLR:
.int 0

storeLR:
.int 0
storeR0:
.int 0
storeR1:
.int 0
storeR2:
.int 0
storeR3:
.int 0
storeR6:
.int 0
storeR7:
.int 0
storeR8:
.int 0
storeR9:
.int 0
storeR10:
.int 0
storeR11:
.int 0
storeR12:
.int 0
storeR13:
.int 0
storeR14:
.int 0
storeR15:
.int 0
storeR16:
.int 0
storeR17:
.int 0
storeR18:
.int 0
storeR19:
.int 0
storeR20:
.int 0

TorphMain:
; Store the state of most registers to codecave variables.
; They're restored afterwards, ensuring the game doesn't
; crash when returning to vanilla code.
mflr r5
lis r4, storeLR@ha
stw r5, storeLR@l(r4)
lis r4, storeR0@ha
stw r0, storeR0@l(r4)
lis r4, storeR1@ha
stw r1, storeR1@l(r4)
lis r4, storeR2@ha
stw r2, storeR2@l(r4)
lis r4, storeR3@ha
stw r3, storeR3@l(r4)
lis r4, storeR6@ha
stw r6, storeR6@l(r4)
lis r4, storeR7@ha
stw r7, storeR7@l(r4)
lis r4, storeR8@ha
stw r8, storeR8@l(r4)
lis r4, storeR9@ha
stw r9, storeR9@l(r4)
lis r4, storeR10@ha
stw r10, storeR10@l(r4)
lis r4, storeR11@ha
stw r11, storeR11@l(r4)
lis r4, storeR12@ha
stw r12, storeR12@l(r4)
lis r4, storeR13@ha
stw r13, storeR13@l(r4)
lis r4, storeR14@ha
stw r14, storeR14@l(r4)
lis r4, storeR15@ha
stw r15, storeR15@l(r4)
lis r4, storeR16@ha
stw r16, storeR16@l(r4)
lis r4, storeR17@ha
stw r17, storeR17@l(r4)
lis r4, storeR18@ha
stw r18, storeR18@l(r4)
lis r4, storeR19@ha
stw r19, storeR19@l(r4)
lis r4, storeR20@ha
stw r20, storeR20@l(r4)

; Set function parameters
li r10, 1
addi r3, r1, 8
stw r10, 8 (r1)

; Branch to MaskController::getControllerSafe()
lis r4, 0x02DE
ori r4, r4, 0x207C
mtctr r4
bctrl

b CheckCombos

ExitCodecave:
; Restore registers from storage
lis r4, storeLR@ha
lwz r5, storeLR@l(r4)
mtlr r5
lis r4, storeR0@ha
lwz r0, storeR0@l(r4)
lis r4, storeR1@ha
lwz r1, storeR1@l(r4)
lis r4, storeR2@ha
lwz r2, storeR2@l(r4)
lis r4, storeR3@ha
lwz r3, storeR3@l(r4)
lis r4, storeR6@ha
lwz r6, storeR6@l(r4)
lis r4, storeR7@ha
lwz r7, storeR7@l(r4)
lis r4, storeR8@ha
lwz r8, storeR8@l(r4)
lis r4, storeR9@ha
lwz r9, storeR9@l(r4)
lis r4, storeR10@ha
lwz r10, storeR10@l(r4)
lis r4, storeR11@ha
lwz r11, storeR11@l(r4)
lis r4, storeR12@ha
lwz r12, storeR12@l(r4)
lis r4, storeR13@ha
lwz r13, storeR13@l(r4)
lis r4, storeR14@ha
lwz r14, storeR14@l(r4)
lis r4, storeR15@ha
lwz r15, storeR15@l(r4)
lis r4, storeR16@ha
lwz r16, storeR16@l(r4)
lis r4, storeR17@ha
lwz r17, storeR17@l(r4)
lis r4, storeR18@ha
lwz r18, storeR18@l(r4)
lis r4, storeR19@ha
lwz r19, storeR19@l(r4)
lis r4, storeR20@ha
lwz r20, storeR20@l(r4)
lis r4, 0
lis r5, 0
mr r30, r3 ; Vanilla instruction
blr

Check_A:
lhz r4, 0x28 (r3) ; Check A
cmpw cr0, r4, r6
beq Return
blr
Check_B:
lhz r4, 0x2A (r3) ; Check B
cmpw cr0, r4, r6
beq Return
blr
Check_X:
lhz r4, 0x2E (r3) ; Check X
cmpw cr0, r4, r6
beq Return
blr
Check_Y:
lhz r4, 0x30 (r3) ; Check Y
cmpw cr0, r4, r6
beq Return
blr
Check_L:
lhz r4, 0x42 (r3) ; Check L
cmpw cr0, r4, r6
beq Return
blr
Check_R:
lhz r4, 0x44 (r3) ; Check R
cmpw cr0, r4, r6
beq Return
blr
Check_ZL:
lhz r4, 0x2C (r3) ; Check ZL
cmpw cr0, r4, r6
beq Return
blr
Check_ZR:
lhz r4, 0x32 (r3) ; Check ZR
cmpw cr0, r4, r6
beq Return
blr
Check_LS_Click:
lhz r4, 0x36 (r3) ; Check LS Click
cmpw cr0, r4, r6
beq Return
blr
Check_LS_Up:
lhz r4, 0x50 (r3) ; Check LS Up movement
cmpw cr0, r4, r6
beq Return
blr
Check_LS_Down:
lhz r4, 0x52 (r3) ; Check LS Down movement
cmpw cr0, r4, r6
beq Return
blr
Check_LS_Left:
lhz r4, 0x54 (r3) ; Check LS Left movement
cmpw cr0, r4, r6
beq Return
blr
Check_LS_Right:
lhz r4, 0x56 (r3) ; Check LS Right movement
cmpw cr0, r4, r6
beq Return
blr
Check_RS_Click:
lhz r4, 0x34 (r3) ; Check RS Click
cmpw cr0, r4, r6
beq Return
blr
Check_RS_Up:
lhz r4, 0x58 (r3) ; Check RS Up movement
cmpw cr0, r4, r6
beq Return
blr
Check_RS_Down:
lhz r4, 0x5A (r3) ; Check RS Down movement
cmpw cr0, r4, r6
beq Return
blr
Check_RS_Left:
lhz r4, 0x5C (r3) ; Check RS Left movement
cmpw cr0, r4, r6
beq Return
blr
Check_RS_Right:
lhz r4, 0x5E (r3) ; Check RS Right movement
cmpw cr0, r4, r6
beq Return
blr
Check_Select:
lhz r4, 0x3A (r3) ; Check Select button
cmpw cr0, r4, r6
beq Return
blr
Check_Select_2:
lhz r4, 0x40 (r3) ; Check Select button (this can be checked at 2 addresses for some reason)
cmpw cr0, r4, r6
beq Return
blr
Check_Start:
lhz r4, 0x3C (r3) ; Check Start button
cmpw cr0, r4, r6
beq Return
blr
Check_Start_2:
lhz r4, 0x3E (r3) ; Check Start button (this can be checked at 2 addresses for some reason)
cmpw cr0, r4, r6
beq Return
blr
Check_Touchscreen:
lhz r4, 0x46 (r3) ; Check for any touchscreen input
cmpw cr0, r4, r6
beq Return
blr
Check_DPad_Down:
lhz r4, 0x4A (r3) ; Check D-Pad Down (other directions are unavailable)
cmpw cr0, r4, r6
beq Return
blr
Check_TimeSinceLastInput:
lwz r4, 0x108 (r3) ; Check time since last input. Set r6 to a number of frames (in hex) before calling this function.
cmpw cr0, r4, r6
li r6, 0
beq Return
blr
; Unknown0:
; lhz r4, 0x38 (r3) ; Unknown. Exists in same region as other inputs.
; cmpw cr0, r4, r6
; beq Return
; blr
; Unknown1:
; lhz r4, 0x48 (r3) ; Unknown. Exists in same region as other inputs.
; cmpw cr0, r4, r6
; beq Return
; blr
; Unknown2:
; lhz r4, 0x4C (r3) ; Unknown. Exists in same region as other inputs.
; cmpw cr0, r4, r6
; beq Return
; blr
; Unknown3:
; lhz r4, 0x4E (r3) ; Unknown. Exists in same region as other inputs.
; cmpw cr0, r4, r6
; beq Return
; blr

Return:
lis r14, StoreComboLR@ha
lwz r15, StoreComboLR@l(r14)
mtlr r15
blr