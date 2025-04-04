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
	.global num1
	.global numq
	.global newAddress


	.global lab6
	.global UART0_Handler
	.global Timer0_Handler
	.global uart_init
	.global timer_init
 	.global Interrupt_init
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
;///////////////////////////////////////////////
ptr_to_num1:	.word num1
ptr_to_numq:	.word numq

lab6:
	STMFD SP!,{lr}
	BL uart_init
	BL timer_init
	BL Interrupt_init

loop:	add r0, r0, #0
	ldr r4, ptr_to_numq
	ldrb r5, [r4]
	cmp r5, #0x71
	BEQ quitLab6
	B loop

quitLab6:
	mov r0, #0xA
	BL output_character
	mov r0, #0xD
	BL output_character
	ldr r4, ptr_to_promptEndGame
	ldrb r0, [r4]
	BL output_string
	LDMFD SP!,{lr}
	mov pc, lr

	.end
