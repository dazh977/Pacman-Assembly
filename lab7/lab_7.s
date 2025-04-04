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
	.global okToMoveMs
	.global numPelletEat
	.global flagPrint
	.global flagPellet
	.global flagMoveM
	.global flagMoveM2
	.global flagMoveM3
	.global flagMoveM4
	.global numquit
	.global promptExitGame
	.global numSupermode
	.global gamestartaddress
	.global lifetime
	.global trackMPath	;used to remember what M encoutered, and put it back when M passed
	.global trackMBehind
	.global trackM2Path
	.global trackM2Behind
	.global trackM3Path
	.global trackM3Behind
	.global trackM4Path
	.global trackM4Behind
	.global speedSwap
	.global pause
	.global pauseMenu
	.global levelSpeed	;newly added
	.global timer0Control	;newly added
	.global timer1Control	;newly added

	.text
	.global lab7
	.global Interrupt_init
 	.global timer_init
 	.global timer1_init
	.global uart_init
	.global UART0_Handler
	.global Timer0_Handler
	.global Timer1_Handler
	.global randomGhostMove
	.global controlPacMan
	.global checkTheJunctions
	.global illuminate_RGB_LED
 	.global output_character
 	.global read_character
 	.global read_string
 	.global output_string
	.global restoreMemory1and9
 	.global restoreMemory2and8
 	.global restoreMemory3to7

U0LSR:  .equ 0x18

ptr_to_instruction:		.word instruction
ptr_to_instruction2:	.word instruction2
ptr_to_instructionPac:	.word instructionPac
ptr_to_instructionGhost:	.word instructionGhost
ptr_to_instructionRule:	.word instructionRule
ptr_to_instructionRule2:	.word instructionRule2
ptr_to_promptScore:		.word promptScore
ptr_to_promptUpper:		.word promptUpper
ptr_to_promptLower:		.word promptLower
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
ptr_to_num1M1:	.word num1M1
ptr_to_num1M2:	.word num1M2
ptr_to_num1M3:	.word num1M3
ptr_to_num1M4:	.word num1M4
ptr_to_numw:	.word numw
ptr_to_nums:	.word nums
ptr_to_numa:	.word numa
ptr_to_numd:	.word numd
ptr_to_num1:	.word num1
ptr_to_okToMoveMs:	.word okToMoveMs
ptr_to_numPelletEat:	.word numPelletEat
ptr_to_flagPrint:	.word flagPrint
ptr_to_flagPellet:	.word flagPellet
ptr_to_flagMoveM:	.word flagMoveM
ptr_to_flagMoveM2:	.word flagMoveM2
ptr_to_flagMoveM3:	.word flagMoveM3
ptr_to_flagMoveM4:	.word flagMoveM4
ptr_to_numquit:	.word numquit
ptr_to_numSupermode: .word numSupermode
ptr_to_promptExitGame:	.word promptExitGame
ptr_to_lifetime:	.word lifetime
ptr_to_gamestartaddress:	.word gamestartaddress
ptr_to_trackMPath:	.word trackMPath
ptr_to_trackMBehind:	.word trackMBehind
ptr_to_trackM2Path:	.word trackM2Path
ptr_to_trackM2Behind:	.word trackM2Behind
ptr_to_trackM3Path:	.word trackM3Path
ptr_to_trackM3Behind:	.word trackM3Behind
ptr_to_trackM4Path:	.word trackM4Path
ptr_to_trackM4Behind:	.word trackM4Behind
ptr_to_speedSwap:	.word speedSwap
ptr_to_pause:	.word pause
ptr_to_pauseMenu:	.word pauseMenu
ptr_to_levelSpeed:	.word levelSpeed
ptr_to_timer0Control:	.word timer0Control
ptr_to_timer1Control:	.word timer1Control

lab7:
	STMFD SP!,{lr}
	;clock
	mov r3, #0xE000
	movt r3, #0x400F
    ldr r7, [r3, #0x608]
	mov r6, #0x003f
	movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r3, #0x608]
	ldr r4, ptr_to_timer0Control
	mov r5, #0x1200
	movt r5, #0x007a
	str r5, [r4]
	ldr r4, ptr_to_timer1Control
	mov r5, #0x6156
	movt r5, #0x0051
	str r5, [r4]
;initilize UART
	BL uart_init
	ldr r4, ptr_to_instructionPac
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r4, ptr_to_instruction
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r4, ptr_to_instruction2
	BL output_string
;get instruction from user
userInstruction:
	BL read_character
	cmp r0, #0x30
	ble userInstruction
	cmp r0, #0x31
	beq prepareLoop
	cmp r0, #0x32
	bgt userInstruction
	ldr r4, ptr_to_numquit
	mov r5, #0x71
	strb r5, [r4]
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	B checkForQuit
prepareLoop:
	mov r12, #0
	mov r0, #0
clear:
	BL Interrupt_init
	ldr r0, ptr_to_levelSpeed
	ldrb r12, [r0]
	cmp r12, #0x31
	bne normalSpeed
	ldr r12, ptr_to_timer0Control
	ldr r3, [r12]
	lsr r4, r3, #2
	sub r3, r3, r4
	str r3, [r12]
	B passTimer0
normalSpeed:
	;pass number to counter of timer0
	ldr r12, ptr_to_timer0Control
	ldr r3, [r12]
passTimer0:
	mov r0, r3
	BL timer_init
	;address of starting position
  	;The starting position is the position of the first *.
  	ldr r4, ptr_to_promptboard7
	add r4, r4, #14		;add #14 to find position of *
	ldr r5, ptr_to_newAddressLab7
	str r4, [r5]
;pass number to counter of timer1
	ldr r0, ptr_to_levelSpeed
	ldrb r12, [r0]
	cmp r12, #0x31
	bne normalSpeedTimer1
	ldr r12, ptr_to_timer1Control
	ldr r3, [r12]
	lsr r4, r3, #2	;divid by 4
	sub r3, r3, r4	;add 1/4 to value before
	str r3, [r12]
	B passTimer1
normalSpeedTimer1:
	ldr r12, ptr_to_timer1Control
	ldr r3, [r12]
passTimer1:
	mov r0, r3
	BL timer1_init
	ldr r4, ptr_to_promptboard5
	add r4, r4, #13		;add #13 to find position of M
	ldr r5, ptr_to_newAddressLab7M	;record it in newAddressLab7M
	str r4, [r5]
	ldr r4, ptr_to_promptboard5
	add r4, r4, #12		;add #12 to find position of M2
	ldr r5, ptr_to_newAddressLab7M2	;record it in newAddressLab7M2
	str r4, [r5]
	ldr r4, ptr_to_promptboard5
	add r4, r4, #15		;add #15 to find position of M3
	ldr r5, ptr_to_newAddressLab7M3	;record it in newAddressLab7M3
	str r4, [r5]
	ldr r4, ptr_to_promptboard5
	add r4, r4, #16		;add #16 to find position of M4
	ldr r5, ptr_to_newAddressLab7M4	;record it in newAddressLab7M4
	str r4, [r5]

	ldr r4, ptr_to_levelSpeed
	mov r5, #0x30
	strb r5, [r4]
	mov r12, #0
	mov r0, #0

;main function starts.
loop:	add r0, r0, #0
;flag to determine if printing board needed
	ldr r4, ptr_to_flagPrint
	ldrb r5, [r4]
	cmp r5, #0x30
	BEQ checkForQuit
	BL controlPacMan
	mov r0, #0xC
	BL output_character
;check pause
	ldr r4, ptr_to_pause
	ldrb r5, [r4]
	cmp r5, #0x70
	beq gamePaused

;determine if swapping speed
speedAdjust:
	ldr r4, ptr_to_numSupermode
	ldrb r3, [r4]
	cmp r3, #0x3f
	Beq swapSpeed
countNumPellet0:
	ldr r4, ptr_to_speedSwap
	ldrb r3, [r4]
	cmp r3, #0x32
	beq swapBack


;flag to calculate number of pellets eaten
countNumPellet:
	ldr r4, ptr_to_flagPellet
	ldrb r12, [r4]
	sub r12, r12, #0x30
	cmp r12, #115			;There are 115 pellets in the board.
	bge reprintBoardSpeedFirst
nextisM:
;flag to determine Ms' movements
	ldr r4, ptr_to_okToMoveMs
	ldrb r11, [r4]
	cmp r11, #0x31
	beq ghostMove
	B printScore
ghostMove:
	BL randomGhostMove
;/////////start printing\\\\\\\\\\\\\\\;
printScore:
	;ldr r4, ptr_to_numSupermode
	;ldrb r0, [r4]
	;BL output_string
	;mov r0, #0xA
	;BL output_character
	;mov r0, #0xD
	;BL output_character
	ldr r4, ptr_to_promptScore
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
;/////////finish printing\\\\\\\\\\\\\\\;
	ldr r4, ptr_to_flagPrint
	mov r2, #0x30
	strb r2, [r4]
	B checkForQuit
;check for quit
checkForQuit:	ldr r4, ptr_to_numquit
	ldrb r5, [r4]
	cmp r5, #0x71
	BEQ quitWholeGame
	B loop

;If power pellets are eaten, speed will be swapped.
swapSpeed:
	mov r6, #0x1028		;timer for M
  	movt r6, #0x4003
	mov r3, #0x1300
	movt r3, #0x007A
	str r3, [r6]
	mov r3, #0x6056		;pass number to counter of timer0, decimal number is 8000000
	movt r3, #0x0051
	mov r6, #0x0028		;;timer for pac-man
	movt r6, #0x4003
	str r3, [r6]
	B countNumPellet0
swapBack:
	mov r6, #0x1028
  	movt r6, #0x4003
	mov r3, #0x6156
	movt r3, #0x0051	;the decimal number written into address 0x40031028 is 5333334
	str r3, [r6]
	mov r6, #0x0028
  	movt r6, #0x4003
	mov r3, #0x1200		;pass number to counter of timer0, decimal number is 8000000
	movt r3, #0x007A
	str r3, [r6]
	ldr r4, ptr_to_speedSwap
	mov r3, #0x30
	strb r3, [r4]
	B countNumPellet


;codes handling pauses
gamePaused:
	ldr r2, ptr_to_promptboard5
	mov r1, #0x50	;P
	ldrb r8, [r2, #0xC]!	;remeber first overwrriten position
	strb r1, [r2]
	mov r1, #0x41	;A
	ldrb r9, [r2, #1]!		;remeber second overwrriten position
	strb r1, [r2]
	mov r1, #0x55	;U
	strb r1, [r2, #1]!
	mov r1, #0x53	;S
	ldrb r10, [r2, #1]!
	strb r1, [r2]
	mov r1, #0x45	;E
	ldrb r11, [r2, #1]!
	strb r1, [r2]
	mov r1, #0x44
	strb r1, [r2, #1]
;print out paused board
	ldr r4, ptr_to_promptScore
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
;menu shows
	ldr r4, ptr_to_pauseMenu
	ldrb r0, [r4]
	BL output_string
keepPause:
	BL read_character
	cmp r0, #0x79
	beq	printFromPause
	cmp r0, #0x72
	beq prepareReprintBoard
	cmp r0, #0x6e
	beq quitFromPause
	B keepPause
prepareReprintBoard:
	ldr r4, ptr_to_pause
	mov r0, #0x30
	strb r0, [r4]
	B reprintBoard
	B keepPause
printFromPause:
	ldr r4, ptr_to_promptboard5
	strb r8, [r4, #0xC]!
	strb r9, [r4, #1]!
	mov r9, #0x20
	strb r9, [r4, #1]!
	strb r10, [r4, #1]!
	strb r11, [r4, #1]!
	mov r11, #0x20
	strb r11, [r4, #1]
	ldr r4, ptr_to_pause
	mov r0, #0x30
	strb r0, [r4]
	mov r8, #0
	mov r9, #0
	mov r10, #0
	mov r11, #0
	mov r0, #0xc
	BL output_character
	B speedAdjust
quitFromPause:
	B quitWholeGame

reprintBoardSpeedFirst:
	ldr r0, ptr_to_levelSpeed
	mov r1, #0x31
	strb r1, [r0]
reprintBoard:
	ldr r0, ptr_to_promptboard
	BL restoreMemory1and9
	ldr r0, ptr_to_promptboard9
	BL restoreMemory1and9
	ldr r0, ptr_to_promptboard2
	BL restoreMemory2and8
	ldr r0, ptr_to_promptboard8
	BL restoreMemory2and8
	ldr r0, ptr_to_promptboard3
	ldr r1, ptr_to_promptboard7
	add r1, r1, #28
	BL restoreMemory3to7
	ldr r0, ptr_to_promptboard3
	add r0, r0, #3
	mov r1, #0x20
	strb r1, [r0], #1
	strb r1, [r0], #20
	strb r1, [r0], #1
	strb r1, [r0]
	ldr r0, ptr_to_promptboard4
	strb r1, [r0, #14]
	ldr r0, ptr_to_promptboard5
	strb r1, [r0], #8
	strb r1, [r0], #1
	strb r1, [r0], #1
	strb r1, [r0], #1
	strb r1, [r0], #1
	mov r1, #0x4D
	strb r1, [r0], #1
	strb r1, [r0], #1
	mov r1, #0x20
	strb r1, [r0], #1
	mov r1, #0x4D
	strb r1, [r0], #1
	strb r1, [r0], #1
	mov r1, #0x20
	strb r1, [r0], #1
	strb r1, [r0], #1
	strb r1, [r0], #1
	strb r1, [r0], #1
	ldr r0, ptr_to_promptboard5
	add r0, r0, #28
	strb r1, [r0]
	ldr r0, ptr_to_promptboard7
	add r0, r0, #3
	mov r1, #0x20
	strb r1, [r0], #1
	strb r1, [r0], #20
	strb r1, [r0], #1
	strb r1, [r0]
	ldr r0, ptr_to_promptboard7
	add r0, r0, #14
	mov r1, #0x3c
	strb r1, [r0]
	mov r12, #0
;reset flags
	mov r1, #0x30
	ldr r0, ptr_to_newAddressLab7
	str r1, [r0]
	ldr r0, ptr_to_newAddressLab7M
	str r1, [r0]
	ldr r0, ptr_to_newAddressLab7M2
	str r1, [r0]
	ldr r0, ptr_to_newAddressLab7M3
	str r1, [r0]
	ldr r0, ptr_to_newAddressLab7M4
	str r1, [r0]
	ldr r0, ptr_to_num1
	strb r1, [r0]
	ldr r0, ptr_to_num1M1
	strb r1, [r0]
	ldr r0, ptr_to_num1M2
	strb r1, [r0]
	ldr r0, ptr_to_num1M3
	strb r1, [r0]
	ldr r0, ptr_to_num1M4
	strb r1, [r0]
	ldr r0, ptr_to_okToMoveMs
	strb r1, [r0]
	ldr r0, ptr_to_flagPrint
	strb r1, [r0]
	ldr r0, ptr_to_flagPellet
	strb r1, [r0]
	ldr r0, ptr_to_flagMoveM
	strb r1, [r0]
	ldr r0, ptr_to_flagMoveM2
	strb r1, [r0]
	ldr r0, ptr_to_flagMoveM3
	strb r1, [r0]
	ldr r0, ptr_to_flagMoveM4
	strb r1, [r0]
	ldr r0, ptr_to_numquit
	strb r1, [r0]
	mov r2, #0x30
	ldr r0, ptr_to_numSupermode
	strb r2, [r0]
	ldr r0, ptr_to_lifetime
	strb r1, [r0]
	ldr r0, ptr_to_gamestartaddress
	str r1, [r0]
	mov r1, #0x2e
	ldr r0, ptr_to_trackMPath
	strb r1, [r0]
	ldr r0, ptr_to_trackMBehind
	strb r1, [r0]
	ldr r0, ptr_to_trackM2Path
	strb r1, [r0]
	ldr r0, ptr_to_trackM2Behind
	strb r1, [r0]
	ldr r0, ptr_to_trackM3Path
	strb r1, [r0]
	ldr r0, ptr_to_trackM3Behind
	strb r1, [r0]
	ldr r0, ptr_to_trackM4Path
	strb r1, [r0]
	ldr r0, ptr_to_trackM4Behind
	strb r1, [r0]
	ldr r0, ptr_to_numPelletEat
	mov r1, #0x30
	str r1, [r0]
	mov r12, #0
	mov r0, #0
	mov r1, #0
	B prepareLoop


quitWholeGame:
;first put GAME OVER in the central box.
	ldr r0, ptr_to_promptboard5
	mov r1, #0x47	;G
	strb r1, [r0, #0xA]!
	mov r1, #0x41	;A
	strb r1, [r0, #1]!
	mov r1, #0x4D	;M
	strb r1, [r0, #1]!
	mov r1, #0x45	;E
	strb r1, [r0, #1]!
	mov r1, #0x20	;space
	strb r1, [r0, #1]!
	mov r1, #0x4F	;O
	strb r1, [r0, #1]!
	mov r1, #0x56	;V
	strb r1, [r0, #1]!
	mov r1, #0x45	;E
	strb r1, [r0, #1]!
	mov r1, #0x52	;R
	strb r1, [r0, #1]
	;strb r1, [r2]
	mov r0, #0xc
;print out the board
	BL output_character
	ldr r4, ptr_to_promptScore
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
;prompt end of game.
	ldr r4, ptr_to_promptExitGame
	ldrb r0, [r4]
	BL output_string
;turn off LED
	mov r0, #0x0
	BL illuminate_RGB_LED
	add r0, r0, #0
	LDMFD SP!,{lr}
	mov pc, lr

	.end


;cmp r5, #0x2D
	;BEQ FinishTimerandQuit
	;mov r5, #0x2A					;one more * is needed in the path
	;strb r5, [r7]					;place * in the address specified in r7
	;str r7, [r4]					;store the address where * is placed into r4
	;B finishTimerCompare
