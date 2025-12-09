	AREA	module4Main, CODE, READONLY
	EXPORT	module4_overtimeCalculation
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
		
module4_overtimeCalculation		PROC
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
	
load_overtime_and_payroll
	LDRB	r6, [r5, #32]	; overtime
	LDR		r7, [r5, #26]	; payroll
	
calculate_and_store
	LDRB	r8, [r5, #12] 	; grade load
	CMP		r8, #2 			
	BLT		grade_A
	BEQ		grade_B
	BGT		grade_C
	
grade_A
	MOVS	r9, #250
	MUL		r9, r6
	STR		r9, [r7, #8]
	ADDS	r4, #1
	B		start
	
grade_B
	MOVS	r9, #200
	MUL		r9, r6
	STR		r9, [r7, #8]
	ADDS	r4, #1
	B		start

grade_C
	MOVS	r9, #150
	MUL		r9, r6
	STR		r9, [r7, #8]
	ADDS	r4, #1
	B		start

finish
	POP		{pc}
	ENDP
	END