[CustomCombosCore]
moduleMatches = 0x6267bfd0

.origin = codecave

; This should be replaced with a stack push/pop in the future.
StoreComboLR:
.int 0

ControllerPointer:
.int 0 ; Pointer to controller data

MaskController__getControllerSafe:
.int 0x02DE207C

ksys__evt__callEvent:
.int 0x02DDF744

; Empty sead::SafeString structs
EventName:
.int 0
.int 0x10263910
EntryPoint:
.int 0
.int 0x10263910

FramesSinceLastUse:
.short 0

get_controller_state:
; Load jump address into count register
lis r4, MaskController__getControllerSafe@ha
lwz r3, MaskController__getControllerSafe@l(r4)
mtctr r3

mflr r0 ; Save LR
stwu r0, -4(r1)

; Set function parameters
li r10, 1
addi r1, r1, -0xC ; Push stack
addi r3, r1, 8 ; r3 = &stack + 8 (?)
stw r10, 8 (r1)

; Branch to MaskController::getControllerSafe()
bctrl
addi r1, r1, 0xC ; Pop stack

lwzu r0, 0(r1) ; Load LR & clean up stack
mtlr r0
addi r1, r1, 4

; Store pointer to controller data in ControllerPointer variable
lis r4, ControllerPointer@ha
stw r3, ControllerPointer@l(r4)

blr ; return

PlayEvent:
; Load jump address into count register
lis r4, ksys__evt__callEvent@ha
lwz r3, ksys__evt__callEvent@l(r4)
mtctr r3

li r3, 0                  ; Actor nullptr
lis r4, EventName@ha      ; Load event name string
addi r4, r4, EventName@l
lis r5, EntryPoint@ha     ; Load entry point string
addi r5, r5, EntryPoint@l
li r6, 0                  ; bool isPauseOtherActors (overridden by eventinfo)
li r7, 0                  ; bool skipIsStartableAirCheck (overridden by eventinfo)

; Branch to ksys::evt::callEvent()
bctrl
b restore_registers

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
Check_LS_Vec2f:
lwz r4, 0x118 (r3) ; Each of these 2 registers will contain 1 axis
lwz r5, 0x11C (r3) ; vector data for LS. In this case, it will only
cmpw cr0, r4, r6   ; proceed if the stick is at 0, 0.
beq Return
cmpw cr0, r5, r6
li r6, 0
beq Return
blr
Check_RS_Vec2f:
lwz r4, 0x123 (r3) ; Each of these 2 registers will contain 1 axis
lwz r5, 0x127 (r3) ; vector data for RS. In this case, it will only
cmpw cr0, r4, r6   ; proceed if the stick is at 0, 0.
beq Return
cmpw cr0, r5, r6
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

; There's another set of offsets starting at 0x68, which appear
; to be in the same order (in memory) as the ones above. These ones appear to increment by 0x222 each
; frame, which is strange.
;
; The bytes at 0x10D and 0x10C will have different values depending on the rotation of the left and
; right stick respectively, but only if they're past a certain threshold from the center.

Return:
lis r14, StoreComboLR@ha
lwz r15, StoreComboLR@l(r14)
mtlr r15
blr

Add1:
addi r16, r16, 0x1 ; Add 1
sth r16, 0x0(r18)
b Return

FramesCooldown:
lis r18, FramesSinceLastUse@ha
addi r18, r18, FramesSinceLastUse@l ; Load pointer to FramesSinceLastUse
lhz r16, 0x0(r18)  ; Load value into r16
cmpw cr0, r16, r17
blt Add1 ; Add 1 and fail check if counter is less than target value
blr


;                  Code to save/restore registers.
; ====================================================================

save_registers:
; Push all general purpose registers and link
; register to the stack. These will be restored
; before branching back to the original game code.
stwu r0, -4(r1)
stwu r2, -4(r1)
stwu r3, -4(r1)
stwu r4, -4(r1)
stwu r5, -4(r1)
stwu r6, -4(r1)
stwu r7, -4(r1)
stwu r8, -4(r1)
stwu r9, -4(r1)
stwu r10, -4(r1)
stwu r11, -4(r1)
stwu r12, -4(r1)
stwu r13, -4(r1)
stwu r14, -4(r1)
stwu r15, -4(r1)
stwu r16, -4(r1)
stwu r17, -4(r1)
stwu r18, -4(r1)
stwu r19, -4(r1)
stwu r20, -4(r1)
stwu r21, -4(r1)
stwu r22, -4(r1)
stwu r23, -4(r1)
stwu r24, -4(r1)
stwu r25, -4(r1)
stwu r26, -4(r1)
stwu r27, -4(r1)
stwu r28, -4(r1)
stwu r29, -4(r1)
stwu r30, -4(r1)
stwu r31, -4(r1)
mflr r31
stwu r31, -4(r1)
bla get_controller_state
b CheckCombos

restore_registers:
; Restore registers from stack
lwzu r31, 0(r1)
mtlr r31
lwzu r31, 4(r1)
lwzu r30, 4(r1)
lwzu r29, 4(r1)
lwzu r28, 4(r1)
lwzu r27, 4(r1)
lwzu r26, 4(r1)
lwzu r25, 4(r1)
lwzu r24, 4(r1)
lwzu r23, 4(r1)
lwzu r22, 4(r1)
lwzu r21, 4(r1)
lwzu r20, 4(r1)
lwzu r19, 4(r1)
lwzu r18, 4(r1)
lwzu r17, 4(r1)
lwzu r16, 4(r1)
lwzu r15, 4(r1)
lwzu r14, 4(r1)
lwzu r13, 4(r1)
lwzu r12, 4(r1)
lwzu r11, 4(r1)
lwzu r10, 4(r1)
lwzu r9,  4(r1)
lwzu r8,  4(r1)
lwzu r7,  4(r1)
lwzu r6,  4(r1)
lwzu r5,  4(r1)
lwzu r4,  4(r1)
lwzu r3,  4(r1)
lwzu r2,  4(r1)
lwzu r0,  4(r1)
addi r1, r1, 4
mr r30, r3 ; Vanilla instruction. Replace this when you change the hooking address.
b return_address

.origin = 0x2d5b828 ; Address to hook into.
hook_address:
b save_registers ; This is where our execution starts.
return_address:  ; Just hook_address + 4
