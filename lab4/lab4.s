

	.data
	.global promptMenu
 	.global promptIntro1
	.global promptIntro2
	.global promptEnter
	.global promptNow
	.global promptLED
	.global promptRGB
	.global promptKeypad
	.global promptButton
	.global promptReturn
	.global promptEnd
	.global num1
	



promptMenu: .string "Choose one from main menu: illumnate LED or RGB; Push Buttons or Keypad.", 0
promptIntro1: .string "To illuminate LED: press 1 (DECIMAL) To illuminate RGB: press 2 (DECIMAL)", 0
promptIntro2: .string "To read switches: press 3 (DECIMAL) To read Keypad: press 4 (DECIMAL)", 0
promptEnter:  .string "NOTE: press Enter after typing 1, 2, 3 or 4 (DECIMAL)", 0
promptNow:	  .string "Now press one of 1, 2, 3 or 4 (DECIMAL): ", 0
promptLED: .string "Enter one DECIMAL number between 0-15 inclusive: ", 0
promptRGB: .string "In DECIMAL, press 1 for red, 2 is blue, 3 is green, 4 is purple, 5 is yellow, 6 is Cyan, 7 is white: ", 0
promptKeypad: .string "Press the key on keypad, 0-9 inclusive", 0
promptButton: .string "Press any number of the switches: ", 0
promptReturn: .string "If return to main menu, press 5.", 0
promptEnd:	.string "Program ends.", 0
num1: .string "abc", 0


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
	.global lab4

ptr_to_promptMenu:	.word promptMenu
ptr_to_promptIntro1:	.word promptIntro1
ptr_to_promptIntro2:	.word promptIntro2
ptr_to_promptEnter:	.word promptEnter
ptr_to_promptNow:	.word promptNow
ptr_to_promptLED:	.word promptLED
ptr_to_promptRGB:	.word promptRGB
ptr_to_promptKeypad:	.word promptKeypad
ptr_to_promptButton: 	.word promptButton
ptr_to_promptReturn: 	.word promptReturn
ptr_to_promptEnd:	.word promptEnd
ptr_to_num1:	.word num1

U0LSR:  .equ 0x18			; UART0 Line Status Register

;
;
lab4:
	STMFD SP!,{lr}
	BL uart_init
	;clock
	mov r3, #0xE000
	movt r3, #0x400F
    ldr r7, [r3, #0x608]
	;mov r6, #0x003F
	mov r6, #0x003f
	movt r6, #0x0000
	ORR r7, r7, r6
	str r7, [r3, #0x608]
again:	LDR r4, ptr_to_promptMenu

	ldrb r0, [r4]
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character

	LDR r4, ptr_to_promptIntro1
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	LDR r4, ptr_to_promptIntro2
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	LDR r4, ptr_to_promptEnter
	BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	LDR r4, ptr_to_promptNow
	BL output_string
	;starting get user input
	BL read_character
	BL output_character
	MOV r3, r0
	;BL output_string
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character

	mov r0, r3
	sub r0, r0, #0x30
	CMP r0, #1	;L in ascii
	BEQ LED
	CMP r0, #2	;R
	BEQ RGB
	CMP r0, #3	;S
	BEQ BUTTON
	CMP r0, #4	;K
	BEQ KEYPAD
LED:	ldr r4, ptr_to_promptLED
	ldrb r0, [r4]
	BL output_string
	ldr r4, ptr_to_num1
	mov r0, r4
	BL read_string
loop:	ldrb r5, [r4]
	CMP r5, #0x0
	BEQ compare
	add r6, r6, #1
	add r4, r4, #1
	B loop
compare:	CMP r6, #2
	BLT pass
	sub r4, r4, #2
	mov r12, #10
	sub r5, r5, #0x30
	mul r5, r12, r5
	add r4, r4, #1
	ldrb r6, [r4]
	sub r6, r6, #0x30
	add r5, r5, r6
	B begin
pass:	sub r4, r4, #1
	ldrb r5, [r4]
begin:	cmp r5, #15
	BGT LED
	mov r0, r5
	BL illuminate_LEDs
	BL output_string
	BL illuminate_LEDs
	BL output_string
	B nextstep
RGB:	ldr r4, ptr_to_promptRGB
	ldrb r0, [r4]
	BL output_string
	BL read_character
	BL output_character
	SUB r0, r0, #0x30
	CMP r0, #1
	BEQ processRed
	CMP r0, #2
	BEQ processGreen
	CMP r0, #3
	BEQ processBlue
	CMP r0, #4
	BEQ processPurple ;(red and blue)
	CMP r0, #5
	BEQ processYellow ;(red and green)
	CMP r0, #6
	BEQ processCyan   ;(blue and green)
	CMP r0, #7
	BEQ processWhite  ;(all three color)
	B processWhite	   ;(unexpected value illuminates white color)
processRed:	mov r0, #0x2
	B callit
processGreen:	mov r0, #0x4
	B callit
processBlue:	mov r0, #0x8
	B callit
processPurple:	mov r0, #0x6
	B callit
processYellow:	mov r0, #0xA
	B callit
processCyan:	mov r0, #0xC
	B callit
processWhite:	mov r0, #0xE
	B callit
callit:	BL illuminate_RGB_LED

	BL output_string
	B nextstep
BUTTON:	ldr r4, ptr_to_promptButton
	BL output_string
	;BL read_string
	BL read_from_push_btns
	BL output_string
	B nextstep
KEYPAD:	ldr r4, ptr_to_promptKeypad
	BL output_string
	;BL read_string
	BL read_keypad
	BL output_string
	B nextstep


;for keypad
;/////////////////////////////////////////////////////////////
forkeypad:	mov r9, #0x0001
	mov r10, #2
again1:	BL read_keypad
	CMP r0, #0x0003
	BNE GO
	mul r9, r10
	B again1

GO:
	mov r10, r0
	cmp r9, #0x0001
	BEQ firstline
	cmp r9, #0x0002
	BEQ secondline
	cmp r9, #0x0004
	BEQ thirdline
	cmp r9, #0x0008
	BEQ fourthline
	;B final
firstline:
	cmp r10, #0x0007
	BEQ one
	cmp r10, #0x000B
	BEQ two
	cmp r10, #0x0013
	BEQ three
one:
	mov r0, #0x0031
	BL output_character
	B final
two:
	mov r0, #0x0032
	BL output_character
	B final
three:
	mov r0, #0x0033
	BL output_character
	B final
secondline:
	cmp r10, #0x0007
	BEQ four
	cmp r10, #0x000B
	BEQ five
	cmp r10, #0x0013
	BEQ	six
four:
	mov r0, #0x0034
	BL output_character
	B final
five:
	mov r0, #0x0035
	BL output_character
	B final
six:
	mov r0, #0x0036
	BL output_character
	B final
thirdline:
	cmp r10, #0x0007
	BEQ seven
	cmp r10, #0x000B
	BEQ eight
	cmp r10, #0x0013
	BEQ	nine
seven:
	mov r0, #0x0037
	BL output_character
	B final
eight:
	mov r0, #0x0038
	BL output_character
	B final
nine:
	mov r0, #0x0039
	BL output_character
	B final
fourthline:
	cmp r10, #0x000B
	BEQ zero
zero:
	mov r0, #0x0030
	BL output_character
	B final
;////////////////////////////////////////////////

final:
	add r0, r0, #0
nextstep:
	MOV r0, #0xA
	BL output_character
	MOV r0, #0xD
	BL output_character
	ldr r4, ptr_to_promptEnd
	ldrb r0, [r4]
	BL output_string
	BL read_character
	BL output_character
	CMP r0, #0x35
	BEQ again
	LDMFD sp!, {lr}
	MOV pc, lr

	.end
