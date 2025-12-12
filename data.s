	AREA	payRollSysData, DATA, READWRITE
	EXPORT	struct_base
	EXPORT	struct_num
	EXPORT	struct_size
	EXPORT	emp_id
	EXPORT	name_ptr
	EXPORT	salary
	EXPORT	grade
	EXPORT	dept_code
	EXPORT	account
	EXPORT	attptr_base
	EXPORT	attptr_size
	EXPORT	link_att
	EXPORT	allow_base
	EXPORT	allow_size
	EXPORT	payroll
	EXPORT	overtime
	EXPORT	sort_base
	EXPORT	d_summary
	EXPORT	perform
	EXPORT	slip_ptr
	EXPORT	str_dum
	EXPORT	int_dum
	EXPORT	nl
	EXPORT	dept_name
	EXPORT	ITM

data_init

; Base addresses for manipulation
struct_base	DCD		0x20000000
struct_num	DCD		7
struct_size	DCD		38
	
; Alignment
; Employee ID     	: 4 bytes
; Name_Ptr	      	: 4 bytes
; Base Salary     	: 4 bytes
; Job Grade       	: 1 byte
; Department Code 	: 1 byte
; Bank Account No 	: 4 bytes
; Attendance_Ptr  	: 4 bytes
; Allow_Table_Ptr 	: 4 bytes
; Payroll_Ptr		: 4 bytes
; Attendance Count	: 1 byte
; Deficit Flag		: 1 byte
; Overtime_Hours	: 1 byte
; Overflow_Flag		: 1 byte
; Bonus				: 4 bytes
; Total			  	: 38 bytes

; Employee IDs
	ALIGN
emp_id		DCD		1001,1002,1003,1004,1005,1006,1007

; Names
name1		DCB		"Ahmed Ibne Reza",0
name2		DCB		"Rokon-Uz-Zaman Chowdhury",0
name3		DCB		"Amrina Afroz",0
name4		DCB		"Md. Sazidul Islam",0
name5		DCB		"Mahima Akter Rima",0
name6		DCB		"Md. Abdur Rahman Chowdhury",0
name7		DCB		"Jarir Mashrook Dausi",0

; Name Pointer
	ALIGN
name_ptr	DCD		name1, name2, name3, name4, name5, name6, name7

; Salaries
	ALIGN
salary		DCD		50000, 120000, 60000, 90000, 140000, 120000, 80000

; Job Grades
grade		DCB		2, 1, 2, 3, 1, 1, 3 ; 1: A, 2: B, 3: C

; Dept. Codes
dept_code	DCB		3, 2, 3, 1, 2, 2, 3 ; 1: Admin, 2: HR, 3: IT

; Account No.s
	ALIGN
account		DCD		2000590100, 2000145200, 2000347500, 2000154400, 2000745500, 200078401, 200047514

; Attendance Pointer
attptr_base	DCD		0x20001000
attptr_size	DCD		31

; Attendance for each attendee (required)
att1		DCB		1,0,1,1,1,0,1,1,1,0,1,1,0,1,1,1,1,1,0,0,1,1,1,1,1,1,0,1,1,0,1
att2		DCB		1,1,0,0,1,0,1,1,0,1,1,1,0,1,0,1,1,0,1,0,1,1,1,1,0,1,0,1,0,1,1
att3		DCB		1,0,0,0,1,0,1,1,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,1,1,0
att4		DCB		1,1,1,1,0,0,1,1,0,1,1,1,0,1,1,0,1,1,1,0,1,1,0,0,1,1,0,1,1,1,1
att5		DCB		0,0,1,1,1,0,1,1,1,0,1,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,1,0,0
att6		DCB		1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,0,1,1,0,1,1,1,1,1,1,0,1,1,1,1
att7		DCB		1,1,1,1,0,0,1,1,1,1,1,1,0,1,1,1,1,0,0,0,1,1,1,1,1,1,0,1,1,0,1

; Linker of Attendance
	ALIGN
link_att	DCD		att1, att2, att3, att4, att5, att6, att7

; Allowance Table Pointer
allow_base	DCD		0x20003000
allow_size	DCD		16

; Payroll Pointers
pr1			DCD		0, 0, 0, 0, 0, 0
pr2			DCD		0, 0, 0, 0, 0, 0
pr3			DCD		0, 0, 0, 0, 0, 0
pr4			DCD		0, 0, 0, 0, 0, 0
pr5			DCD		0, 0, 0, 0, 0, 0
pr6			DCD		0, 0, 0, 0, 0, 0
pr7			DCD		0, 0, 0, 0, 0, 0

	ALIGN
payroll		DCD		pr1, pr2, pr3, pr4, pr5, pr6, pr7
	
; Overtime
overtime	DCB		17, 22, 8, 20, 12, 3, 8

; Sort Base
sort_base	DCD		0x20005000
	
; Dept. Summary
d_summary	DCD		0, 0, 0				; total_Admin, total_HR, total_IT

; Performance
perform		DCD		80, 87, 73, 94, 90, 92, 84

; payslip_structure
line_1			DCB		"   __________________________________________________________ ",0
line_2			DCB		"  |                                                          |",0
header			DCB		"  |                PayrollSys-32 Payment Slip                |",0
line_3			DCB		"  |                                                          |",0
line_4			DCB		"  |==========================================================|",0
line_5			DCB		"  |                                                          |",0
line_id			DCB		"  | Employee ID        :                                     |",0
line_name		DCB		"  | Employee Name      :                                     |",0
line_grade		DCB		"  | Grade              :                                     |",0
line_dept		DCB		"  | Department         :                                     |",0
line_6			DCB		"  |                                                          |",0
line_7			DCB		"  |==========================================================|",0
line_acc		DCB		"  | Account No.        :                                     |",0
line_8			DCB		"  |==========================================================|",0
line_9			DCB		"  |                                                          |",0
line_att		DCB		"  |                  Attendance Information                  |",0
line_10			DCB		"  |                                                          |",0
line_11			DCB		"  |----------------------------------------------------------|",0
line_work		DCB		"  | Total Workdays                           :            31 |",0
line_present	DCB		"  | Present Days                             :             0 |",0
line_12			DCB		"  |==========================================================|",0
line_13			DCB		"  |                                                          |",0
line_salary		DCB		"  |                    Salary Information                    |",0
line_14			DCB		"  |                                                          |",0
line_15			DCB		"  |----------------------------------------------------------|",0
line_base		DCB		"  | Base Salary                             :           0.0$ |",0
line_allow		DCB		"  | Allowances                                               |",0
line_hra		DCB		"  |                                     HRA :           0.0$ |",0
line_med		DCB		"  |                                 Medical :           0.0$ |",0
line_trans		DCB		"  |                               Transport :           0.0$ |",0
line_over		DCB		"  | Overtime                                :           0.0$ |",0
line_tax		DCB		"  | Tax                                     : -         0.0$ |",0
line_leave		DCB		"  | Leave Deduction                         : -         0.0$ |",0
line_16			DCB		"  |==========================================================|",0
line_net		DCB		"  |                              Net Salary :           0.0$ |",0
line_bonus		DCB		"  |                                   Bonus :           0.0$ |",0
line_17			DCB		"  |==========================================================|",0
line_final		DCB		"  |                    Final Payable Amount :           0.0$ |",0
line_18			DCB		"  |                                                          |",0
line_19			DCB		"  |Generated by:                                             |",0
line_20			DCB		"  |PayrollSys-32 ARM Management                              |",0
line_21			DCB		"  |© A.S. Studios, All rights reserved                       |",0
line_22			DCB		"  |__________________________________________________________|",0
blank_1			DCB		"                                                              ",0
blank_2			DCB		"                                                              ",0
; final pointer
	ALIGN
slip_ptr	DCD		line_1, line_2, header, line_3, line_4, line_5, line_id, line_name, line_grade, line_dept, line_6, line_7, line_acc, line_8, line_9, line_att, line_10, line_11, line_work, line_present, line_12, line_13, line_salary, line_14, line_15, line_base, line_allow, line_hra, line_med, line_trans, line_over, line_tax, line_leave, line_16, line_net, line_bonus, line_17, line_final, line_18, line_19, line_20, line_21, line_22, blank_1, blank_2

; dummy lines
str_dum			DCB		"                                                              ",0
int_dum			DCB		"                                                              ",0
nl				DCB		0xA,0
admin			DCB		"Admin",0
hr				DCB		"HR",0
i_t				DCB		"IT",0
	ALIGN
dept_name		DCD		admin, hr, i_t

;ITM Stimulus Port
ITM				DCD		0xE0000000

data_end
	END
		
