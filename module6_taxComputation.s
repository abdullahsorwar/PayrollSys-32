	AREA	module6Main, CODE, READONLY
	EXPORT	module6_taxComputation
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size

module6_taxComputation		PROC
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
	MOVS	r6, #0
	
load_payroll
	LDR		r7, [r5, #26]	; payroll[i]
	LDR		r8, [r7]		; base salary
	ADDS	r6, r8
	LDR		r8, [r7, #4]	; allowance
	ADDS	r6, r8
	LDR		r8, [r7, #8]	; overtime
	ADDS	r6, r8			; gross salary

slab_calc
	LDR		r10, =120000
	CMP		r6, r10
	BGT		slab1
	LDR		r10, =60000
	CMP		r6, r10
	BGT		slab2
	LDR		r10, =30000
	CMP		r6, r10
	BGT		slab3
	BLE		slab4

slab1
	MOVS	r8, #15
	MUL		r9, r6, r8
	MOVS	r8, #100
	UDIV	r9, r8
	STR		r9, [r7, #12]	; tax stored in payroll[i]
	ADDS	r4, #1
	B		start
	
slab2
	MOVS	r8, #10
	MUL		r9, r6, r8
	MOVS	r8, #100
	UDIV	r9, r8
	STR		r9, [r7, #12]	; tax stored in payroll[i]
	ADDS	r4, #1
	B		start
	
slab3
	MOVS	r8, #5
	MUL		r9, r6, r8
	MOVS	r8, #100
	UDIV	r9, r8
	STR		r9, [r7, #12]	; tax stored in payroll[i]
	ADDS	r4, #1
	B		start
	
slab4
	MOVS	r9, #0
	STR		r9, [r7, #12]	; tax stored in payroll[i]
	ADDS	r4, #1
	B		start

finish
	POP		{pc}
	ENDP
	END