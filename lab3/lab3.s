

 	.data
 	.global prompt1
 	.global prompt2
 	.global num1
 	.global	num2
 	.global	expression1
 	.global expression2
 	.global expression3
 	.global difference
prompt1: .string "Enter first integer: ", 0
num1: .string "abc", 0
prompt2: .string "Enter second integer: ", 0
num2: .string "cba", 0
difference:	.string "abc", 0
expression1: .string "First number is larger.",0
expression2: .string "Second number is larger.",0
expression3: .string "The difference is ", 0

	.text
	.global lab3
	.global uart_init

 	;.global expression
ptr_to_prompt1:	.word prompt1
ptr_to_prompt2:	.word prompt2
ptr_to_num1:	.word num1
ptr_to_num2:	.word num2
ptr_to_expression1:	.word expression1
ptr_to_expression2:	.word expression2
ptr_to_difference: .word difference
ptr_to_expression3: .word expression3

U0LSR:  .equ 0x18			; UART0 Line Status Register

lab3:

	STMFD SP!, {lr}	; Store register lr on stack
	BL uart_init
	LDR r4, ptr_to_prompt1 ;postition of prompt1
	mov r11, r4	;remember initial value of r4
cont_read:	ldrb r0, [r4]
	CMP r0, #0x0
	BEQ done
	ADD r4, r4, #1
	BL output_character
	B cont_read
done:	;add r4, r4, #1
	BL read_string

	;store second integer
	LDR r4, ptr_to_prompt2 ;postition of prompt2
	MOV r11, r4
cont_read2:	ldrb r0, [r4]
	CMP r0, #0x0
	BEQ done2
	ADD r4, r4, #1
	BL output_character
	B cont_read2
done2:	BL read_string
	B done3

;convert first integer
done3:	mov r12, #0
	ldr r4, ptr_to_num1
extract:	ldrb r11, [r4]
	add r4, r4, #1
	CMP r11, #0x0
	BEQ done4
	SUB r11, r11, #48;change
	LSL r12, r12, #4
	add r12, r12, r11
	B extract
;convert second integer
done4:
	mov r8, #0
	ldr r4, ptr_to_num2
extract2:	ldrb r8, [r4]
	add r4, r4, #1
	CMP r8, #0x0
	BEQ done5
	SUB r8, r8, #48;change
	LSL r9, r9, #4
	add r9, r9, r8
	B extract2
done5: add r12, r12, #0

	SUB r7, r12, r9
	CMP r7, #0
	BGT firstLarger
	ldr r4, ptr_to_expression2
	ldrb r0, [r4]
	RSB r7, r7, #0
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	B final
firstLarger:	ldr r4, ptr_to_expression1
	ldrb r0, [r4]
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character




final:
	ldr r4, ptr_to_expression3
	ldrb r0, [r4]
	BL output_string


into:	ldr r4, ptr_to_difference
	str r11, [r4]

finish:	ldrb r0, [r4]
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	LDMFD SP!, {lr}
	mov pc, lr

;
;
read_string:
	STMFD SP!,{lr, r4, r9}
	ldr r12, ptr_to_prompt1
	CMP r11, r12
	BNE strnum2
	ldr r4, ptr_to_num1
	B receive
strnum2:	ldr r4, ptr_to_num2
receive:	BL read_character
;comareD:
	CMP r0, #0xD
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
	;BL output_string
	LDMFD sp!, {lr, r4, r9}
	mov pc, lr


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


;
;
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
;
;
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

uart_init:
	STMFD SP!, {r2-r12}
	;(*((volatile uint32_t *)(0x400FE618))) |= 1;
	MOV r5, #0xE000
	MOV r5, #0x400F
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
	LDR r6, [r5, #0x030]
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
	LDMFD SP!, {r2-r12}
	mov pc, lr

	.end

