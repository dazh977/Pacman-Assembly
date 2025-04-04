

	.text
 	.global uart_init
 	.global output_character
 	.global read_character
 	.global read_string
 	.global output_string
 	.global read_from_push_btns
 	.global illuminate_LEDs
 	.global illuminate_RGB_LED
	.global read_keypad

U0LSR:  .equ 0x18			; UART0 Line Status Register

;//////////////////////////////////////////////////////
read_keypad:
	STMFD SP!,{r2, r6, r7, r12}
	;Set up port D
	;clock
	mov r3, #0xE000
	movt r3, #0x400F
    ldr r7, [r3, #0x608]
	;mov r6, #0x003F
	mov r6, #0x003f
	movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r3, #0x608]
    ;port D address

	mov r7, #0
	mov r2, #0x7000
    movt r2, #0x4000
    ;direction register PIN0
    ldr r7, [r2, #0x400]
	mov r6, r9
    MOVT r6, #0x0000
	ORR r7, r7, r6
    str r7, [r2, #0x400]
	;digital register
    mov r6, #0x000f
    MOVT r6, #0x0000
    ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
	;data register
	LDR r7, [r2, #0x3fc]
	mov r6, #0x000f
    MOVT r6, #0x0000
	ORR r7, r7, r6
	str r7, [r2, #0x3fc]

	;Set up port A
	mov r2, #0x4000
    movt r2, #0x4000  ;port A address
	;direction register PIN2-5
	ldr r7, [r2, #0x400]
	mov r6, #0xffc3
    MOVT r6, #0xffff
	and r7, r7, r6	;set to output
    str r7, [r2, #0x400]
    ;digital register
    mov r6, #0x003c
    movt r6, #0x0000
    ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
	;data register
	ldr r7, [r2, #0x3fc]
	mov r6, #0xff3c
    movt r6, #0xffff
	AND r7, r7, r6
	str r7, [r2, #0x3fc]
	ldr r0, [r2, #0x3fc]
    LDMFD sp!, {r2, r6, r7, r12}
    MOV pc, lr
;/////////////////////////////////////////////////////////////


;//////////////////////////////////////////////////////////
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
en:	BL read_character
	CMP r0, #0xD
	BNE en
	CMP r12, #0xA
	BLT zeroto9
	add r12, r12, #0x37	;when number entered is greater than or equal to #10
	B sends
zeroto9:	add r12, r12, #0x30	;when number entered is less than #10
sends:	MOV r0, r12
	BL output_character
    mov r0, r12
	;BL illuminate_LEDs
	LDMFD sp!, {lr}
	MOV pc, lr

;//////////////////////////////////////////////////////////
illuminate_LEDs:	STMFD SP!,{r2,r3, r4, r7, r8}
    mov r2, #0x5000
    movt r2, #0x4000  ;port B address
    ;direction register PIN0
    ldr r7, [r2, #0x400]
	mov r6, #0X000f
    MOVT r6, #0x0000
    ORR r7, r7, r6
    str r7, [r2, #0x400]
    ;digital register
    mov r6, #0X000f
    MOVT r6, #0x0000
	ldr r7, [r2, #0x51C]
	ORR r7, r7, r6
	str r7, [r2, #0x51C]
    ;data register
    LDR r8, [r2, #0x3fc]
	mov r6, #0x000d
	movt r6, #0x0000
    ORR r8, r8, r6
    STR r8, [r2, #0x3fc]
    mov r0, r8
    LDMFD sp!, { r2,r3,r4, r7, r8}
    MOV pc, lr

;//////////////////////////////////////////////////
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
	mov r6, r0
	;mov r6, #0x0004
    movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r2, #0x3FC]
	mov r0, r7
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
	mov r4, r0
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
	.end
