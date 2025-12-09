	AREA	module9Main, CODE, READONLY
	EXPORT	module9_departmentalSalary
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	IMPORT	d_summary
		
module9_departmentalSalary		PROC
	PUSH	{lr}
	LDR		r1, =struct_base
	LDR		r1, [r1]
	LDR		r2, =struct_num
	LDR		r2, [r2]
	LDR		r3, =struct_size
	LDR		r3, [r3]
	MOVS	r4, #0
	MOVS	r8, #0				; total_Admin
	MOVS	r9, #0				; total_HR
	MOVS	r10, #0				; total_IT
	
start
	CMP		r2, r4
	BEQ		finish
	
load_base
	MUL		r5, r4, r3
	ADDS	r5, r1

load_code_and_total
	LDR		r6, [r5, #26]		; payroll[i]
	LDR		r6, [r6, #20]		; total_salary[i]
	LDRB	r7, [r5, #13]		; dept_code[i]
	CMP		r7, #2
	ADDLT	r8, r6
	ADDEQ	r9, r6
	ADDGT	r10, r6
	ADDS	r4, #1
	B		start

finish
	LDR		r4, =d_summary
	STR		r8, [r4]
	STR		r9, [r4, #4]
	STR		r10, [r4, #8]
	POP		{pc}
	ENDP
	END