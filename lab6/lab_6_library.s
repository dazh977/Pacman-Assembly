	.data
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
	.global promptboard10
	.global promptboard11
	.global promptboard12
	.global promptboard13
	.global promptboard14
	.global promptboard15
	.global promptEndGame
	.global numi
	.global numj
	.global numk
	.global numm
	.global newAddress
;////////////////////////////////////////////////
	.global num1
	.global numq

numi: .string "i", 0	;memory location that stores i direction
numj: .string "j", 0	;memory location that stores j direction
numk: .string "k", 0	;memory location that stores i direction
numm: .string "m", 0	;memory location that stores i direction
;memory that stores current position. It is used to calculate the next poistion to put *.
newAddress:	.string "00000000", 0

;Board configurations
promptScore:	.string "               Score:  000				", 0
promptUpper:	.string "---------------------------------------", 0
promptLower:	.string "---------------------------------------", 0
promptboard:	.string "|                                      }", 0
promptboard2:	.string "|                                      }", 0
promptboard3:	.string "|                                      }", 0
promptboard4:	.string "|                                      }", 0
promptboard5:	.string "|                                      }", 0
promptboard6:	.string "|                                      }", 0
promptboard7:	.string "|                   *                  }", 0
promptboard8:	.string "|                                      }", 0
promptboard9:	.string "|                                      }", 0
promptboard10:	.string "|                                      }", 0
promptboard11:	.string "|                                      }", 0
promptboard12:	.string "|                                      }", 0
promptboard13:	.string "|                                      }", 0
promptboard14:	.string "|                                      }", 0
promptboard15:	.string "|                                      }", 0
promptEndGame:	.string "The snake hits itself or walls! Game ends.", 0
num1:	.string "0", 0		;num1 stores the current direction. If user hit i, num1 always stores i until user hit 1 of another 3 keys.
numq: .string "0", 0		;stores the character q. When byte loaded from this location matched user input, program ends.
	.align 4
	.text
	.global lab6
	.global UART0_Handler
	.global Timer0_Handler
	.global uart_init
 	.global Interrupt_init
 	.global timer_init
 	.global output_character
 	.global read_character
 	.global read_string
 	.global output_string
 	.global lab6
	.global div_and_mod
U0LSR:  .equ 0x18

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
ptr_to_promptboard10:	.word promptboard10
ptr_to_promptboard11:	.word promptboard11
ptr_to_promptboard12:	.word promptboard12
ptr_to_promptboard13:	.word promptboard13
ptr_to_promptboard14:	.word promptboard14
ptr_to_promptboard15:	.word promptboard15
ptr_to_promptEndGame:	.word promptEndGame
ptr_to_numi:	.word numi
ptr_to_numj:	.word numj
ptr_to_numk:	.word numk
ptr_to_numm:	.word numm
ptr_to_newAddress:	.word newAddress
;//////////////////////////////////////////
ptr_to_num1:	.word num1
ptr_to_numq:	.word numq

;////////////////////////////////////////
;Initilize and configure the timer
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
	ldr r5, [r6]
	MOV r5, #0
	mov r5, #0x0900
	movt r5, #0x003D	;the decimal number written into address 0x40030028 is 4000000
	str r5, [r6]
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
  	;address of starting position
  	;The starting position is the position of the first *.
  	ldr r4, ptr_to_promptboard7
	add r4, r4, #20		;add #0x20 to find position of *
	ldr r5, ptr_to_newAddress
	str r4, [r5]
  	LDMFD sp!, {lr}
 	MOV pc, lr

;Initialize and enable interrupts
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
	;change the line
	ldr r4, ptr_to_num1		;r4 contains address of num1
	ldrb r0, [r4]			;r0 contains contents of num1, which is i or j or k or m
	ldr r4, ptr_to_numi
	ldrb r8, [r4]			;load r8 with contents of numi
	CMP r8, r0				;compare with r0
	BEQ goi					;Go to goi if equal.
	ldr r4, ptr_to_numj
	ldrb r8, [r4]			;load r8 with contents of numj
	CMP r8, r0				;compare with r0
	BEQ goj					;Go to goj if equal.
	ldr r4, ptr_to_numk
	ldrb r8, [r4]			;load r8 with contents of numk
	CMP r8, r0				;compare with r0
	BEQ gok					;Go to gok if equal.
	ldr r4, ptr_to_numm
	ldrb r8, [r4]			;load r8 with contents of numm
	CMP r8, r0				;compare with r0
	BEQ gom					;Go to gom if equal.
;If user hits keys other than i, j, k, m, ignore the input.
;Or if game yet started, just print the score and board without updating score.
	B printScore

goi:
	ldr r4, ptr_to_num1				;r4 has address of num1
	strb r0, [r4]					;update num1 with contents of r0
	ldr r4, ptr_to_newAddress		;r4 has address of newAddress
	ldr r7, [r4]					;load r7 with contents of newAddress, which is also an address
	SUB r7, r7, #0x0029				;subtract 0x29 from address in r7, so the * is placed below
	ldrb r5, [r7]					;load contents of r7 to r5
	cmp r5, #0x20					;check to see if the position is a space
	BNE FinishTimerandQuit			;if not, game will end.
	cmp r5, #0x2D
	BEQ FinishTimerandQuit
	mov r5, #0x2A					;one more * is needed in the path
	strb r5, [r7]					;place * in the address specified in r7
	str r7, [r4]					;store the address where * is placed into r4
	B finishTimerCompare
goj:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddress
	ldr r7, [r4]
	sub r7, r7, #1
	ldrb r5, [r7]
	cmp r5, #0x20
	BNE FinishTimerandQuit
	cmp r5, #0x7C
	BEQ FinishTimerandQuit
	mov r5, #0x2A
	strb r5, [r7]
	str r7, [r4]
	B finishTimerCompare
gok:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddress
	ldr r7, [r4]
	add r7, r7, #1
	ldrb r5, [r7]
	cmp r5, #0x20
	BNE FinishTimerandQuit
	cmp r5, #0x7D
	BEQ FinishTimerandQuit
	mov r5, #0x2A
	strb r5, [r7]
	str r7, [r4]
	B finishTimerCompare
gom:
	ldr r4, ptr_to_num1
	strb r0, [r4]
	ldr r4, ptr_to_newAddress
	ldr r7, [r4]
	add r7, r7, #0x0029
	ldrb r5, [r7]
	cmp r5, #0x20
	BNE FinishTimerandQuit
	cmp r5, #0x2D
	BEQ FinishTimerandQuit
	mov r5, #0x2A
	strb r5, [r7]
	str r7, [r4]
	B finishTimerCompare
finishTimerCompare:
	;Score is counted here.
	;Before start, no score is counted.
	ldr r4, ptr_to_promptScore
	ldrb r0, [r4, #25]		;least significant digit
	cmp r0, #0x39
	BEQ tens
	add r0, r0, #1			;add 1
	strb r0, [r4, #25]		;store back to memory
	B printScore
tens:	mov r0, #0X30		;make least significant digit 0 for 10
	strb r0, [r4, #25]
	ldrb r1, [r4, #24]		;second least significant digit
	cmp r1, #0x39
	BEQ hundreds
	add r1, r1, #1			;add 1
	strb r1, [r4, #24]
	B printScore
hundreds:	mov r1, #0X30	;make second least significant digit 0 for 10
	strb r0, [r4, #24]
	ldrb r2, [r4, #23]
	cmp r3, #0x39
	BEQ FinishTimerandQuit
	add r2, r2, #1			;add 1
	strb r2, [r4, #23]
	B printScore

printScore:	ldr r4, ptr_to_promptScore
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r4, ptr_to_promptUpper
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
;print board
backFromTimer:
	ldr r4, ptr_to_promptboard
	mov r12, #0
print:
	CMP r12, #14
	BEQ donePrint
	ldrb r0, [r4], #0x0029
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	add r12, r12, #1
	B print
donePrint:	ldr r4, ptr_to_promptLower
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	B FinishTimer
FinishTimerandQuit:
	ldr r4, ptr_to_numq
	mov r5, #0x71
	strb r5, [r4]
FinishTimer:
  	LDMFD sp!, {r0-r12,lr}
	BX lr
;/////////////////////////////////////////////////////

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
;checks if the user input is one of i, j, k, m. If not, do not store it in memory.
	cmp r0, #0x69
	BNE cmpJ
	strb r0, [r4]
cmpJ:	cmp r0, #0x6A
	BNE cmpK
	strb r0, [r4]
cmpK:	cmp r0, #0x6B
	BNE cmpM
	strb r0, [r4]
cmpM:	cmp r0, #0x6D
	BNE finishUART
	strb r0, [r4]
	B finishUART
finishUART:
	LDMFD sp!, {r0-r12,lr}
 	BX lr


 ;///////////////////////////////////////////////////////////////
read_character:
	STMFD SP!,{r2, r3, r8}
	mov r3, #0xc000
	movt r3, #0x4000
read:	LDRB r8, [r3, #U0LSR]
	AND r2, r8, #0x10
	CMP r2, #0x10
	BEQ read
	ldrb r0, [r3]
	LDMFD sp!, {r2, r3, r8}
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

;/////////////////////////////////////////////////////////////
div_and_mod:
	STMFD r13!, {r2-r12, r14}
	; Your code for the signed division/mod routine goes here.
	; The dividend is passed in r0 and the divisor in r1.
	; The quotient is returned in r0 and the remainder in r1.
	MOV r3, #16	;counter=16
	MOV r4, #0	;Quotient=0
	;MOV r0, #-38	already did it in main
	;MOV r1, #3	already did it in main
	AND r7, r0, #0x80000000	;mask to see the sign bit of dividend
	AND r8, r1, #0x80000000	;mask to see the sign bit of divisor
	EOR r9, r7, r8	;r9 stores sign of quotient
	MOV r5, #0	;for r0, r1 negation
	CMP r0, #0	;compare dividend with 0
	BGE next	;if dividend>0, jump directly to compare divisor
	SUB r0, r5, r0	;neagte r0
next:	CMP r1, #0	;if dividisor>0, no negation and start calculation
	BGE stat	;Dividend and divisor are positive, jump to start of calculation
	SUB r1, r5, r1	;negate r1
stat:	MOV r8, #16
	LSL r1, r1, r8		;Logical left shift divisor 16 bits
	MOV r2, r0	;initilize remainder to dividend
again:	SUB r2, r2, r1	;Remainder=remainder-divisor
	CMP r2, #0x0
	BLT restore			;remainder less than 0 then restore subtracted remiander
	LSL r4, r4, #1		;left shift Quotient
	ORR r4, r4, #1		;make LSB=1 regardless of the rest bits
rsd:	LSR r1, r1, #1	;Right shift divisor (rsd)
	;AND r1, r1, #0xFFFFEFFF	;right shift divisor
	CMP r3, #0			;MSB=0
	BLE	done
	SUB r3, r3, #1		;Decrement counter
	B again
restore:	ADD r2, r2, r1
	LSL r4, r4, #1		;Left shift quotient
	;AND r4, r4, #0xFFFFFFFE	;LSB=0
	B rsd
done:	CMP r9, #0	;determine sign of quotient
	BEQ passv		;if r9=0, pass quotient to r0 without negation
	SUB r4, r5, r4	;r9=1, divisor and dividend have different signs, negate quotient
passv:	MOV r0, r4	;Quotient to r0
	MOV r1, r2		;remainder to r1
	LDMFD r13!, {r2-r12, r14}
	MOV pc, lr
;/////////////////////////////////////////////////////////////



.end






