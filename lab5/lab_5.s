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

;text section
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
 	.global lab5
	.global div_and_mod
U0LSR:  .equ 0x18			; UART0 Line Status Register

;pointers to memory locations
ptr_to_promptInstruction:	.word promptInstruction
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

lab5:
	STMFD SP!,{lr}
	BL uart_init	;Initial UART0
	;Enable GPIO clock
	mov r3, #0xE000
	movt r3, #0x400F
    ldr r7, [r3, #0x608]
	mov r6, #0x003f
	movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r3, #0x608]
	;Initialize Interrupt
	BL Interrupt_init
	;enable Port D to read push button
	mov r2, #0x7000
    movt r2, #0x4000  ;port D address
    ;direction register PIN0 of Port D
	ldr r7, [r2, #0x400]
	mov r6, #0xfff0
    MOVT r6, #0xffff
	AND r7, r7, r6
    str r7, [r2, #0x400]
	;digital register of Port D
    mov r6, #0X000f
    MOVT r6, #0x0000
    ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
	;Instruction
	ldr r4, ptr_to_promptInstruction
	ldrb r0, [r4]
	BL output_string
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character


;This is infinifte loop that does nothing but waits for an interrupt.
;Once a key except q or one of the four switches is pressed, the program automatically goes to handlers.
loop:	add r0, r0, #0
	ldr r4, ptr_to_numq	;Address storing q
	ldrb r8, [r4]
	CMP r8, #0x71	;compare q
	BEQ end	;If matched, quit.
	B loop

end:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r4, ptr_to_promptEnd
	ldrb r0, [r4]
	BL output_string

;/////////////////////////////////////////////////////////////
	LDMFD SP!,{lr}
	mov pc, lr
.end
