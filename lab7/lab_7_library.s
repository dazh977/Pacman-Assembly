
	.data
	.global instruction
	.global instruction2
	.global instructionPac
	.global instructionGhost
	.global instructionRule
	.global instructionRule2
	.global promptScore
	.global promptUpper
	.global promptLower
	.global promptboard
	.global promptboard2
	.global promptboard3
	.global promptboard4
	.global promptboard5
	.global promptboard6
	.global promptboard7
	.global promptboard8
	.global promptboard9
	.global newAddressLab7
	.global newAddressLab7M
	.global newAddressLab7M2
	.global newAddressLab7M3
	.global newAddressLab7M4
	.global newAddressLab7Mback
	.global num1M1
	.global num1M2
	.global num1M3
	.global num1M4
	.global numw
	.global	nums
	.global	numa
	.global numd
	.global num1
	.global numPelletEat
	.global flagPrint
	.global flagPellet
	.global flagMoveM
	.global flagMoveM2
	.global flagMoveM3
	.global flagMoveM4
	.global okToMoveMs
	.global numquit
	.global promptExitGame
	.global numSupermode
	.global gamestartaddress
	.global lifetime
	.global scoretime
	.global trackMPath	;used to remember what M encoutered, and put it back when M passed
	.global trackMBehind
	.global trackM2Path	;used to remember what M encoutered, and put it back when M passed
	.global trackM2Behind
	.global trackM3Path
	.global trackM3Behind
	.global trackM4Path
	.global trackM4Behind
	.global speedSwap
	.global pause
	.global pauseMenu
	.global levelSpeed		;newly added
	.global timer0Control	;newly added
	.global timer1Control	;newly added

numw: .string "w", 0	;memory location that stores i direction
nums: .string "s", 0	;memory location that stores j direction
numa: .string "a", 0	;memory location that stores i direction
numd: .string "d", 0	;memory location that stores i direction
numPelletEat:	.string "00000000", 0	;Count the number of pellets eaten
;Board configurations
instructionPac:	.string 27, "[32mGame rules: the pacman is controlled by user. Life lost if it touches ghosts.", 0xA,0xD
instructionGhost:	.string "The 4 ghosts cannot be controlled by user, but they randomly navigate in maze.", 0xA,0xD
instructionRule2:	.string "You have 3 lives. Game ends when live is 0. p (lowercase) can be use to pause game.", 0xA,0xD
instructionRule:	.string "To control pac-man:", 0
instruction:	.string "press w for up s for down, a for left, d for right (all Lowercase).", 0
instruction2:	.string "Start game? 1 (decimal) for yes, 2 (decimal) for no: ", 0
promptScore:	.string 27, "[37;0m        Score:  0000	        ", 0xA,0xD
promptUpper:	.string "+---------------------------+", 0xA,0xD
promptboard:	.string "|O.....|.............|.....O|", 0xA,0xD
promptboard2:	.string "|.+--+.|.-----------.|.+--+.|", 0xA,0xD
promptboard3:	.string "|.|  |.................|  |.|", 0xA,0xD
promptboard4:	.string "|.+--+.|------ ------|.+--|.|", 0xA,0xD
promptboard5:	.string " ......|    MM MM    |...... ", 0xA,0xD
promptboard6:	.string "|.|--+.|-------------|.+--|.|", 0xA,0xD
promptboard7:	.string "|.|  |........<........|  |.|", 0xA,0xD
promptboard8:	.string "|.+--+.|.-----------.|.+--+.|", 0xA,0xD
promptboard9:	.string "|O.....|.............|.....O|", 0xA,0xD
promptLower:	.string "+---------------------------+", 0
newAddressLab7:	.string "00000000", 0
newAddressLab7M:	.string "00000000", 0
newAddressLab7M2:	.string "00000000", 0
newAddressLab7M3:	.string "00000000", 0
newAddressLab7M4:	.string "00000000", 0
newAddressLab7Mback:	.string "00000000", 0
num1:	.string "0", 0
num1M1:	.string "0", 0
num1M2:	.string "0", 0
num1M3:	.string "0", 0
num1M4:	.string "0", 0
okToMoveMs:	.string "0", 0
flagPrint:	.string "0", 0
flagPellet:	.string "00", 0
flagMoveM:	.string "0", 0
flagMoveM2:	.string "0", 0
flagMoveM3:	.string "0", 0
flagMoveM4:	.string "0", 0
numquit:	.string "0", 0
numSupermode: .string "0", 0
lifetime: .string "0", 0
scoretime: .string "0", 0
gamestartaddress: .string "00000000", 0
trackMPath:	.string ".", 0
trackMBehind:	.string ".", 0
trackM2Path:	.string ".", 0
trackM2Behind:	.string ".", 0
trackM3Path:	.string ".", 0
trackM3Behind:	.string ".", 0
trackM4Path:	.string ".", 0
trackM4Behind:	.string ".", 0
promptExitGame:	.string 27, "[35;1mYou used all three lives or you chose to quit. Game ends!", 0
speedSwap:	.string	"0", 0
pause:	.string	"0", 0
pauseMenu:	.string 27, "[33;1mGame paused. Choose one from below (all lowercase): ", 0xA, 0xD, 27,"[32;1mPress y to continue ", 0xA, 0xD, 27, "[36;1mPress r to restart ", 0xA, 0xD, 27, "[31;1mPress n to end game", 0
levelSpeed:	.string "0", 0
timer0Control:	.string "0000", 0
timer1Control:	.string "0000", 0

	.text
	.global lab7
	.global UART0_Handler
	.global Timer0_Handler
	.global Timer1_Handler
	.global Interrupt_init
 	.global timer_init
 	.global timer1_init
 	.global randomGhostMove
 	.global controlPacMan
 	.global checkTheJunctions
	.global uart_init
 	.global output_character
 	.global read_character
 	.global read_string
 	.global output_string
 	.global illuminate_RGB_LED
 	.global restoreMemory1and9
 	.global restoreMemory2and8
 	.global restoreMemory3to7
U0LSR:  .equ 0x18
ptr_to_pauseMenu:	.word pauseMenu
ptr_to_instruction:		.word instruction
ptr_to_instruction2:	.word instruction2
ptr_to_instructionPac:	.word instructionPac
ptr_to_instructionGhost:	.word instructionGhost
ptr_to_instructionRule:	.word instructionRule
ptr_to_instructionRule2:	.word instructionRule2
ptr_to_promptScore:		.word promptScore
ptr_to_promptUpper:		.word promptUpper
ptr_to_promptLower:		.word promptLower
ptr_to_trackMPath:	.word trackMPath
ptr_to_trackMBehind:	.word trackMBehind
ptr_to_trackM2Path:	.word trackM2Path
ptr_to_trackM2Behind:	.word trackM2Behind
ptr_to_trackM3Path:	.word trackM3Path
ptr_to_trackM3Behind:	.word trackM3Behind
ptr_to_trackM4Path:	.word trackM4Path
ptr_to_trackM4Behind:	.word trackM4Behind
ptr_to_levelSpeed:	.word levelSpeed
ptr_to_timer0Control:	.word timer0Control
ptr_to_timer1Control:	.word timer1Control

Timer1_Handler:
 	STMFD SP!,{r0-r12,lr}
	;clear interrupt
	mov r4, #0x1024
	movt r4, #0x4003
	ldr r2, [r4]
	mov r5, #0x0001
	movt r5, #0x0000
	ORR r2, r5, r2
	str r2, [r4]
	;set flag to move ghosts
	ldr r0, ptr_to_okToMoveMs
	mov r4, #0x31
	strb r4, [r0]
	LDMFD sp!, {r0-r12,lr}
 	BX lr

ptr_to_okToMoveMs:	.word okToMoveMs	;This flag indicates that ghosts need to be moved. After moving, restore this flag.
randomGhostMove:
	STMFD SP!, {lr, r0-r12}
;//////	FIRST GHOST //////////////
;Start processing M
	ldr r4, ptr_to_flagMoveM
	ldrb r5, [r4]
	cmp r5, #0x30
	BEQ getOutM1
	cmp r5, #0x31
	beq getOut1
	cmp r5, #0x32
	beq navigateM1
getOutM1:
	ldr r4, ptr_to_newAddressLab7M
	ldr r7, [r4]
	add r7, r7, #1
	mov r5, #0x4D
	strb r5, [r7]
	str r7, [r4]
	mov r5, #0x20
	strb r5, [r7, #-1]
	mov r5, #0x31
	ldr r4, ptr_to_flagMoveM
	strb r5, [r4]
	B doneM
getOut1:;M in middle of box, ready to move up
	ldr r4, ptr_to_newAddressLab7M
	ldr r7, [r4]
	ldr r5, ptr_to_newAddressLab7back
	str r7, [r5]
	sub r7, r7, #31
	ldrb r5, [r7]
	cmp r5, #0x2D
	beq navigateM1
	mov r5, #0x4D
	strb r5, [r7]
	str r7, [r4]
	mov r5, #0x20
	strb r5, [r7, #31]
	ldr r4, ptr_to_num1M1
	mov r5, #0x55
	strb r5, [r4]
	B doneM
navigateM1:
	ldr r4, ptr_to_flagMoveM
	mov r5, #0x32
	strb r5, [r4]
	;set flag to get back from label of check junctions
	ldr r4, ptr_to_numquit
	mov r5, #0x31
	strb r5, [r4]
	mov r5, #0
	;obtain current adress of first M
	ldr r4, ptr_to_newAddressLab7M
	ldr r7, [r4]
	mov r0, r7
	BL chaseorAwayM1
	cmp r1, #0x30
	beq leftNormalM1
	B startCheckDirectionM1
leftNormalM1:
	B checkTheJunctions
;////////////////////////
startCheckDirectionM1:
	;check direction flag
	ldr r4, ptr_to_num1M1
	ldrb r5, [r4]
	cmp r5, #0x4C
	beq firstMGoLeft
	cmp r5, #0x52
	beq firstMGoRight
	cmp r5, #0x55
	beq firstMGoUp
	cmp r5, #0x44
	beq firstMGoDown
	B doneM
randomM1:
	mov r6, #0x1048
  	movt r6, #0x4003
	ldrb r5, [r6]
	mov r6, #0x3
	and r5, r5, r6
	cmp r5, #0	;0 for left
	beq firstMGoUp
	cmp r5, #1
	beq firstMGoRight
	cmp r5, #2
	beq firstMGoLeft
	cmp r5, #3
	beq firstMGoDown
	B doneM
firstMGoLeft:
	ldrb r5, [r7, #-1]
	cmp r5, #0x7C
	bne M1Left	;left is wall, cannot preceed, random again
	B randomM1
M1Left:
	cmp r5, #0x2b
	beq randomM1
	cmp r5, #0x2d
	beq randomM1
	cmp r5, #0xD
	beq flipM1Left
	ldr r6, ptr_to_trackMPath
	ldrb r5, [r7, #-1]
	cmp r5, #0x3c
	beq pacLeftEatenM1
	cmp r5, #0x4d
	beq leftPassMM1
	ldrb r5, [r7, #-1]
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM1
pacLeftEatenM1:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	mov r1, #0x20
	B leftMemoryM1
leftPassMM1:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM1
lookLeftM3:
	ldr r10, ptr_to_newAddressLab7M3
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookM4
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM1
lookM4:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM1
flipM1Left:
	add r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #-28]
	B flipM1LeftMemory
leftMemoryM1:
	ldr r6, ptr_to_trackMBehind
	ldrb r5, [r6]
	strb r5, [r7, #1]
	strb r1, [r6]
flipM1LeftMemory:
	ldr r4, ptr_to_newAddressLab7M
	str r7, [r4]
	mov r5, #0x4C
	ldr r4, ptr_to_num1M1
	strb r5, [r4]
	B doneM1
firstMGoRight:
	ldrb r5, [r7, #1]
	cmp r5, #0x7C
	bne M1Right	;left is wall, cannot preceed, random again
	B randomM1
M1Right:
	cmp r5, #0x2b
	beq randomM1
	cmp r5, #0x2d
	beq randomM1
	cmp r5, #0xA
	beq flipM1Right
	ldr r6, ptr_to_trackMPath
	ldrb r5, [r7, #1]
	cmp r5, #0x4d
	beq rightPassMM1
	cmp r5, #0x3c
	beq pacRightEatenM1
	ldrb r5, [r7, #1]
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM1
pacRightEatenM1:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #1]!
	mov r1, #0x20
	B rightMemoryM1
rightPassMM1:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM1
lookRightM3:
	ldr r10, ptr_to_newAddressLab7M3
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM4
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM1
lookRightM4:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM1
flipM1Right:
	sub r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #28]
	B flipM1RightMemory
rightMemoryM1:
	ldr r6, ptr_to_trackMBehind
	ldrb r5, [r6]
	strb r5, [r7, #-1]
	strb r1, [r6]
flipM1RightMemory:
	ldr r4, ptr_to_newAddressLab7M
	str r7, [r4]
	mov r5, #0x52
	ldr r4, ptr_to_num1M1
	strb r5, [r4]
	B doneM1
firstMGoUp:
	ldrb r5, [r7, #-31]
	cmp r5, #0x2D
	bne M1Up
	B randomM1	;left is wall, cannot preceed, random again
M1Up:
	cmp r5, #0x2b
	beq randomM1
	cmp r5, #0x7c
	beq randomM1
	ldrb r5, [r7, #-31]
	ldr r6, ptr_to_trackMPath
	cmp r5, #0x4d
	beq upPassMM1
	cmp r5, #0x3c
	beq pacUpEatenM1
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B upisNotMM1
pacUpEatenM1:
	BL clear
	mov r1, #0x20
	B upisNotMM1
upPassMM1:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	B upisNotMM1
lookUpM3:
	ldr r10, ptr_to_newAddressLab7M3
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookUpM4
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	B upisNotMM1
lookUpM4:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
upisNotMM1:
	mov r5, #0x4D
	strb r5, [r7, #-31]!
	ldr r6, ptr_to_trackMBehind
	ldrb r5, [r6]
	strb r5, [r7, #31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M
	str r7, [r4]
	mov r5, #0x55
	ldr r4, ptr_to_num1M1
	strb r5, [r4]
	B doneM1
firstMGoDown:
	ldr r12, ptr_to_promptboard4	;if right above the center box, do not enter again
	add r12, r12, #14
	add r7, r7, #31
	cmp r7, r12
	sub r7, r7, #31
	BEQ randomM1
	ldrb r5, [r7, #31]
	cmp r5, #0x2D
	bne M1Down
	B randomM1	;left is wall, cannot preceed, random again
M1Down:
	cmp r5, #0x2b
	beq randomM1
	cmp r5, #0x7c
	beq randomM1
	ldrb r5, [r7, #31]
	ldr r6, ptr_to_trackMPath
	cmp r5, #0x4d
	beq downPassMM1
	cmp r5, #0x3c
	beq pacDownEatenM1
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B downisNotMM1
pacDownEatenM1:
	BL clear
	mov r1, #0x20
	B downisNotMM1
downPassMM1:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	B downisNotMM1
lookDownM3:
	ldr r10, ptr_to_newAddressLab7M3
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM4
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	B downisNotMM1
lookDownM4:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
downisNotMM1:
	mov r5, #0x4D
	strb r5, [r7, #31]!
	ldr r6, ptr_to_trackMBehind
	ldrb r5, [r6]
	strb r5, [r7, #-31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M
	str r7, [r4]
	mov r5, #0x44
	ldr r4, ptr_to_num1M1
	strb r5, [r4]
	B doneM1
doneM1:
;//////	SECOND GHOST //////////////
	;for second M to go out
	ldr r4, ptr_to_flagMoveM2
	ldrb r5, [r4]
	cmp r5, #0x30
	beq getOutM2
	cmp r5, #0x31
	beq exitUpM2
	cmp r5, #0x32
	beq navigateM2
getOutM2:
	ldr r4, ptr_to_newAddressLab7M2
	ldr r7, [r4]
	mov r5, #0x4D
	strb r5, [r7, #-29]
	mov r5, #0x20
	strb r5, [r7]
	sub r7, r7, #29
	str r7, [r4]
	ldr r4, ptr_to_flagMoveM2
	mov r5, #0x31
	strb r5, [r4]
	B doneM
exitUpM2:
	ldr r4, ptr_to_flagMoveM2
	mov r5, #0x32
	strb r5, [r4]
	ldr r4, ptr_to_newAddressLab7M2
	ldr r7, [r4]
	sub r7, r7, #31
	ldrb r5, [r7]
	cmp r5, #0x2D
	beq navigateM2
	mov r5, #0x4D
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #31]
	str r7, [r4]
	B doneM
navigateM2:
	ldr r4, ptr_to_numquit
	mov r5, #0x32
	strb r5, [r4]
	ldr r4, ptr_to_newAddressLab7M2
	ldr r7, [r4]
	mov r0, r7
	BL chaseorAwayM2
	cmp r1, #0x30
	beq normalM2
	B startCheckDirectionM2
;////check if junction reached
normalM2:
	B checkTheJunctions
startCheckDirectionM2:
	;check direction flag
	ldr r4, ptr_to_num1M2
	ldrb r5, [r4]
	cmp r5, #0x4C
	beq secondMGoLeft
	cmp r5, #0x52
	beq secondMGoRight
	cmp r5, #0x55
	beq secondMGoUp
	cmp r5, #0x44
	beq secondMGoDown
	B randomM2
randomM2:
	mov r6, #0x1048
  	movt r6, #0x4003
	ldrb r5, [r6]
	mov r6, #0x3
	and r5, r5, r6
	cmp r5, #0	;0 for left
	beq secondMGoUp
	cmp r5, #1
	beq secondMGoRight
	cmp r5, #2
	beq secondMGoLeft
	cmp r5, #3
	beq secondMGoDown
	B doneM
secondMGoLeft:
	ldrb r5, [r7, #-1]
	cmp r5, #0x7C
	bne M2Left	;left is wall, cannot preceed, random again
	B randomM2
M2Left:
	cmp r5, #0xD
	beq flipM2Left
	ldr r6, ptr_to_trackM2Path
	ldrb r5, [r7, #-1]
	cmp r5, #0x4d
	beq leftPassMM2
	cmp r5, #0x3c
	beq pacLeftEatenM2
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM2
pacLeftEatenM2:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	mov r1, #0x20
	B leftMemoryM2
leftPassMM2:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM3M2
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM2
lookLeftM3M2:
	ldr r10, ptr_to_newAddressLab7M3
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM4M2
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM2
lookLeftM4M2:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM2
flipM2Left:
	add r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #-28]
	B flipM2LeftMemory
leftMemoryM2:
	ldr r6, ptr_to_trackM2Behind
	ldrb r5, [r6]
	strb r5, [r7, #1]
	strb r1, [r6]
flipM2LeftMemory:
	ldr r4, ptr_to_newAddressLab7M2
	str r7, [r4]
	mov r5, #0x4C
	ldr r4, ptr_to_num1M2
	strb r5, [r4]
	B doneM3
secondMGoRight:
	ldrb r5, [r7, #1]
	cmp r5, #0x7C
	bne M2Right	;left is wall, cannot preceed, random again
	B randomM2
M2Right:
	cmp r5, #0xA
	beq flipM2Right
	ldr r6, ptr_to_trackM2Path
	ldrb r5, [r7, #1]
	cmp r5, #0x4d
	beq rightPassMM2
	cmp r5, #0x3c
	beq pacRightEatenM2
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM2
pacRightEatenM2:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #1]!
	mov r1, #0x20
	B rightMemoryM2
rightPassMM2:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM3M2
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM2
lookRightM3M2:
	ldr r10, ptr_to_newAddressLab7M3
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM4M2
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM2
lookRightM4M2:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM2
flipM2Right:
	sub r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #28]
	B flipM2RightMemory
rightMemoryM2:
	ldr r6, ptr_to_trackM2Behind
	ldrb r5, [r6]
	strb r5, [r7, #-1]
	strb r1, [r6]
flipM2RightMemory:
	ldr r4, ptr_to_newAddressLab7M2
	str r7, [r4]
	mov r5, #0x52
	ldr r4, ptr_to_num1M2
	strb r5, [r4]
	B doneM3
secondMGoUp:
	ldrb r5, [r7, #-31]
	cmp r5, #0x2D
	bne M2Up
	B randomM2;left is wall, cannot preceed, random again
M2Up:
	ldrb r5, [r7, #-31]
	cmp r5, #0x4d
	beq upPassMM2
	cmp r5, #0x3c
	beq pacUpEatenM2
	ldr r6, ptr_to_trackM2Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B upisnotMM2
pacUpEatenM2:
	BL clear
	mov r1, #0x20
	B upisnotMM2
upPassMM2:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM3M2
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	B upisnotMM2
lookUpM3M2:
	ldr r10, ptr_to_newAddressLab7M3
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM4M2
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	B upisnotMM2
lookUpM4M2:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
upisnotMM2:
	mov r5, #0x4D
	strb r5, [r7, #-31]!
	ldr r6, ptr_to_trackM2Behind
	ldrb r5, [r6]
	strb r5, [r7, #31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M2
	str r7, [r4]
	mov r5, #0x55
	ldr r4, ptr_to_num1M2
	strb r5, [r4]
	B doneM3
secondMGoDown:
	ldr r12, ptr_to_promptboard4	;if right above the center box, do not enter again
	add r12, r12, #14
	add r7, r7, #31
	cmp r7, r12
	sub r7, r7, #31
	BEQ randomM2
	ldrb r5, [r7, #31]
	cmp r5, #0x2D
	bne M2Down
	B randomM2	;left is wall, cannot preceed, random again
M2Down:
	ldrb r5, [r7, #31]
	cmp r5, #0x4d
	beq downPassMM2
	cmp r5, #0x3c
	beq pacDownEatenM2
	ldr r6, ptr_to_trackM2Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B downisnotMM2
pacDownEatenM2:
	BL clear
	mov r1, #0x20
	B downisnotMM2
downPassMM2:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM3M2
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	B downisnotMM2
lookDownM3M2:
	ldr r10, ptr_to_newAddressLab7M3
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookDownM4M2
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	B downisnotMM2
lookDownM4M2:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
downisnotMM2:
	mov r5, #0x4D
	strb r5, [r7, #31]!
	ldr r6, ptr_to_trackM2Behind
	ldrb r5, [r6]
	strb r5, [r7, #-31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M2
	str r7, [r4]
	mov r5, #0x44
	ldr r4, ptr_to_num1M2
	strb r5, [r4]
	B doneM3
;///////////////Third Ghost/////////////////////
doneM3:
	;for third M to go out
	ldr r4, ptr_to_flagMoveM3
	ldrb r5, [r4]
	cmp r5, #0x30
	beq getOutM3
	cmp r5, #0x31
	beq exitUpM3
	cmp r5, #0x32
	beq navigateM3
getOutM3:
	ldr r4, ptr_to_newAddressLab7M3
	ldr r7, [r4]
	mov r5, #0x4D
	strb r5, [r7, #-32]
	mov r5, #0x20
	strb r5, [r7]
	sub r7, r7, #32
	str r7, [r4]
	ldr r4, ptr_to_flagMoveM3
	mov r5, #0x31
	strb r5, [r4]
	B doneM
exitUpM3:
	ldr r4, ptr_to_flagMoveM3
	mov r5, #0x32
	strb r5, [r4]
	ldr r4, ptr_to_newAddressLab7M3
	ldr r7, [r4]
	sub r7, r7, #31
	ldrb r5, [r7]
	cmp r5, #0x2D
	beq navigateM3
	mov r5, #0x4D
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #31]
	str r7, [r4]
	B doneM
navigateM3:
	ldr r4, ptr_to_numquit
	mov r5, #0x33
	strb r5, [r4]
	;mov r5, #0
	ldr r4, ptr_to_newAddressLab7M3
	ldr r7, [r4]
	mov r0, r7
	BL chaseorAwayM3
	cmp r1, #0x30
	beq normalM3
	B startCheckDirectionM3
;////check if junction reached
normalM3:
	B checkTheJunctions
startCheckDirectionM3:
	;check direction flag
	ldr r4, ptr_to_num1M3
	ldrb r5, [r4]
	cmp r5, #0x4C
	beq thirdMGoLeft
	cmp r5, #0x52
	beq thirdMGoRight
	cmp r5, #0x55
	beq thirdMGoUp
	cmp r5, #0x44
	beq thirdMGoDown
	B randomM3
randomM3:
	mov r6, #0x1048
  	movt r6, #0x4003
	ldrb r5, [r6]
	mov r6, #0x3
	and r5, r5, r6
	cmp r5, #0	;0 for left
	beq thirdMGoUp
	cmp r5, #1
	beq thirdMGoRight
	cmp r5, #2
	beq thirdMGoLeft
	cmp r5, #3
	beq thirdMGoDown
	B doneM
thirdMGoLeft:
	ldrb r5, [r7, #-1]
	cmp r5, #0x7C
	bne M3Left	;left is wall, cannot preceed, random again
	B randomM3
M3Left:
	cmp r5, #0xD
	beq flipM3Left
	ldr r6, ptr_to_trackM3Path
	ldrb r5, [r7, #-1]
	cmp r5, #0x4d
	beq leftPassMM3
	cmp r5, #0x3c
	beq pacLeftEatenM3
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM3
pacLeftEatenM3:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	mov r1, #0x20
	B leftMemoryM3
leftPassMM3:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM2M3
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM3
lookLeftM2M3:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM4M3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM3
lookLeftM4M3:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM3
flipM3Left:
	add r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #-28]
	B flipM3LeftMemory
leftMemoryM3:
	ldr r6, ptr_to_trackM3Behind
	ldrb r5, [r6]
	strb r5, [r7, #1]
	strb r1, [r6]
flipM3LeftMemory:
	ldr r4, ptr_to_newAddressLab7M3
	str r7, [r4]
	mov r5, #0x4C
	ldr r4, ptr_to_num1M3
	strb r5, [r4]
	B doneM4
thirdMGoRight:
	ldrb r5, [r7, #1]
	cmp r5, #0x7C
	bne M3Right	;left is wall, cannot preceed, random again
	B randomM3
M3Right:
	cmp r5, #0xA
	beq flipM3Right
	ldr r6, ptr_to_trackM3Path
	ldrb r5, [r7, #1]
	cmp r5, #0x4d
	beq rightPassMM3
	cmp r5, #0x3c
	beq pacRightEatenM3
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM3
pacRightEatenM3:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #1]!
	mov r1, #0x20
	B rightMemoryM3
rightPassMM3:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM2M3
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM3
lookRightM2M3:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM4M3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM3
lookRightM4M3:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM3
flipM3Right:
	sub r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #28]
	B flipM3RightMemory
rightMemoryM3:
	ldr r6, ptr_to_trackM3Behind
	ldrb r5, [r6]
	strb r5, [r7, #-1]
	strb r1, [r6]
flipM3RightMemory:
	ldr r4, ptr_to_newAddressLab7M3
	str r7, [r4]
	mov r5, #0x52
	ldr r4, ptr_to_num1M3
	strb r5, [r4]
	B doneM4
thirdMGoUp:
	ldrb r5, [r7, #-31]
	cmp r5, #0x2D
	bne M3Up
	B randomM3;left is wall, cannot preceed, random again
M3Up:
	ldrb r5, [r7, #-31]
	cmp r5, #0x4d
	beq upPassMM3
	cmp r5, #0x3c
	beq pacUpEatenM3
	ldr r6, ptr_to_trackM3Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B upisnotMM3
pacUpEatenM3:
	BL clear
	mov r1, #0x20
	B upisnotMM3
upPassMM3:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM2M3
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-31]!
	B upisnotMM3
lookUpM2M3:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM4M3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-31]!
	B upisnotMM3
lookUpM4M3:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
	mov r5, #0x4d
upisnotMM3:
	mov r5, #0x4D
	strb r5, [r7, #-31]!
	ldr r6, ptr_to_trackM3Behind
	ldrb r5, [r6]
	strb r5, [r7, #31]
	strb r1, [r6]	;update trackM3Behind content
	ldr r4, ptr_to_newAddressLab7M3
	str r7, [r4]
	mov r5, #0x55
	ldr r4, ptr_to_num1M3
	strb r5, [r4]
	B doneM4
thirdMGoDown:
	ldr r12, ptr_to_promptboard4	;if right above the center box, do not enter again
	add r12, r12, #14
	add r7, r7, #31
	cmp r7, r12
	sub r7, r7, #31
	BEQ randomM3
	ldrb r5, [r7, #31]
	cmp r5, #0x2D
	bne M3Down
	B randomM3	;left is wall, cannot preceed, random again
M3Down:
	ldrb r5, [r7, #31]
	cmp r5, #0x4d
	beq downPassMM3
	cmp r5, #0x3c
	beq pacDownEatenM3
	ldr r6, ptr_to_trackM3Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B downisnotMM3
pacDownEatenM3:
	BL clear
	mov r1, #0x20
	B downisnotMM3
downPassMM3:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM2M3
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #31]!
	B downisnotMM3
lookDownM2M3:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookUpM4M3
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #31]!
	B upisnotMM3
lookDownM4M3:
	ldr r11, ptr_to_trackM4Behind
	ldrb r1, [r11]
downisnotMM3:
	mov r5, #0x4D
	strb r5, [r7, #31]!
	ldr r6, ptr_to_trackM3Behind
	ldrb r5, [r6]
	strb r5, [r7, #-31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M3
	str r7, [r4]
	mov r5, #0x44
	ldr r4, ptr_to_num1M3
	strb r5, [r4]
	B doneM4
doneM4:
;//////	Fourth GHOST \\\\\\\\\\\\\\\\\\\;
;for fourth M to go out
	ldr r4, ptr_to_flagMoveM4
	ldrb r5, [r4]
	cmp r5, #0x30
	beq getOutM4
	cmp r5, #0x31
	beq exitUpM4
	cmp r5, #0x32
	beq navigateM4
getOutM4:
	ldr r4, ptr_to_newAddressLab7M4
	ldr r7, [r4]
	mov r5, #0x4D
	strb r5, [r7, #-33]
	mov r5, #0x20
	strb r5, [r7]
	sub r7, r7, #33
	str r7, [r4]
	ldr r4, ptr_to_flagMoveM4
	mov r5, #0x31
	strb r5, [r4]
	B doneM
exitUpM4:
	ldr r4, ptr_to_flagMoveM4
	mov r5, #0x32
	strb r5, [r4]
	ldr r4, ptr_to_newAddressLab7M4
	ldr r7, [r4]
	sub r7, r7, #31
	ldrb r5, [r7]
	cmp r5, #0x2D
	beq navigateM4
	mov r5, #0x4D
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #31]
	str r7, [r4]
	B doneM
navigateM4:
	ldr r4, ptr_to_numquit
	mov r5, #0x34
	strb r5, [r4]
	;mov r5, #0
	ldr r4, ptr_to_newAddressLab7M4
	ldr r7, [r4]
	mov r0, r7
	BL chaseorAwayM4
	cmp r1, #0x30
	beq normalM4
	B startCheckDirectionM4
;////check if junction reached
normalM4:
	B checkTheJunctions
startCheckDirectionM4:
	;check direction flag
	ldr r4, ptr_to_num1M4
	ldrb r5, [r4]
	cmp r5, #0x4C
	beq fourthMGoLeft
	cmp r5, #0x52
	beq fourthMGoRight
	cmp r5, #0x55
	beq fourthMGoUp
	cmp r5, #0x44
	beq fourthMGoDown
	B randomM4
randomM4:
	mov r6, #0x1048
  	movt r6, #0x4003
	ldrb r5, [r6]
	mov r6, #0x3
	and r5, r5, r6
	cmp r5, #0	;0 for left
	beq fourthMGoUp
	cmp r5, #1
	beq fourthMGoRight
	cmp r5, #2
	beq fourthMGoLeft
	cmp r5, #3
	beq fourthMGoDown
	B doneM
fourthMGoLeft:
	ldrb r5, [r7, #-1]
	cmp r5, #0x7C
	bne M4Left	;left is wall, cannot preceed, random again
	B randomM4
M4Left:
	cmp r5, #0xD
	beq flipM4Left
	ldr r6, ptr_to_trackM4Path
	ldrb r5, [r7, #-1]
	cmp r5, #0x4d
	beq leftPassMM4
	cmp r5, #0x3c	;if pac man on path, eat it and place space on that position.
	beq pacLeftEatenM4
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM4
pacLeftEatenM4:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	mov r1, #0x20
	B leftMemoryM4
leftPassMM4:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM2M4
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM4
lookLeftM2M4:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #1
	cmp r7, r10
	add r7, r7, #1
	bne lookLeftM3M4
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM4
lookLeftM3M4:
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-1]!
	B leftMemoryM4
flipM4Left:
	add r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #-28]
	B flipM4LeftMemory
leftMemoryM4:
	ldr r6, ptr_to_trackM4Behind
	ldrb r5, [r6]
	strb r5, [r7, #1]
	strb r1, [r6]
flipM4LeftMemory:
	ldr r4, ptr_to_newAddressLab7M4
	str r7, [r4]
	mov r5, #0x4C
	ldr r4, ptr_to_num1M4
	strb r5, [r4]
	B doneM
fourthMGoRight:
	ldrb r5, [r7, #1]
	cmp r5, #0x7C
	bne M4Right	;left is wall, cannot preceed, random again
	B randomM4
M4Right:
	cmp r5, #0xA
	beq flipM4Right
	ldr r6, ptr_to_trackM4Path
	ldrb r5, [r7, #1]
	cmp r5, #0x4d
	beq rightPassMM4
	cmp r5, #0x3c
	beq pacRightEatenM4
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM4
pacRightEatenM4:
	BL clear
	mov r5, #0x4d
	strb r5, [r7, #1]!
	mov r1, #0x20
	B rightMemoryM4
rightPassMM4:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM2M4
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM4
lookRightM2M4:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #1
	cmp r7, r10
	sub r7, r7, #1
	bne lookRightM3M4
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM4
lookRightM3M4:
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #1]!
	B rightMemoryM4
flipM4Right:
	sub r7, r7, #28
	mov r5, #0x4d
	strb r5, [r7]
	mov r5, #0x20
	strb r5, [r7, #28]
	B flipM4RightMemory
rightMemoryM4:
	ldr r6, ptr_to_trackM4Behind
	ldrb r5, [r6]
	strb r5, [r7, #-1]
	strb r1, [r6]
flipM4RightMemory:
	ldr r4, ptr_to_newAddressLab7M4
	str r7, [r4]
	mov r5, #0x52
	ldr r4, ptr_to_num1M4
	strb r5, [r4]
	B doneM
fourthMGoUp:
	ldrb r5, [r7, #-31]
	cmp r5, #0x2D
	bne M4Up
	B randomM4;left is wall, cannot preceed, random again
M4Up:
	ldrb r5, [r7, #-31]
	cmp r5, #0x4d
	beq upPassMM4
	cmp r5, #0x3c
	beq pacUpEatenM4
	ldr r6, ptr_to_trackM4Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B upisnotMM4
pacUpEatenM4:
	BL clear
	mov r1, #0x20
	B upisnotMM4
upPassMM4:
	ldr r10, ptr_to_newAddressLab7M
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM2M4
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-31]!
	B upisnotMM4
lookUpM2M4:
	ldr r10, ptr_to_newAddressLab7M2
	sub r7, r7, #31
	cmp r7, r10
	add r7, r7, #31
	bne lookUpM3M4
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #-31]!
	B upisnotMM4
lookUpM3M4:
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
upisnotMM4:
	mov r5, #0x4D
	strb r5, [r7, #-31]!
	ldr r6, ptr_to_trackM4Behind
	ldrb r5, [r6]
	strb r5, [r7, #31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M4
	str r7, [r4]
	mov r5, #0x55
	ldr r4, ptr_to_num1M4
	strb r5, [r4]
	B doneM
fourthMGoDown:
	ldr r12, ptr_to_promptboard4	;if right above the center box, do not enter again
	add r12, r12, #14
	add r7, r7, #31
	cmp r7, r12
	sub r7, r7, #31
	BEQ randomM4
	ldrb r5, [r7, #31]
	cmp r5, #0x2D
	bne M4Down
	B randomM4	;left is wall, cannot preceed, random again
M4Down:
	ldrb r5, [r7, #31]
	cmp r5, #0x4d
	beq downPassMM4
	cmp r5, #0x3c
	beq pacDownEatenM4
	ldr r6, ptr_to_trackM4Path
	mov r1, r5
	strb r5, [r6]	;store character to be covered by M
	B downisnotMM4
pacDownEatenM4:
	BL clear
	mov r1, #0x20
	B downisnotMM4
downPassMM4:
	ldr r10, ptr_to_newAddressLab7M
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM2M4
	ldr r11, ptr_to_trackMBehind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #31]!
	B downisnotMM4
lookDownM2M4:
	ldr r10, ptr_to_newAddressLab7M2
	add r7, r7, #31
	cmp r7, r10
	sub r7, r7, #31
	bne lookDownM3M4
	ldr r11, ptr_to_trackM2Behind
	ldrb r1, [r11]
	mov r5, #0x4d
	strb r5, [r7, #31]!
	B downisnotMM4
lookDownM3M4:
	ldr r11, ptr_to_trackM3Behind
	ldrb r1, [r11]
downisnotMM4:
	mov r5, #0x4D
	strb r5, [r7, #31]!
	ldr r6, ptr_to_trackM4Behind
	ldrb r5, [r6]
	strb r5, [r7, #-31]
	strb r1, [r6]
	ldr r4, ptr_to_newAddressLab7M4
	str r7, [r4]
	mov r5, #0x44
	ldr r4, ptr_to_num1M4
	strb r5, [r4]
	B doneM
checkTheJunctions:
	ldr r4, ptr_to_numquit
	ldrb r5, [r4]
	cmp r5, #0x30
	beq startCheckDirectionM1
	ldrb r8, [r7, #-31]
	ldrb r9, [r7, #1] ;-| reached
	add r10, r8, r9
	cmp r10, #169
	bne checkNextJunction2
	B assignRandom
checkNextJunction2:
	ldrb r8, [r7, #-31]
	ldrb r9, [r7, #-1]
	add r10, r8, r9
	cmp r10, #169
	bne checkNextJunction3
	B assignRandom
checkNextJunction3:
	ldrb r8, [r7,#31]
	ldrb r9, [r7, #-1]
	add r10, r8, r9
	cmp r10, #169
	bne checkNextJunction4
	B assignRandom
checkNextJunction4:
	ldrb r9, [r7, #31]
	ldrb r9, [r7, #1]
	add r10, r8, r9
	cmp r10, #169
	bne checkOneWallJunction
	B assignRandom
;one wall juntion
checkOneWallJunction:
	mov r10, #0
	ldrb r8, [r7, #-1]	;check left
	cmp r8, #0x7C
	bne notLeftwall
	ldrb r8, [r7, #1]
	ldrb r9, [r7, #31]
	add r10, r8, r9
	ldrb r8, [r7, #-31]
	add r10, r10, r8
	cmp r10, #0x8a	;3 pellets
	beq assignRandom
	cmp r10, #0x7c	;2 pellets
	beq assignRandom
	cmp r10, #0x6e	;1 pellets
	beq assignRandom
	cmp r10, #0x60	;no pellet
	beq assignRandom
;//////////
notLeftwall:
	mov r10, #0
	ldrb r8, [r7, #1]
	cmp r8, #0x7C
	bne notRightwall
	ldrb r8, [r7, #-1]
	ldrb r9, [r7, #31]
	add r10, r8, r9
	ldrb r8, [r7, #-31]
	add r10, r10, r8
	cmp r10, #0x8a	;3 pellets
	beq assignRandom
	cmp r10, #0x7c	;2 pellets
	beq assignRandom
	cmp r10, #0x6e	;1 pellets
	beq assignRandom
	cmp r10, #0x60	;no pellet
	beq assignRandom
;//////////
notRightwall:
;down is wall
	mov r10, #0
	ldrb r8, [r7, #31]
	cmp r8, #0x2d
	bne notDownwall
	ldrb r8, [r7, #-1]
	ldrb r9, [r7, #-31]
	add r10, r8, r9
	ldrb r8, [r7, #1]
	add r10, r10, r8
	cmp r10, #0x8a	;3 pellets
	beq assignRandom
	cmp r10, #0x7c	;2 pellets
	beq assignRandom
	cmp r10, #0x6e	;1 pellets
	beq assignRandom
	cmp r10, #0x60	;no pellet
	beq assignRandom
;//////////
notDownwall:
	mov r10, #0
	ldrb r8, [r7, #-31]
	cmp r8, #0x2d
	bne afterJunction
	ldrb r8, [r7, #-1]
	ldrb r9, [r7, #31]
	add r10, r8, r9
	ldrb r8, [r7, #1]
	add r10, r10, r8
	cmp r10, #0x8a	;3 pellets
	beq assignRandom
	cmp r10, #0x7c	;2 pellets
	beq assignRandom
	cmp r10, #0x6e	;1 pellets
	beq assignRandom
	cmp r10, #0x60	;no pellet
	beq assignRandom
	B afterJunction
assignRandom:
	cmp r5, #0x31
	beq randomM1
	cmp r5, #0x32
	beq randomM2
	cmp r5, #0x33
	beq randomM3
	cmp r5, #0x34
	beq randomM4
	B doneM
afterJunction:
	cmp r5, #0x31
	beq startCheckDirectionM1
	cmp r5, #0x32
	beq startCheckDirectionM2
	cmp r5, #0x33
	beq startCheckDirectionM3
	cmp r5, #0x34
	beq startCheckDirectionM4
doneM:
;junction flag set back to #0x31
	ldr r4, ptr_to_numquit
	mov r5, #0x31
	strb r5, [r4]
	mov r5, #0
;already moved Ms, set back to 0. 1 again when timer set up.
	ldr r4, ptr_to_okToMoveMs
	mov r5, #0x30
	strb r5, [r4]
	LDMFD sp!, {r0-r12, pc}

ptr_to_flagMoveM:	.word flagMoveM
ptr_to_num1:	.word num1	;////pac-man's direction is stored in num1.
ptr_to_promptboard:		.word promptboard
ptr_to_promptboard2:	.word promptboard2
ptr_to_promptboard3:	.word promptboard3
ptr_to_promptboard4:	.word promptboard4
ptr_to_promptboard5:	.word promptboard5
ptr_to_promptboard6:	.word promptboard6
ptr_to_promptboard7:	.word promptboard7
ptr_to_promptboard8:	.word promptboard8
ptr_to_promptboard9:	.word promptboard9
ptr_to_newAddressLab7:	.word newAddressLab7
ptr_to_newAddressLab7M:	.word newAddressLab7M
ptr_to_newAddressLab7M2:	.word newAddressLab7M2
ptr_to_newAddressLab7M3:	.word newAddressLab7M3
ptr_to_newAddressLab7M4:	.word newAddressLab7M4
ptr_to_newAddressLab7back:    .word newAddressLab7Mback
ptr_to_numw:	.word numw
ptr_to_nums:	.word nums
ptr_to_numa:	.word numa
ptr_to_numd:	.word numd
ptr_to_num1M1:	.word num1M1
ptr_to_num1M2:	.word num1M2
ptr_to_num1M3:	.word num1M3
ptr_to_num1M4:	.word num1M4
ptr_to_numPelletEat:	.word numPelletEat
ptr_to_flagPrint:	.word flagPrint
ptr_to_flagPellet:	.word flagPellet
ptr_to_flagMoveM2:	.word flagMoveM2
ptr_to_flagMoveM3:	.word flagMoveM3
ptr_to_flagMoveM4:	.word flagMoveM4
ptr_to_numquit:	.word numquit
ptr_to_numSupermode: .word numSupermode
ptr_to_lifetime:	.word lifetime
ptr_to_scoretime:	.word scoretime
ptr_to_gamestartaddress:	.word gamestartaddress
ptr_to_speedSwap:	.word speedSwap
;/////////////////////////////////
clear:
	STMFD SP!,{r0-r12,lr}
	ldr r4, ptr_to_promptboard7
	add r4, r4, #14
	mov r6, #0x3C
	strb r6, [r4]
	ldr r5, ptr_to_newAddressLab7
	str r4, [r5]
	ldr r4, ptr_to_lifetime
	ldrb r0, [r4]
	add r0, r0, #1
	strb r0, [r4]
	LDMFD sp!, {r0-r12,lr}
	mov pc, lr
;/////////////////////////////
Timer0_Handler:
 	STMFD SP!,{r0-r12,lr}
  	;clear interrupt
	mov r4, #0x0024
	movt r4, #0x4003
	ldr r2, [r4]
	mov r5, #0x0001
	movt r5, #0x0000
	ORR r2, r5, r2
	str r2, [r4]
	;set signal flag
	ldr r4, ptr_to_flagPrint
	mov r2, #0x31
	strb r2, [r4]
	mov r2, #0
  	LDMFD sp!, {r0-r12,lr}
	BX lr

controlPacMan:
	STMFD sp!, {lr, r2-r12}
;start processing
	ldr r4, ptr_to_num1
	ldrb r0, [r4]
	ldr r4, ptr_to_numw
	ldrb r8, [r4]			;load r8 with contents of numi
	CMP r0, r8				;compare with r0
	BEQ gow				;Go to goi if equal.
	ldr r4, ptr_to_nums
	ldrb r8, [r4]
	CMP r8, r0
	BEQ gos
	ldr r4, ptr_to_numa
	ldrb r8, [r4]			;load r8 with contents of numk
	CMP r8, r0				;compare with r0
	BEQ goa					;Go to gok if equal.
	ldr r4, ptr_to_numd
	ldrb r8, [r4]			;load r8 with contents of numm
	CMP r8, r0				;compare with r0
	BEQ god					;Go to gom if equal.
;If user hits keys other than w, s, a, d, ignore the input.
;Or if game yet started, just print the score and board without updating score.
;B printScore
gow:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddressLab7
	ldr r7, [r4]
	SUB r7, r7, #31					;subtract 30 from address in r7, so the < is placed upper
	ldrb r5, [r7]					;load contents of r7 to r5
	cmp r5, #0x20					;check to see if the position upwards is a space
	BNE comparePellteUpper				;if not, compare memory content to a pellte
	B moveToUpper
comparePellteUpper:	cmp r5, #0x2E
	BNE compareMUpper			;PRELIMINARY step, will be changed
	ldr r9, ptr_to_flagPellet
	ldrb r5, [r9]
	add r5, r5, #1
	strb r5, [r9]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #10
	strb r5, [r9]
	B moveToUpper
compareMUpper: cmp r5,#0x4D
	BNE cmpareOUpper
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BEQ Supermode
	B moveToUpper
cmpareOUpper: cmp r5,#0x4F
	BNE finishTimerCompare
	ldr r11, ptr_to_numSupermode
	ldr r10, [r11]
	ADD r10, r10, #16
	str r10, [r11]
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #31]
	str r7, [r4]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #50
	strb r5, [r9]
	B finishTimerCompare
moveToUpper:
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #31]
	str r7, [r4]
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BGT Supertime
	B finishTimerCompare
gos:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddressLab7
	ldr r7, [r4]
	ADD r7, r7, #31
	ldrb r5, [r7]
	cmp r5, #0x20
	BNE comparePellteDown			;if not, compare memory content to a pellte
	B moveToDown
comparePellteDown:	cmp r5, #0x2E
	BNE compareMDown		;PRELIMINARY step, will be changed
	ldr r9, ptr_to_flagPellet
	ldrb r5, [r9]
	add r5, r5, #1
	strb r5, [r9]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #10
	strb r5, [r9]
	B moveToDown
compareMDown: cmp r5,#0x4D
	BNE cmpareODown
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BEQ Supermode
	B moveToDown
cmpareODown: cmp r5,#0x4F
	BNE finishTimerCompare
	ldr r11, ptr_to_numSupermode
	ldr r10, [r11]
	ADD r10, r10, #16
	str r10, [r11]
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #-31]
	str r7, [r4]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #50
	strb r5, [r9]
	B finishTimerCompare
moveToDown:
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #-31]
	str r7, [r4]
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BGT Supertime
	B finishTimerCompare
goa:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddressLab7
	ldr r7, [r4]
	sub r7, r7, #1
	ldrb r5, [r7]
	;check for midway
	cmp r5, #0xD
	bne step2Left
	add r7, r7, #29
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #-28]
	str r7, [r4]
	B finishTimerCompare
	;start handling memory contents
step2Left:	cmp r5, #0x20
	BNE comPellteLeft				;if not, compare if it is a pellte
	B moveToLeft
comPellteLeft:	cmp r5, #0x2E
	BNE compareMLeft			;PRELIMINARY step, will be changed
	ldr r9, ptr_to_flagPellet
	ldrb r5, [r9]
	add r5, r5, #1
	strb r5, [r9]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #10
	strb r5, [r9]
	B moveToLeft
compareMLeft: cmp r5,#0x4D
	BNE cmpareOLeft
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BEQ Supermode
	B moveToLeft
cmpareOLeft: cmp r5,#0x4F
	BNE finishTimerCompare
	ldr r11, ptr_to_numSupermode
	ldr r10, [r11]
	ADD r10, r10, #16
	str r10, [r11]
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #1]
	str r7, [r4]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #50
	strb r5, [r9]
	B finishTimerCompare
moveToLeft:
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #1]
	str r7, [r4]
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BGT Supertime
	B finishTimerCompare
god:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddressLab7
	ldr r7, [r4]
	add r7, r7, #1
	ldrb r5, [r7]
	cmp r5, #0xA
	bne step2Right
	sub r7, r7, #29
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #28]
	str r7, [r4]
	B finishTimerCompare
step2Right:	cmp r5, #0x20
	BNE comPellteRight				;if not, compare if it is a pellte
	B moveToRight
comPellteRight:	cmp r5, #0x2E
	BNE compareMRight			;PRELIMINARY step, will be changed
	ldr r9, ptr_to_flagPellet
	ldrb r5, [r9]
	add r5, r5, #1
	strb r5, [r9]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #10
	strb r5, [r9]
	B moveToRight
compareMRight: cmp r5,#0x4D
	BNE cmpareORight
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BEQ Supermode
	B moveToRight
cmpareORight: cmp r5,#0x4F
	BNE finishTimerCompare
	ldr r11, ptr_to_numSupermode
	ldr r10, [r11]
	ADD r10, r10, #16
	str r10, [r11]
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #-1]
	str r7, [r4]
	ldr r9, ptr_to_scoretime
	ldrb r5, [r9]
	add r5, r5, #50
	strb r5, [r9]
	B finishTimerCompare
moveToRight:
	mov r5, #0x3C
	strb r5, [r7]
	mov r12, #0x20
	strb r12, [r7, #-1]
	str r7, [r4]
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	BGT Supertime
	B finishTimerCompare
Supertime:
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	SUB r10, r10, #1
	strb r10, [r11]
	B finishTimerCompare
Supermode:
	ldr r4, ptr_to_promptboard7
	add r4, r4, #14		;add #14 to find position of *
	mov r6, #0x3C
	strb r6, [r4]
	ldr r5, ptr_to_newAddressLab7
	str r4, [r5]
	ldr r4, ptr_to_lifetime
	ldrb r0, [r4]
	add r0, r0, #1
	strb r0, [r4]
	B finishTimerCompare
finishTimerCompare:

printRedLed:
	ldr r5, ptr_to_numSupermode
	ldrb r0, [r5]
	cmp r0, #0x30
	bgt bluelight
	B led
led:
	ldr r5, ptr_to_lifetime
	ldrb r0, [r5]
	cmp r0, #0x30
	beq greenlight
	cmp r0, #0x31
	beq yellowlight
	cmp r0, #0x32
	beq redlight
	cmp r0, #0x33
	beq FinishTimerandQuit
	mov r0, #0xE
	B turnled
redlight:
	mov r0, #0x2
	B turnled
yellowlight:
	mov r0, #0xA
	B turnled
greenlight:
	mov r0, #0x8
	B turnled
bluelight:
	mov r0, #0x4
	B turnled
turnled:
	BL illuminate_RGB_LED
	;upadte the SCORE here first
	B FinishTimer
FinishTimerandQuit:	ldr r4, ptr_to_numquit
	mov r5, #0x71
	strb r5, [r4]
	B FinishTimerFinal
FinishTimer:
	ldr r11, ptr_to_numSupermode
	ldrb r10, [r11]
	cmp r10, #0x30
	beq FinishTimerFinal
	sub r10, r10, #1
	strb r10, [r11]
	cmp r10, #0x30
	bne FinishTimerFinal	;not last time supermode
	ldr r4, ptr_to_speedSwap
	mov r3, #0x32
	strb r3, [r4]
FinishTimerFinal:
	LDMFD SP!, {lr, r2-r12}
	mov pc, lr


;Subroutines to determine if the pac-man is within 4 grids. If so, approach it. If not, proceed normally.
chaseorAwayM1:
	STMFD sp!, {lr, r2-r12}
;check if pac man is in left
	ldrb r4, [r0, #-1]
	cmp r4, #0x3c
	beq superModeLeftM1
	ldrb r4, [r0, #-2]
	cmp r4, #0x3c
	beq superModeLeftM1
	ldrb r4, [r0, #-3]
	cmp r4, #0x3c
	beq superModeLeftM1
	ldrb r4, [r0, #-4]
	cmp r4, #0x3c
	beq superModeLeftM1
	mov r1, #0x30	;no pac man found
	B donechaseLeftM1
superModeLeftM1:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoLeftM1Left
	mov r6, #0x52
	ldr r5, ptr_to_num1M1
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM1
approachtoLeftM1Left:
	ldr r5, ptr_to_num1M1
	mov r6, #0x4C
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM1
donechaseLeftM1:
;check if pac man is in right
	ldrb r4, [r0, #1]
	cmp r4, #0x3c
	beq superModeRightM1
	ldrb r4, [r0, #2]
	cmp r4, #0x3c
	beq superModeRightM1
	ldrb r4, [r0, #3]
	cmp r4, #0x3c
	beq superModeRightM1
	ldrb r4, [r0, #4]
	cmp r4, #0x3c
	beq superModeRightM1
	mov r1, #0x30	;no pac man found
	B donechaseRightM1
superModeRightM1:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoRightM1Left
	mov r6, #0x4C
	ldr r5, ptr_to_num1M1
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM1
approachtoRightM1Left:
	ldr r5, ptr_to_num1M1
	mov r6, #0x52
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM1
donechaseRightM1:
	;check if pac man is in up direction
	ldrb r4, [r0, #-31]
	cmp r4, #0x3c
	beq superModeUpM1
	ldrb r4, [r0, #-62]
	cmp r4, #0x3c
	beq superModeUpM1
	ldrb r4, [r0, #-93]
	cmp r4, #0x3c
	beq superModeUpM1
	ldrb r4, [r0, #-124]
	cmp r4, #0x3c
	beq superModeUpM1
	mov r1, #0x30	;no pac man found
	B donechaseUpM1
superModeUpM1:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoDownM1Left
	mov r6, #0x44
	ldr r5, ptr_to_num1M1
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM1
approachtoDownM1Left:
	ldr r5, ptr_to_num1M1
	mov r6, #0x55
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM1
donechaseUpM1:
	;check if pac man is in up direction
	ldrb r4, [r0, #31]
	cmp r4, #0x3c
	beq superModeDownM1
	ldrb r4, [r0, #62]
	cmp r4, #0x3c
	beq superModeDownM1
	ldrb r4, [r0, #93]
	cmp r4, #0x3c
	beq superModeDownM1
	ldrb r4, [r0, #124]
	cmp r4, #0x3c
	beq superModeDownM1
	mov r1, #0x30	;no pac man found
	B doneChaseorAwayM1
superModeDownM1:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoUpM1Left
	mov r6, #0x55
	ldr r5, ptr_to_num1M1
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM1
approachtoUpM1Left:
	ldr r5, ptr_to_num1M1
	mov r6, #0x44
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
doneChaseorAwayM1:
	LDMFD sp!, {r2-r12,lr}
	mov pc, lr

chaseorAwayM2:
	STMFD sp!, {lr, r2-r12}
;check if pac man is in left
	ldrb r4, [r0, #-1]
	cmp r4, #0x3c
	beq superModeLeftM2
	ldrb r4, [r0, #-2]
	cmp r4, #0x3c
	beq superModeLeftM2
	ldrb r4, [r0, #-3]
	cmp r4, #0x3c
	beq superModeLeftM2
	ldrb r4, [r0, #-4]
	cmp r4, #0x3c
	beq superModeLeftM2
	mov r1, #0x30	;no pac man found
	B donechaseLeftM2
superModeLeftM2:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoLeftM2Left
	mov r6, #0x52
	ldr r5, ptr_to_num1M2
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM2
approachtoLeftM2Left:
	ldr r5, ptr_to_num1M2
	mov r6, #0x4C
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM2
donechaseLeftM2:
;check if pac man is in right
	ldrb r4, [r0, #1]
	cmp r4, #0x3c
	beq superModeRightM2
	ldrb r4, [r0, #2]
	cmp r4, #0x3c
	beq superModeRightM2
	ldrb r4, [r0, #3]
	cmp r4, #0x3c
	beq superModeRightM2
	ldrb r4, [r0, #4]
	cmp r4, #0x3c
	beq superModeRightM2
	mov r1, #0x30	;no pac man found
	B donechaseRightM2
superModeRightM2:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoRightM2Left
	mov r6, #0x4C
	ldr r5, ptr_to_num1M2
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM2
approachtoRightM2Left:
	ldr r5, ptr_to_num1M2
	mov r6, #0x52
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM2
donechaseRightM2:
	;check if pac man is in up direction
	ldrb r4, [r0, #-31]
	cmp r4, #0x3c
	beq superModeUpM2
	ldrb r4, [r0, #-62]
	cmp r4, #0x3c
	beq superModeUpM2
	ldrb r4, [r0, #-93]
	cmp r4, #0x3c
	beq superModeUpM2
	ldrb r4, [r0, #-124]
	cmp r4, #0x3c
	beq superModeUpM2
	mov r1, #0x30	;no pac man found
	B donechaseUpM2
superModeUpM2:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoDownM2Left
	mov r6, #0x44
	ldr r5, ptr_to_num1M2
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM2
approachtoDownM2Left:
	ldr r5, ptr_to_num1M2
	mov r6, #0x55
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM2
donechaseUpM2:
	;check if pac man is in up direction
	ldrb r4, [r0, #31]
	cmp r4, #0x3c
	beq superModeDownM2
	ldrb r4, [r0, #62]
	cmp r4, #0x3c
	beq superModeDownM2
	ldrb r4, [r0, #93]
	cmp r4, #0x3c
	beq superModeDownM2
	ldrb r4, [r0, #124]
	cmp r4, #0x3c
	beq superModeDownM2
	mov r1, #0x30	;no pac man found
	B doneChaseorAwayM2
superModeDownM2:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoUpM2Left
	mov r6, #0x55
	ldr r5, ptr_to_num1M2
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM2
approachtoUpM2Left:
	ldr r5, ptr_to_num1M2
	mov r6, #0x44
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
doneChaseorAwayM2:
	LDMFD sp!, {r2-r12,lr}
	mov pc, lr

chaseorAwayM3:
	STMFD sp!, {lr, r2-r12}
;check if pac man is in left
	ldrb r4, [r0, #-1]
	cmp r4, #0x3c
	beq superModeLeftM3
	ldrb r4, [r0, #-2]
	cmp r4, #0x3c
	beq superModeLeftM3
	ldrb r4, [r0, #-3]
	cmp r4, #0x3c
	beq superModeLeftM3
	ldrb r4, [r0, #-4]
	cmp r4, #0x3c
	beq superModeLeftM3
	mov r1, #0x30	;no pac man found
	B donechaseLeftM3
superModeLeftM3:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoLeftM3Left
	mov r6, #0x52
	ldr r5, ptr_to_num1M3
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM3
approachtoLeftM3Left:
	ldr r5, ptr_to_num1M3
	mov r6, #0x4C
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM3
donechaseLeftM3:
;check if pac man is in right
	ldrb r4, [r0, #1]
	cmp r4, #0x3c
	beq superModeRightM3
	ldrb r4, [r0, #2]
	cmp r4, #0x3c
	beq superModeRightM3
	ldrb r4, [r0, #3]
	cmp r4, #0x3c
	beq superModeRightM3
	ldrb r4, [r0, #4]
	cmp r4, #0x3c
	beq superModeRightM3
	mov r1, #0x30	;no pac man found
	B donechaseRightM3
superModeRightM3:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoRightM3Left
	mov r6, #0x4C
	ldr r5, ptr_to_num1M3
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM3
approachtoRightM3Left:
	ldr r5, ptr_to_num1M3
	mov r6, #0x52
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM3
donechaseRightM3:
	;check if pac man is in up direction
	ldrb r4, [r0, #-31]
	cmp r4, #0x3c
	beq superModeUpM3
	ldrb r4, [r0, #-62]
	cmp r4, #0x3c
	beq superModeUpM3
	ldrb r4, [r0, #-93]
	cmp r4, #0x3c
	beq superModeUpM3
	ldrb r4, [r0, #-124]
	cmp r4, #0x3c
	beq superModeUpM3
	mov r1, #0x30	;no pac man found
	B donechaseUpM3
superModeUpM3:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoDownM3Left
	mov r6, #0x44
	ldr r5, ptr_to_num1M3
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM3
approachtoDownM3Left:
	ldr r5, ptr_to_num1M3
	mov r6, #0x55
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM3
donechaseUpM3:
	;check if pac man is in up direction
	ldrb r4, [r0, #31]
	cmp r4, #0x3c
	beq superModeDownM3
	ldrb r4, [r0, #62]
	cmp r4, #0x3c
	beq superModeDownM3
	ldrb r4, [r0, #93]
	cmp r4, #0x3c
	beq superModeDownM3
	ldrb r4, [r0, #124]
	cmp r4, #0x3c
	beq superModeDownM3
	mov r1, #0x30	;no pac man found
	B doneChaseorAwayM3
superModeDownM3:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoUpM3Left
	mov r6, #0x55
	ldr r5, ptr_to_num1M3
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM3
approachtoUpM3Left:
	ldr r5, ptr_to_num1M3
	mov r6, #0x44
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
doneChaseorAwayM3:
	LDMFD sp!, {r2-r12,lr}
	mov pc, lr

chaseorAwayM4:
	STMFD sp!, {lr, r2-r12}
;check if pac man is in left
	ldrb r4, [r0, #-1]
	cmp r4, #0x3c
	beq superModeLeftM4
	ldrb r4, [r0, #-2]
	cmp r4, #0x3c
	beq superModeLeftM4
	ldrb r4, [r0, #-3]
	cmp r4, #0x3c
	beq superModeLeftM4
	ldrb r4, [r0, #-4]
	cmp r4, #0x3c
	beq superModeLeftM4
	mov r1, #0x30	;no pac man found
	B donechaseLeftM4
superModeLeftM4:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoLeftM4Left
	mov r6, #0x52
	ldr r5, ptr_to_num1M4
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM4
approachtoLeftM4Left:
	ldr r5, ptr_to_num1M4
	mov r6, #0x4C
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM4
donechaseLeftM4:
;check if pac man is in right
	ldrb r4, [r0, #1]
	cmp r4, #0x3c
	beq superModeRightM4
	ldrb r4, [r0, #2]
	cmp r4, #0x3c
	beq superModeRightM4
	ldrb r4, [r0, #3]
	cmp r4, #0x3c
	beq superModeRightM4
	ldrb r4, [r0, #4]
	cmp r4, #0x3c
	beq superModeRightM4
	mov r1, #0x30	;no pac man found
	B donechaseRightM4
superModeRightM4:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoRightM4Left
	mov r6, #0x4C
	ldr r5, ptr_to_num1M4
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM4
approachtoRightM4Left:
	ldr r5, ptr_to_num1M4
	mov r6, #0x52
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM4
donechaseRightM4:
	;check if pac man is in up direction
	ldrb r4, [r0, #-31]
	cmp r4, #0x3c
	beq superModeUpM4
	ldrb r4, [r0, #-62]
	cmp r4, #0x3c
	beq superModeUpM4
	ldrb r4, [r0, #-93]
	cmp r4, #0x3c
	beq superModeUpM4
	ldrb r4, [r0, #-124]
	cmp r4, #0x3c
	beq superModeUpM4
	mov r1, #0x30	;no pac man found
	B donechaseUpM4
superModeUpM4:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoDownM4Left
	mov r6, #0x44
	ldr r5, ptr_to_num1M4
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM4
approachtoDownM4Left:
	ldr r5, ptr_to_num1M4
	mov r6, #0x55
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
	B doneChaseorAwayM4
donechaseUpM4:
	;check if pac man is in up direction
	ldrb r4, [r0, #31]
	cmp r4, #0x3c
	beq superModeDownM4
	ldrb r4, [r0, #62]
	cmp r4, #0x3c
	beq superModeDownM4
	ldrb r4, [r0, #93]
	cmp r4, #0x3c
	beq superModeDownM4
	ldrb r4, [r0, #124]
	cmp r4, #0x3c
	beq superModeDownM4
	mov r1, #0x30	;no pac man found
	B doneChaseorAwayM4
superModeDownM4:
	ldr r5, ptr_to_numSupermode
	ldrb r6, [r5]
	cmp r6, #0x30
	Beq approachtoUpM4Left
	mov r6, #0x55
	ldr r5, ptr_to_num1M4
	strb r6, [r5]
	mov r1, #0x31	;pac is not in supermode, approach pac man.
	B doneChaseorAwayM4
approachtoUpM4Left:
	ldr r5, ptr_to_num1M4
	mov r6, #0x44
	strb r6, [r5]
	mov r1, #0x31	;pac is in supermode, move to opposite direction
doneChaseorAwayM4:
	LDMFD sp!, {r2-r12,lr}
	mov pc, lr



;restore contents of board 1 and 9
restoreMemory1and9:
	STMFD SP!, {r2-r12,lr}
	mov r5, r0
	mov r6, #0x4F	;store O
	strb r6, [r5, #1]!
	mov r6, #0x2E
	mov r7, #1
loopBoard:
	ldrb r8, [r5, #1]
	cmp r8, #0x7c
	beq wall0
	cmp r7, #23
	bgt doneBoard
	cmp r8, #0x4D
	beq loopBoardPellet
	cmp r8, #0x3c
	beq loopBoardPellet
loopBoardPellet:
	strb r6, [r5, #1]!
	add r7, r7, #1
	B loopBoard
wall0:
	add r5, r5, #1
	B loopBoard
doneBoard:
	mov r6, #0x4F	;store O at the end
	strb r6, [r5, #1]!
	LDMFD sp!, {r2-r12,pc}

restoreMemory2and8:
	STMFD SP!, {r2-r12,lr}
	mov r5, r0
	mov r6, #0x2E
loop2and8:
	add r5, r5, #1
	ldrb r7, [r5]
	cmp r7, #0xA
	beq doneLoop2and8
	cmp r7, #0x20
	bne thenMandPac
stillPellet:
	strb r6, [r5]
	B loop2and8
thenMandPac:
	cmp r7, #0x3c
	beq stillPellet
	cmp r7, #0x4d
	beq stillPellet
	B loop2and8
doneLoop2and8:
	LDMFD sp!, {r2-r12,pc}

;put pellets to all location with space.
restoreMemory3to7:
	STMFD SP!, {r2-r12,lr}
	mov r5, r0
	mov r6, #0x2E
loop3to7:
	ldrb r7, [r5]
	cmp r5, r1
	beq doneLoop3to7
	cmp r7, #0x20
	beq restore3to7
	cmp r7, #0x4d
	beq restore3to7
	cmp r7, #0x3c
	beq restore3to7
	add r5, r5, #1
	B loop3to7
restore3to7:
	strb r6, [r5], #1
	B loop3to7
doneLoop3to7:
	LDMFD sp!, {r2-r12,pc}


;hardwares utilized
ptr_to_pause:	.word pause
;/////////UART handler is here.//////////////
UART0_Handler:
  	STMFD SP!,{r0-r12,lr}
startUART:
	mov r5, #0x0010	;write 1 to bit 4
  	movt r5, #0x0000
  	mov r6, #0xC044	;address of UART RXIM
	movt r6, #0x4000
	ldr r7, [r6]	;load RXIM bit to r7
	ORR r7, r7, r5
	str r7, [r6]	;store back RXIM
	;process interrupt
	BL read_character
	ldr r4, ptr_to_num1
	cmp r0, #0x77		;compare w
	BNE cmpS
	strb r0, [r4]
	B finishUART
cmpS:	cmp r0, #0x73
	BNE cmpA
	strb r0, [r4]
	B finishUART
cmpA:	cmp r0, #0x61
	BNE cmpD
	strb r0, [r4]
	B finishUART
cmpD:	cmp r0, #0x64
	BNE cmpPause
	strb r0, [r4]
	B finishUART
cmpPause:
	cmp r0, #0x70
	BNE finishUART
	ldr r4, ptr_to_pause
	strb r0, [r4]
finishUART:
	LDMFD sp!, {r0-r12,lr}
 	BX lr


;///////////////
timer_init:
	STMFD SP!,{lr}
	;Connect Clock to Timer
  	mov r5, #0x0001
  	movt r5, #0x0000
	mov r6, #0xE604	;address of Timer0
	movt r6, #0x400F
	ldr r7, [r6]	;load Timer0 bit to r7
	ORR r7, r7, r5
	str r7, [r6]	;store back Timer0
	;Disable Timer
	mov r5, #0xFFFE
  	movt r5, #0xFFFF
  	mov r6, #0x000C
  	movt r6, #0x4003
  	ldr r7, [r6]
  	AND r7, r7, r5
  	str r7, [r6]
  	;Setup Timer for 32-Bit Mode
  	mov r6, #0x0000
  	movt r6, #0x4003
  	mov r5, #0xFFF8
  	movt r5, #0xFFFF
  	ldr r7, [r6]
  	AND r7, r7, r5
  	str r7, [r6]
  	;Put Timer into Periodic Mode
  	mov r6, #0x0004
  	movt r6, #0x4003
  	mov r5, #0xFFFC
  	movt r5, #0xFFFF
  	ldr r7, [r6]
  	AND r7, r7, r5
	mov r5, #0x0002
	movt r5, #0x0000
	ORR R7, R7, R5
  	str r7, [r6]
  	;Set Interrupt Interval (Period)
  	mov r6, #0x0028
  	movt r6, #0x4003
	str r0, [r6]		;the decimal number written into address 0x40030028 is 4000000
  	;Set Timer to Interrupt When Top Limit of Timer is Reached
  	mov r6, #0x0018
  	movt r6, #0x4003
  	mov r5, #0x0001
  	movt r5, #0x0000
  	ldr r7, [r6]
	ORR r7, r7, r5
	str r7, [r6]
	;Nested Vector Interrupt Controller (NVIC)
	mov r6, #0xE100
  	movt r6, #0xE000
  	mov r5, #0x0000
  	movt r5, #0x0008
  	ldr r7, [r6]
	ORR r7, r7, r5
	str r7, [r6]
	;Enable Timer
	mov r5, #0x0001
  	movt r5, #0x0000
  	mov r6, #0x000C
  	movt r6, #0x4003
  	ldr r7, [r6]
  	orr r7, r7, r5
  	str r7, [r6]
	LDMFD sp!, {lr}
 	MOV pc, lr


timer1_init:
  	STMFD SP!,{lr}
  	;Connect Clock to Timer
  	mov r5, #0x0002
  	movt r5, #0x0000
	mov r6, #0xE604	;address of Timer0
	movt r6, #0x400F
	ldr r7, [r6]	;load Timer0 bit to r7
	ORR r7, r7, r5
	str r7, [r6]	;store back Timer0
	;Disable Timer
	mov r5, #0xFFFE
  	movt r5, #0xFFFF
  	mov r6, #0x100C
  	movt r6, #0x4003
  	ldr r7, [r6]
  	AND r7, r7, r5
  	str r7, [r6]
  	;Setup Timer for 32-Bit Mode
  	mov r6, #0x1000
  	movt r6, #0x4003
  	mov r5, #0xFFF8
  	movt r5, #0xFFFF
  	ldr r7, [r6]
  	AND r7, r7, r5
  	str r7, [r6]
  	;Put Timer into Periodic Mode
  	mov r6, #0x1004
  	movt r6, #0x4003
  	mov r5, #0xFFFC
  	movt r5, #0xFFFF
  	ldr r7, [r6]
  	AND r7, r7, r5
	mov r5, #0x0002
	movt r5, #0x0000
	ORR R7, R7, R5
  	str r7, [r6]
  	;Set Interrupt Interval (Period)
  	mov r6, #0x1028
  	movt r6, #0x4003
	;mov r5, #0x0000
	;movt r5, #0x00e0
	str r0, [r6]
  	;Set Timer to Interrupt When Top Limit of Timer is Reached
  	mov r6, #0x1018
  	movt r6, #0x4003
  	mov r5, #0x0001
  	movt r5, #0x0000
  	ldr r7, [r6]
	ORR r7, r7, r5
	str r7, [r6]
	;Nested Vector Interrupt Controller (NVIC)
	mov r6, #0xE100
  	movt r6, #0xE000
  	mov r5, #0x0000
  	movt r5, #0x0020
  	ldr r7, [r6]
	ORR r7, r7, r5
	str r7, [r6]
	;Enable Timer
	mov r5, #0x0001
  	movt r5, #0x0000
  	mov r6, #0x100C
  	movt r6, #0x4003
  	ldr r7, [r6]
  	orr r7, r7, r5
  	str r7, [r6]
  	LDMFD sp!, {lr}
 	MOV pc, lr

;////////////////////////////////////////
;Initilize and configure the timer
Interrupt_init:
  	STMFD SP!,{lr}
  	;UART Initialize
	;UARTIM address
	mov r2, #0xc038
	movt r2, #0x4000
	ldrb r8, [r2]
	mov r6, #0x0010
	movt r6, #0x0000
	ORR r8, r8, r6
	str r8, [r2]
	;cmp r8, #0x0010
	;BEQ nvic
	mov r2, #0xE100
	movt r2, #0xE000
	ldr r7, [r2]
	mov r6, #0x0020
	movt r6, #0x0000
	orr r7, r7, r6
	str r7, [r2]
	;Enable interrupt
	mov r2, #0xE100
	movt r2, #0xE000
	ldr r7, [r2]
	mov r6, #0x001f
	movt r6, #0x0000
	orr r7, r6, r7
	str r7, [r2]
  	LDMFD sp!, {lr}
 	MOV pc, lr

 ;/////////////////////////////////////////////////////////////////
illuminate_RGB_LED:
	STMFD SP!,{lr}
    ; Store register lr on stack
    ; Your code is placed here
    mov r2, #0x5000
    movt r2, #0x4002
    ;direction register
    ldr r7, [r2, #0x400]
    mov r6, #0x000f
    movt r6, #0x0000
    orr r7, r7, r6
    str r7, [r2, #0x400]
    ;digital register
    mov r6, #0x000f
    movt  r6, #0x0000
    ldr r7, [r2, #0x51C]
    ORR r7, r7, r6
    str r7, [r2, #0x51C]
    ;data register
	ldr r7, [r2, #0x3FC]
	mov r7, #0
	mov r6, r0
    movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r2, #0x3FC]
    LDMFD sp!, {lr}
    MOV pc, lr


;//////////////////////////////////////////////////////////////
uart_init:
	STMFD SP!,{lr}
;(*((volatile uint32_t *)(0x400FE618))) |= 1;
	MOV r5, #0xE000
	MOVT r5, #0x400F
	LDR r6, [r5, #0x618]
	MOV r7, #0x0001
	MOVT r7, #0x0000
	ORR r6, r6, r7
	STR r6, [r5, #0x618]
;(*((volatile uint32_t *)(0x400FE608))) |= 1;
	LDR r6, [r5, #0x608]
	ORR r6, r6, r7
	STR r6, [r5, #0x608]
;(*((volatile uint32_t *)(0x4000C030))) |= 0;
	MOV r5, #0xC000
	MOVT r5, #0x4000
	LDR r6, [r5, #030]
	MOV r7, #0xFFFE
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	STR r6, [r5, #0x030]
;(*((volatile uint32_t *)(0x4000C024))) |= 8;
	LDR r6, [r5, #0x024]
	MOV r7, #0xFFF0
	MOVT r7, #0xFFFF
	ADD r6, r6, #8
	STR r6, [r5, #0x024]
;(*((volatile uint32_t *)(0x4000C028))) |= 44;
	LDR r6, [r5, #0x028]
	MOV r7, #0xFF00
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #44
	STR r6, [r5, #0x028]
;(*((volatile uint32_t *)(0x4000CFC8))) |= 0;
	LDR r6, [r5, #0xFC8]
	AND r6, r6, r7
	STR r6, [r5, #0xFC8]
;(*((volatile uint32_t *)(0x4000C02C))) |= 0x60;
	LDR r6, [r5, #0x02C]
	MOV r7, #0xFF00
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #0x60
	STR r6, [r5, #0x02C]
;(*((volatile uint32_t *)(0x4000C030))) |= 0x301;
	LDR r6, [r5, #0x030]
	MOV r7, #0xF000
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #0x301
	STR r6, [r5, #0x030]
;(*((volatile uint32_t *)(0x4000451C))) |= 0x03;
	MOV r5, #0x4000
	MOVT r5, #0x4000
	LDR r6, [r5, #0x51C]
	MOV r7, #0xFF00
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #0x03
	STR r6, [r5, #0x51C]
;(*((volatile uint32_t *)(0x40004420))) |= 0x03;
	LDR r6, [r5, #0x420]
	MOV r7, #0xFF00
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #0x03
	STR r6, [r5, #0x420]
;(*((volatile uint32_t *)(0x4000452C))) |= 0x11;
	LDR r6, [r5, #0x52C]
	MOV r7, #0xFF00
	MOVT r7, #0xFFFF
	AND r6, r6, r7
	ADD r6, r6, #0x11
	STR r6, [r5, #0x52C]
	LDMFD sp!, {lr}
	MOV pc, lr
;/////////////////////////////////////////////////////////////


 ;///////////////////////////////////////////////////////////////
read_character:
	STMFD SP!, {lr, r2, r3, r8}
	mov r3, #0xc000
	movt r3, #0x4000
read:	LDRB r8, [r3, #U0LSR]
	AND r2, r8, #0x10
	CMP r2, #0x10
	BEQ read
	ldrb r0, [r3]
	LDMFD sp!, {lr, r2, r3, r8}
	mov pc, lr

;///////////////////////////////////////////////////////
output_character:
	STMFD SP!,{r3, r5, r10}
	mov r3, #0xc000
	movt r3, #0x4000
trans:	LDRB r10, [r3, #U0LSR]
	AND r5, r10, #0x20
	CMP r5, #0x20
	BEQ trans
	strb r0, [r3]
	LDMFD SP!, {r3, r5, r10}
	mov pc, lr

;///////////////////////////////////////////////////////
read_string:
	STMFD SP!,{lr, r4, r9}
	;ldr r12, ptr_to_prompt1
	;ldr r4, ptr_to_num1
	BL read_character
;comareD:
receive:	CMP r0, #0xD
	BEQ readdone
	strb r0, [r4]
	BL output_character
	ADD r4, r4, #1
	B receive
readdone:	MOV r9, #0x0	;user pressed Enter
	strb r9, [r4]
	add r11, r11, #1
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	LDMFD sp!, {lr, r4, r9}
	mov pc, lr

;///////////////////////////////////////////////////////
output_string:
	STMFD SP!,{lr, r4, r7}
transmit:	ldrb r0, [r4]
	ADD r4, r4, #1
	AND r7, r0,  #0x000000FF
	CMP r7, #0x0
	BEQ outdone
	BL output_character
	B transmit
outdone:	LDMFD sp!, {lr, r4, r7}
	mov pc, lr

