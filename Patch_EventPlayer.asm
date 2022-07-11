[ControllerAPI]
moduleMatches = 0x6267bfd0
.origin = codecave
0x2d5b82c = bla TorphMain

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
storeR24:
.int 0
storeR25:
.int 0
storeR26:
.int 0
storeR27:
.int 0
storeR28:
.int 0
storeR29:
.int 0
storeR30:
.int 0
storeR31:
.int 0

TorphMain:

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
lis r4, storeR24@ha
stw r24, storeR24@l(r4)
lis r4, storeR25@ha
stw r25, storeR25@l(r4)
lis r4, storeR26@ha
stw r26, storeR26@l(r4)
lis r4, storeR27@ha
stw r27, storeR27@l(r4)
lis r4, storeR28@ha
stw r28, storeR28@l(r4)
lis r4, storeR29@ha
stw r29, storeR29@l(r4)
lis r4, storeR30@ha
stw r30, storeR30@l(r4)
lis r4, storeR31@ha
stw r31, storeR31@l(r4)

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

ExitCodecave:

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
lis r4, storeR24@ha
lwz r24, storeR24@l(r4)
lis r4, storeR25@ha
lwz r25, storeR25@l(r4)
lis r4, storeR26@ha
lwz r26, storeR26@l(r4)
lis r4, storeR27@ha
lwz r27, storeR27@l(r4)
lis r4, storeR28@ha
lwz r28, storeR28@l(r4)
lis r4, storeR29@ha
lwz r29, storeR29@l(r4)
lis r4, storeR30@ha
lwz r30, storeR30@l(r4)
lis r4, storeR31@ha
lwz r31, storeR31@l(r4)
lis r4, 0
lis r5, 0
mr r30, r3 ; Vanilla instruction
blr
