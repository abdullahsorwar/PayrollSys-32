	AREA	payRollSysMain, CODE, READONLY
	EXPORT	main
	IMPORT	module1_structGenerator
	IMPORT	module2_attendanceData
	IMPORT	module3_leaveManagement
	IMPORT	module4_overtimeCalculation
	IMPORT	module5_allowanceProcessor
	IMPORT	module6_taxComputation
	IMPORT	module7_netSalary
	IMPORT	module8_sortStruct
	IMPORT	module9_departmentalSalary
	IMPORT	module10_bonusCalculator
	IMPORT	module11_paySlip
	ENTRY
	
main
	BL		module1_structGenerator
	BL		module2_attendanceData
	BL		module3_leaveManagement
	BL		module4_overtimeCalculation
	BL		module5_allowanceProcessor
	BL		module6_taxComputation
	BL		module7_netSalary
	BL		module8_sortStruct
	BL		module9_departmentalSalary
	BL		module10_bonusCalculator
	BL		module11_paySlip
	
stop
	B		stop
	END