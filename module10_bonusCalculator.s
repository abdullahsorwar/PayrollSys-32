	AREA	module10Main, CODE, READONLY
	EXPORT	module10_bonusCalculator
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	IMPORT	perform
		
module10_bonusCalculator	PROC
	PUSH	{lr}
	LDR		r1, =struct_base
	LDR		r1, [r1]
	LDR		r2, =struct_num
	LDR		r2, [r2]
	LDR		r3, =struct_size
	LDR		r3, [r3]
	LDR		r4, =perform
	MOVS	r5, #0
	
start
	CMP		r2, r5
	BEQ		finish
	
load_base
	MUL		r6, r5, r3
	ADDS	r6, r1

load_peformance_score
	LDR		r7, [r4, r5, LSL #2]		; performance[i]
	CMP		r7, #90
	BGE		bonus_25
	CMP		r7, #75
	BGE		bonus_15
	CMP		r7, #60
	BGE		bonus_8
	BLT		bonus_0

bonus_25
	LDR		r8, [r6, #8]				; base salary
	MOV		r9, #25
	MUL		r8, r9
	MOV		r9, #100
	UDIV	r8, r9
	STR		r8, [r6, #34]				; bonus[i]
	ADDS	r5, #1
	B		start
	
bonus_15
	LDR		r8, [r6, #8]				; base salary
	MOV		r9, #15
	MUL		r8, r9
	MOV		r9, #100
	UDIV	r8, r9
	STR		r8, [r6, #34]				; bonus[i]
	ADDS	r5, #1
	B		start
	
bonus_8
	LDR		r8, [r6, #8]				; base salary
	MOV		r9, #8
	MUL		r8, r9
	MOV		r9, #100
	UDIV	r8, r9
	STR		r8, [r6, #34]				; bonus[i]
	ADDS	r5, #1
	B		start
	
bonus_0
	MOVS	r8, #0
	STR		r8, [r6, #34]				; bonus[i]
	ADDS	r5, #1
	B		start

finish
	POP		{pc}
	ENDP
	END