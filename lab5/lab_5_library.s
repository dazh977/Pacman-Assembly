
	;.data
	;.global numSwitch
	;data section
	.data
	.global promptInstruction
	.global promptKeyboard
 	.global promptSW2
	.global promptSW3
	.global promptSW4
	.global promptSW5
	.global promptEnd
	.global num1
	.global numq
	.global numUART
	.global numSwitch
	.global numUART1
	.global numUART2
	.global numUART3
	.global numsw5
	.global numsw4
	.global numsw3
	.global numsw2
promptInstruction:	.string "Press any key on keyboard (except q) or any of the 4 switches. Hit q if quit.", 0
promptKeyboard: .string "You pressed keyboard times:  ", 0
promptSW2:	.string "sw2 is pressed:", 0	;switch result prompt
promptSW3:	.string "sw3 is pressed:", 0	;switch result prompt
promptSW4:	.string "sw4 is pressed:", 0	;switch result prompt
promptSW5:	.string "sw5 is pressed:", 0	;switch result prompt
promptEnd:	.string "q is pressed. The program Ends.", 0
numq: .string "0", 0		;stores the character q. When byte loaded from this location matched user input, program ends.
;numq: .string "0", 0		;Store 0 when user did not enter q.
numsw5: .string "000", 0	;stores number of times switch 5 is pressed
numsw4: .string "000", 0	;stores number of times switch 4 is pressed
numsw3: .string "000", 0	;stores number of times switch 3 is pressed
numsw2: .string "000", 0	;stores number of times switch 2 is pressed
numUART: .string "000", 0	;stores number of times key on keyboard is pressed
numSwitch:	.string "0", 0
numUART1: .string "000", 0
numUART2: .string "000", 0
numUART3: .string "000", 0
num1:	.string "q", 0

	.text
 	.global uart_init
 	.global UART0_Handler
 	.global Switches_Handler
 	.global Interrupt_init
 	.global output_character
 	.global read_character
 	.global read_string
 	.global output_string
 	.global read_from_push_btns
	.global div_and_mod
U0LSR:  .equ 0x18			; UART0 Line Status Register
;ptr_to_promptKeyboard:	.word promptKeyboard
;///////////////////////////////////////
;pointers to memory locations
ptr_to_promptInstrcution:	.word promptInstruction
ptr_to_promptKeyboard:	.word promptKeyboard
ptr_to_promptSW2:	.word promptSW2
ptr_to_promptSW3:	.word promptSW3
ptr_to_promptSW4:	.word promptSW4
ptr_to_promptSW5:	.word promptSW5
ptr_to_promptEnd:	.word promptEnd
ptr_to_num1:	.word num1
ptr_to_numq:	.word numq
ptr_to_numsw5:	.word numsw5
ptr_to_numsw4:	.word numsw4
ptr_to_numsw3:	.word numsw3
ptr_to_numsw2:	.word numsw2
ptr_to_numUART: .word numUART
ptr_to_numSwitch:	.word numSwitch
ptr_to_numUART1: .word numUART1
ptr_to_numUART2: .word numUART2
ptr_to_numUART3: .word numUART3
;////////////////////////////////////////
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
	;GPIO Initialize
	mov r2, #0x7000
	movt r2, #0x4000
	ldr r8, [r2, #0x404]
	mov r6, #0xff00
	movt r6, #0xffff
	AND r8, r8, r6
	str r8, [r2, #0x404]
	;interrupt both edges
	ldr r8, [r2, #0x408]
	mov r6, #0xff00
	movt r6, #0xffff
	AND r8, r8, r6
	str r8, [r2, #0x408]
	;Interrupt Event
	ldr r8, [r2, #0x40C]
	mov r6, #0x00ff
	movt r6, #0x0000
	ORR r8, r8, r6
	str r8, [r2, #0x40C]
	;Interrupt Mask
	ldr r8, [r2, #0x410]
	ORR r8, r8, r6
	str r8, [r2, #0x410]
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
;////////////////////////////////////////

read_from_push_btns:
	STMFD SP!,{lr}
	mov r2, #0x7000
    movt r2, #0x4000  ;port D address
      ;direction register PIN0
	ldr r7, [r2, #0x400]
	mov r6, #0xfff0
    MOVT r6, #0xffff
	AND r7, r7, r6
    str r7, [r2, #0x400]
	 ;digital register
    mov r6, #0X000f
    MOVT r6, #0x0000
    ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
	;data register
	LDRB r12, [r2, #0x3fc]
	;read enter
    mov r0, r12
    str r0, [r4]
	;BL illuminate_LEDs
	LDMFD sp!, {lr}
	MOV pc, lr

;/////////////////////////////////////////////////////
UART0_Handler:
  	STMFD SP!,{r0-r12,lr}
  	;clear interrupt
startUART:
	mov r5, #0x0010	;write 1 to bit 4
  	movt r5, #0x0000
  	mov r6, #0xC044	;address of UART RXIM
	movt r6, #0x4000
	ldr r7, [r6]	;load RXIM bit to r7
	ORR r7, r7, r5
	str r7, [r6]	;store back RXIM
	;Update number on Putty
	ldr r4, ptr_to_num1	;Address storing q
	ldrb r8, [r4]
	BL read_character
	CMP r8, r0	;compare q
	BNE convert	;If not matched, process number on Putty.
	mov r8, #0x71
	ldr r4, ptr_to_numq
	strb r8, [r4]
	B finishUART
convert:	ldr r4, ptr_to_promptKeyboard	;print result sentence
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	mov r0, #0x0
	ldr r4, ptr_to_numUART	;Number of times key pressed
	ldrb r9, [r4]
	add r9, r9, #1	;update the number
	strb r9, [r4]
	cmp r9, #0x0039	;If the number is greater than 9, go to label newcount.
	BGT newcount
	B back
back:
	mov r0, r9
	BL output_character
now:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	B finishUART
newcount:
	mov r8, r9
	mov r7, #10
newcount1:
	cmp r8, #0x003A
	BEQ final0
	add r7, r7, #1
	; get the decimal
	SUB r8, r8, #1
	B newcount1
final0:	mov r11, r7
	mov r12, #0
into0:	mov r0, r11
	mov r1, #10
	BL div_and_mod
	mov r11, r0
	mov r2, r1
	add r2, r2, #0x30
	LSL r12, r12, #8
	add r12, r2, r12
	;transfer to string
	CMP r0, #0
	BEQ output
	B into0
output:
	ldr r4, ptr_to_numUART1
	str r12, [r4]
	ldrb r0, [r4]
	BL output_string
	B now
finishUART:
	;restore register
	LDMFD sp!, {r0-r12,lr}
 	BX lr

;///////////////////////////////////////////////////////////////
Switches_Handler:
	STMFD SP!,{lr, r0-r12}
	mov r10, #0
	mov r11, #5000
	add r11, r11, #4000
loop2:
	add r10, r10, #1
	CMP r10, r11
	BEQ clear
	B loop2
clear:	mov r10, #0
loop3:
	add r10, r10, #1
	CMP r10, r11
	BEQ clear2
	B loop3
clear2:	mov r10, #0
	;clear interrupt
	mov r2, #0x7000
	movt r2, #0x4000
	ldr r8, [r2, #0x41C]
	mov r6, #0x00ff
	movt r6, #0x0000
	ORR r8, r8, r6
	str r8, [r2, #0x41C]
	;handle read_push_button
    LDRB r12, [r2, #0x3fc]	;read from data register of Port D
	CMP r12, #0x1
	BEQ SW5
	CMP r12, #0x2
	BEQ SW4
	CMP r12, #0x4
	BEQ SW3
	CMP r12, #0x8
	BEQ SW2
	B back2
SW5:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r5, ptr_to_numsw5
	ldrb r9, [r5]
	ldr r4, ptr_to_promptSW5
	B printResult
SW4:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r5, ptr_to_numsw4
	ldrb r9, [r5]
	ldr r4, ptr_to_promptSW4
	B printResult
SW3:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r5, ptr_to_numsw3
	ldrb r9, [r5]
	ldr r4, ptr_to_promptSW3
	B printResult
SW2:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r5, ptr_to_numsw2
	ldrb r9, [r5]
	ldr r4, ptr_to_promptSW2
	B printResult
	B now1
printResult:
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	mov r0, #0x0
	add r9, r9, #1
	strb r9, [r5]
	cmp r9, #0x0039
	;>9, go newcount switch
	BGT newcountSwitch
	B back2
back2:
	mov r0, r9
	BL output_character
	B now1
newcountSwitch:
	mov r8, r9
	mov r7, #10
newcount1Switch:
	cmp r8, #0x003A
	BEQ final0Switch
	add r7, r7, #1
	SUB r8, r8, #1
	;get decimal
	B newcount1Switch
final0Switch:	mov r11, r7
	mov r12, #0
into0Switch:	mov r0, r11
	mov r1, #10
	BL div_and_mod
	mov r11, r0
	mov r2, r1
	add r2, r2, #0x30
	LSL r12, r12, #8
	add r12, r2, r12
	CMP r0, #0
	; transfer to string
	BEQ outputSwitch
	B into0Switch
outputSwitch:
	ldr r4, ptr_to_numUART3
	str r12, [r4]
	ldrb r0, [r4]
	BL output_string
	B now1
now1:
	mov r2, #0x7000
    movt r2, #0x4000  ;port D address
	mov r6, #0X000f
    MOVT r6, #0x0000
    ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
	LDMFD sp!, {lr, r0-r12}
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
