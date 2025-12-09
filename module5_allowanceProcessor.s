	AREA	module5Main, CODE, READONLY
	EXPORT	module5_allowanceProcessor
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size

module5_allowanceProcessor		PROC
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
	MUL		r5, r4, r3
	ADDS	r5, r1
	
load_allowance_and_salary
	LDR		r6, [r5, #22]	; allowance[i]
	LDR		r7, [r5, #8]	; base salary
	MOVS	r8, #0			; total storing
	
HRA_and_medical_calc	
	MOVS	r9, #20
	MUL		r7, r9			; for HRA, 20% of base
	MOVS	r9, #100
	UDIV	r7, r9			; HRA stored
	STR		r7, [r6]
	ADDS	r8, r7
	MOV		r7, #3000
	STR		r7, [r6, #4]	; Medical stored
	ADDS	r8, r7

transport_calc
	LDRB	r7, [r5, #13]	; dept_code[i]
	CMP		r7, #2			; lt: Admin, eq: HR, grt: IT
	BLLT	admin_store
	BLEQ	hr_store
	BLGT	it_store
	STR		r7, [r6, #8]	; transport stored
	ADDS	r8, r7
	STR		r8, [r6, #12]	; total stored in allowance[i]
	LDR		r7, [r5, #26]	; payroll[i]
	STR		r8, [r7, #4]	; total stored in payroll[i]
	ADDS	r4, #1
	B		start
	
admin_store
	MOV		r7, #3500
	BX		lr
	
hr_store
	MOV		r7, #4000
	BX		lr
	
it_store
	MOV		r7, #5000
	BX		lr
	
finish
	POP		{pc}
	ENDP
	END