	AREA	module8Main, CODE, READONLY
	EXPORT	module8_sortStruct
	IMPORT	struct_base
	IMPORT	struct_num
	IMPORT	struct_size
	IMPORT	sort_base
		
module8_sortStruct	PROC
	PUSH	{lr}
	LDR		r1, =struct_base
	LDR		r1, [r1]
	LDR		r2, =struct_num
	LDR		r2, [r2]
	LDR		r3, =struct_size
	LDR		r3, [r3]
	LDR		r4, =sort_base
	LDR		r4, [r4]
	MOVS	r5, #0
	
start
	CMP		r2, r5
	BEQ		init_sort
	
load_base
	MUL		r6, r5, r3
	ADDS	r6, r1			; struct base
	MUL		r7, r5, r3
	ADDS	r7, r4			; sort base
	MOVS	r8, #0

store_sort
	CMP		r8, r3
	ADDEQ	r5, #1
	BEQ		start
	LDRB	r9, [r6, r8]	; load each byte
	STRB	r9, [r7, r8]	; store each byte
	ADDS	r8, #1
	B		store_sort
	
init_sort
	MOVS	r5, #0
	
first_loop
	CMP		r5, r2			; initial loop continue until i < n
	BEQ		finish
	MOVS	r6, #0			; j = 0
	SUBS	r7, r2, r5		; n - i
	SUBS	r7, #1			; n - (i + 1)

second_loop
	CMP		r6, r7			; j < n - (i+1)
	ADDEQ	r5, #1			; i++
	BEQ		first_loop		; break
	MUL		r8, r6, r3
	ADDS	r8, r1			; base load for j
	LDR		r9, [r8, #26]	; payroll[j]
	LDR		r9, [r9, #20]	; net_salary[j]
	ADDS	r8, r3			; base load for j+1
	LDR		r10, [r8, #26]	; payroll[j+1]
	LDR		r10, [r10, #20]	; net_salary[j+1]
	CMP		r9, r10
	BLLT	init_swap
	ADDS	r6, #1
	B		second_loop

init_swap
	MOVS	r11, #0
	MUL		r8, r6, r3
	ADDS	r8, r4			; base of sort[j]
	ADDS	r12, r3			; base of sort[j+1]

swap
	CMP		r11, r3
	BXEQ	lr
	LDRB	r9, [r8, r11]	; sort[j][byte[k]]
	LDRB	r10, [r12, r11]	; sort[j+1][byte[k]]
	STRB	r9, [r12, r11]	; swap
	STRB	r10, [r8, r11]	; swap
	ADDS	r11, #1
	B		swap

finish	
	POP		{pc}
	ENDP
	END
