	AREA	module11Main, CODE, READONLY
	EXPORT	module11_paySlip
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	IMPORT	slip_ptr
	IMPORT	str_dum
	IMPORT	int_dum
	IMPORT	nl
	IMPORT 	dept_name
	IMPORT	ITM_SendChar_C
		
module11_paySlip	PROC
	PUSH	{lr}
	LDR		r2, =struct_num
	LDR		r2, [r2]
	LDR		r3, =struct_size
	LDR		r3, [r3]
	LDR		r4, =slip_ptr
	MOVS	r5, #0
	
start
	CMP		r2, r5
	BEQ		finish
	LDR		r1, =struct_base
	LDR		r1, [r1]
	MOV		r6, #0			; line detector, total 45
	
load_base
	MUL		r7, r5, r3
	ADD		r7, r1
	
print_basic
	MOV		r12, #6
	BL		print_dummy
	
	; ID as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #25
	BL		push_integer
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Name as string
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, [r7, #4]
	MOV		r9, #25
	MOV		r11, #0
	BL		push_string
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Grade manually
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDRB	r10, [r7, #12]
	ADD		r10, #64
	STRB	r10, [r8, #25]
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Dept. Name manually
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDRB	r10, [r7, #13]
	SUB		r10, #1
	LDR		r11, =dept_name
	LDR		r10, [r11, r10, LSL #2]
	MOV		r9, #25
	MOV		r11, #0
	BL		push_string
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Add lines before acc. no
	MOV		r12, #12
	BL		print_dummy
	B		account_info
	
finish
	POP		{pc}
	ENDP

account_info
	; Acc. No as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #14]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #25
	BL		push_integer
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Add lines before attendance
	MOV		r12, #19
	BL		print_dummy
	
	; Attendance Manually
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDRB	r11, [r7, #30]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #59
	MOV		r12, #0
	BL		attendance
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Add lines before payment
	MOV		r12, #25
	BL		print_dummy
	
	LTORG
	
	; Salary
	BL		salary
	ADD		r5, #1
	B		start

strcpy
	CMP		r9, #62
	BXEQ	lr
	LDRB	r10, [r0, r9]
	STRB	r10, [r8, r9]
	ADD		r9, #1
	B		strcpy
	
intcpy
	CMP		r11, #0
	BXEQ	lr
	MOV		r12, #10
	UDIV	r0, r11, r12
	MUL		r0, r12
	SUB		r0, r11, r0
	UDIV	r11, r12
	ADD		r0, #48
	STRB	r0, [r10, r9]
	ADD		r9, #1
	B		intcpy
	
push_integer
	CMP		r9, #0
	BXEQ	lr
	SUB		r9, #1
	LDRB	r0, [r10, r9]
	STRB	r0, [r8, r11]
	ADD		r11, #1
	B		push_integer

push_integer_rev
	CMP		r9, r12
	BXEQ	lr
	LDRB	r0, [r10, r12]
	STRB	r0, [r8, r11]
	SUB		r11, #1
	ADD		r12, #1
	B		push_integer_rev

push_string
	LDRB	r0, [r10, r11]
	CMP		r0, #0
	BXEQ	lr
	STRB	r0, [r8, r9]
	ADD		r11, #1
	ADD		r9, #1
	B		push_string

attendance
	CMP		r9, r12
	BXEQ	lr
	LDRB	r0, [r10, r12]
	STRB	r0, [r8, r11]
	SUB		r11, #1
	ADD		r12, #1
	B		attendance

salary
	PUSH	{lr}
	
	; Base Salary as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #8]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Allowance Line
	MOV		r12, #27
	BL		print_dummy
	
	; Allowances as integers
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #22]
	LDR		r11, [r11]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #22]
	LDR		r11, [r11, #4]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #22]
	LDR		r11, [r11, #8]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Overtime as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #26]
	LDR		r11, [r11, #8]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Tax as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #26]
	LDR		r11, [r11, #12]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Leave Deduction as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #26]
	LDR		r11, [r11, #16]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Dummy line
	MOV		r12, #34
	BL		print_dummy
	
	; Net Salary as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #26]
	LDR		r11, [r11, #20]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Bonus as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #34]
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Dummy line
	MOV		r12, #37
	BL		print_dummy
	
	; Final Payable Amount as integer
	LDR		r8, =str_dum
	LDR		r0, [r4, r6, LSL #2]
	MOV		r9, #0
	BL		strcpy
	LDR		r10, =int_dum
	LDR		r11, [r7, #26]
	LDR		r11, [r11, #20]
	LDR		r12, [r7, #34]
	ADD		r11, r12
	MOV		r9, #0
	BL		intcpy
	MOV		r11, #56
	MOV		r12, #0
	BL		push_integer_rev
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	
	; Dummy line
	MOV		r12, #45
	BL		print_dummy
	
	POP		{pc}

print_string	PROC
	PUSH	{lr}
	MOV		r9, #0
	
byte_transmit
	LDRB	r0, [r8, r9]
	CMP		r0, #0			; null character
	POPEQ	{pc}
	BL		ITM_SendChar_C
	ADD		r9, #1
	B		byte_transmit
	ENDP
		
print_dummy		PROC
	PUSH	{lr}
	
dummy_loop	
	CMP		r6, r12
	POPEQ	{pc}
	LDR		r8, [r4, r6, LSL #2]
	BL		print_string
	LDR		r8, =nl
	BL		print_string
	ADD		r6, #1
	B		dummy_loop
	ENDP
	END