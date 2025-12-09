	AREA	module7Main, CODE, READONLY
	EXPORT	module7_netSalary
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
		
module7_netSalary		PROC
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

load_payroll
	LDR		r6, [r5, #26]	; payroll[i]
	LDR		r7, [r6]		; base salary
	LDR		r8, [r6, #4]	; allowance
	ADDS	r7, r8
	BLVS	overflow
	LDR		r8, [r6, #8]	; overtime
	ADDS	r7, r8
	BLVS	overflow
	LDR		r8, [r6, #12]	; tax
	SUBS	r7, r8
	BLVS	overflow
	LDR		r8, [r6, #16]	; deficit
	SUBS	r7, r8
	BLVS	overflow
	STR		r7, [r6, #20]	; net salary
	ADDS	r4, #1
	B		start

overflow
	MOVS	r9, #1
	STRB	r9, [r5, #33] 	; overflow_flag
	BX		lr

finish
	POP		{pc}
	ENDP
	END