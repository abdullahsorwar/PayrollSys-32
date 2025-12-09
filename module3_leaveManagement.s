	AREA	module3Main, CODE, READONLY
	EXPORT	module3_leaveManagement
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
		
module3_leaveManagement		PROC
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
	
deficit_count
	LDRB	r6, [r5, #30]
	CMP		r6, #22
	BLLT	store_deficit
	CMP		r6, #17
	MOVLT	r6, #1
	STRBLT	r6, [r5, #31] 		; deficit flag set
	ADDS	r4, #1
	B		start
	
store_deficit
	MOVS	r7, r6
	MOVS	r8, #22
	SUBS	r7, r8, r7
	MOVS	r8, #300
	MUL		r7, r8
	LDR		r8, [r5, #26] 		; payroll[i]
	STR		r7, [r8, #16]		; deficit_count[i]
	BX		lr
	
finish
	POP		{pc}
	ENDP
	END