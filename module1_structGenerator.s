	AREA	module1Main, CODE, READONLY
	EXPORT	module1_structGenerator
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	IMPORT	emp_id
	IMPORT	name_ptr
	IMPORT	salary
	IMPORT	grade
	IMPORT	dept_code
	IMPORT	account
	IMPORT	attptr_base
	IMPORT	attptr_size
	IMPORT	allow_base
	IMPORT	allow_size
	IMPORT	payroll
	IMPORT	overtime
		
module1_structGenerator		PROC
	PUSH	{lr}
	LDR		r1, =struct_base
	LDR		r1, [r1]
	LDR		r2, =struct_num
	LDR		r2, [r2]
	LDR		r3, =struct_size
	LDR		r3, [r3]
	MOVS	r4, #0
	
start
	CMP		r2, r4
	BEQ		finish
	
load_base
	MUL		r5, r3, r4				; base offset = size*i
	ADDS	r5, r1					; final base = base + offset
	
load_id
	LDR		r6, =emp_id
	LDR		r7, [r6, r4, LSL #2] 	; emp_id[i]
	STR		r7, [r5] 				; at offset 0
	
load_name
	LDR		r6, =name_ptr
	LDR		r7, [r6, r4, LSL #2] 	; name_ptr[i]
	STR		r7, [r5, #4] 			; at offset 4
	
load_salary
	LDR		r6, =salary
	LDR		r7, [r6, r4, LSL #2] 	; salary[i]
	STR		r7, [r5, #8] 			; at offset 8
	LDR		r8, =payroll
	LDR		r8, [r8, r4, LSL #2] 	; payroll[i]
	STR		r7, [r8] 				; storing base salary
	
load_grade
	LDR		r6, =grade
	LDRB	r7, [r6, r4] 			; grade[i]
	STRB	r7, [r5, #12] 			; at offset 12
	
load_dept_code
	LDR		r6, =dept_code
	LDRB	r7, [r6, r4] 			; code[i]
	STRB	r7, [r5, #13] 			; at offset 13

load_account_no
	LDR		r6, =account
	LDR		r7, [r6, r4, LSL #2] 	; account[i]
	STR		r7, [r5, #14] 			; at offset 14

load_attendance
	LDR		r6, =attptr_base
	LDR		r6, [r6]
	LDR		r7, =attptr_size
	LDR		r7, [r7]
	MUL		r7, r4
	ADDS	r6, r7					; final loaded base of attendance
	STR		r6, [r5, #18]			; at offset 18
	
load_allowance
	LDR		r6, =allow_base
	LDR		r6, [r6]
	LDR		r7, =allow_size
	LDR		r7, [r7]
	MUL		r7, r4
	ADDS	r6, r7					; final loaded base of allowance
	STR		r6, [r5, #22]			; at offset 22

load_payroll
	LDR		r6, =payroll
	LDR		r7, [r6, r4, LSL #2] 	; payroll[i]
	STR		r7, [r5, #26] 			; at offset 26
	
load_overtime
	LDR		r6, =overtime
	LDRB	r7, [r6, r4] 			; overtime[i]
	STRB	r7, [r5, #32] 			; at offset 32

load_flags
	MOVS	r6, #0
	STRB	r6, [r5, #30]			; attendance count initially 0
	STRB	r6, [r5, #31]			; deficit flag initially 0
	STRB	r6, [r5, #33]			; overflow flag initially 0
	ADDS	r4, #1
	B		start
	
finish
	POP		{pc}
	ENDP
	END