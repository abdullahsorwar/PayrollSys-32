	AREA	module2Main, CODE, READONLY
	EXPORT	module2_attendanceData
	IMPORT	attptr_base
	IMPORT	attptr_size
	IMPORT	link_att
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	
module2_attendanceData		PROC
	PUSH	{lr}
	LDR		r1, =attptr_base
	LDR		r1, [r1]
	LDR		r2, =attptr_size
	LDR		r2, [r2]
	LDR		r3, =link_att
	LDR		r4, =struct_num
	LDR		r4, [r4]
	MOVS	r5, #0
	
start
	CMP		r4, r5
	BEQ		finish
	
load_base
	MUL		r6, r2, r5
	ADDS	r6, r1
	LDR		r7, [r3, r5, LSL #2]	; link_att[i]
	MOVS	r8, #0
	MOVS	r9, #0

load_value
	CMP		r8, #31
	BEQ		load_total
	LDRB	r10, [r7, r8]
	STRB	r10, [r6, r8]
	CMP		r10, #1
	ADDEQ	r9, #1
	ADDS	r8, #1
	B		load_value
	
load_total
	MOVS	r8, r9	
	LDR		r9, =struct_base
	LDR		r9, [r9]
	LDR		r10, =struct_size
	LDR		r10, [r10]
	MUL		r10, r5
	ADDS	r10, r9
	STRB	r8, [r10, #30] 			; at offset 30
	ADDS	r5, #1
	B		start

finish
	POP		{lr}
	ENDP
	END