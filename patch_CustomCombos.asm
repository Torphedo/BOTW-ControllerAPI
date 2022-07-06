[TorphEventPlayer]
moduleMatches = 0x6267bfd0
.origin = codecave

; Set your event name / entry point name here.
EventFlowName:
.string "FaroreFlow"

EntryPointName:
.string "Trigger"

CustomCombos:
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

; Proceed to play event if all checks pass
bla PlayEvent
b ExitCodecave

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

; Advanced Info:
;
; The offsets in the table are actually tracking how long a button has been held for. When it
; equals a register set to 0x00000000, that means it's been held for 0 frames (not pressed).
; Each button gets 2 bytes for counting how long it's been held, which is why the code only
; loads half words. The value for any given button will increment by 0x01 each frame. Anyways,
; you could use this knowledge to set up an event that will only trigger if you hold a set of
; buttons for 1 second, or something like that.
;
; There's another set of offsets starting at 0x68, which appear to be in the same order as
; the ones in the table, 2 bytes apart. These ones appear to increment by 0x222 each frame, which
; is a little weird. The half-words at 0x38, 0x48, 0x4C, and 0x4E are in the same section as
; the other offsets listed in the table, but don't seem to correspond to any button.
;
; The 8 bytes from 0x50 to 0x57 are vector2f data for the left stick, and the 8 bytes from 0x58
; to 0x5F are vector2f data for the right stick. The bytes at 0x10D and 0x10C will have different
; values depending on the rotation of the left and right stick respectively, but only if they're
; past a certain threshold from the center.
;
; Also, there's a section you can find at 0x108 which increments by 0x01 every frame, and resets to
; 0 when ANY input is detected.
;




; Options for advanced users.
SafeStringEventName:
.int EventFlowName ; String defined at top of this file
.int 0x10263910 ; vtable pointer for sead::SafeStringBase class. Required to construct a SafeString object.

SafeStringEntryPoint:
.int EntryPointName
.int 0x10263910

EventFnParams:
; Set parameters for callEvent() function
li r3, 0                            ; Actor nullptr
lis r4, SafeStringEventName@ha
addi r4, r4,  SafeStringEventName@l
lis r5, SafeStringEntryPoint@ha
addi r5, r5, SafeStringEntryPoint@l
li r6, 0                            ; bool isPauseOtherActors (overridden by eventinfo)
li r7, 0                            ; bool skipIsStartableAirCheck (overridden by eventinfo)
blr
