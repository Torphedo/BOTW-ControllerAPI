[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave
0x2c2290c = bla InputGrabber1
0x2d57ed4 = ba InputGrabber2
0x2d5b82c = bla ButtonComboCheck
int_2:
.int 0
int_5:
.int 0

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

InputGrabber1:
int_3:
.int 0
mflr r0
stw r0, 0x0004 (r1) ; Stash LR data in r1
stwu r1, -0x000C (r1)

lis r12, 0x2d4       ; Vanilla branch instruction
ori r12, r12, 0x95d8 ; Vanilla branch instruction
mtctr r12            ; Vanilla branch instruction
bctrl                ; Vanilla branch instruction

lis r4, int_2@ha
stw r3, int_2@l (r4)
mr r3, r31

lis r12, 0x2d4       ; Vanilla branch instruction
ori r12, r12, 0x95d8 ; Vanilla branch instruction
mtctr r12            ; Vanilla branch instruction
bctrl                ; Vanilla branch instruction

lis r4, int_3@ha
stw r3, int_3@l (r4)
addi r1, r1, 0x000C
lwz r0, 0x0004 (r1)

mtlr r0
blr

InputGrabber2:
int_4:
.int 0
lis r4, int_4@ha
lbz r5, int_4@l (r4)
addi r6, r5, 0x0001
stb r6, int_4@l (r4)
mulli r4, r5, 0x0004
lis r5, int_5@ha
addi r5, r5, int_5@l
add r4, r4, r5
stw r3, 0x0000 (r4)
stw r3, 0x1E44 (r3)
blr

ButtonComboCheck:
mflr r0
stw r0, 0x0004 (r1)   ; Stash LR data in r1
stwu r1, -0x0010 (r1)
stw r28, 0x0008 (r1)
mr r30, r3 ; Vanilla instruction

; Some black magic to get the buttons being held, idk
lbz r4, 0x1f (r30)
mulli r4, r4, 0x0004
lis r5, int_2@ha
add r5, r5, r4
lwz r4, int_2@l (r5)
stw r30, 0x0030 (r4)
lis r4, int_5@ha
lwz r4, int_5@l (r4)
lwz r4, 0x1324 (r4)
stw r4, 0x1324 (r30)
lwz r4, 0x1298 (r30)
lhz r0, 0x0112 (r4)

cmpwi r0, 0x6010 ; This will only be equal if L + R + Y are pressed
bne ResetAndReturn ; Branch here unless r0 = 0x6010, preventing everything after from executing

0x02DDF744 = callEventAddr:

; Load jump address into registers since r3 is free to use
lis r3, callEventAddr@ha
addi r3, r3, callEventAddr@l
mtctr r3

; Set parameters for function call
li r3, 0
lis r4, SafeStringEventName@ha
addi r4, r4,  SafeStringEventName@l
lis r5, SafeStringEntryPoint@ha
addi r5, r5, SafeStringEntryPoint@l
li r6, 0
li r7, 0

; Branch to ksys::evt::callEvent()
bctrl

ResetAndReturn:
mr r3, r30
lwz r28, 0x0008 (r1)
addi r1, r1, 0x0010
lwz r0, 0x0004 (r1) ; Retreive stashed LR data
mtlr r0 ; Retreive stashed LR data
blr ; Return to vanilla code
