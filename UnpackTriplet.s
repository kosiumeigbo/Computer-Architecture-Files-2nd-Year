UNPACKTRIPLET
			STMFD	R13!, {R1-R4}
			
			LSL		R1, R1, #22
			LSR		R1, R1, #22 ; extract 10 LSB's
			MOV		R2, #0 ; initial a
			MOV		R3, #0 ; initial b
			MOV		R4, #0 ; initial c
			
find_a		CMP		R1, #100
			BMI		find_b
			SUB		R1, R1, #100
			ADD		R2, R2, #1
			B		find_a
			
find_b		CMP		R1, #10
			BMI		find_c
			SUB		R1, R1, #10
			ADD		R3, R3, #1
			B		find_b
			
find_c		CMP		R1, #1
			BMI		found_abc
			SUB		R1, R1, #1
			ADD		R4, R4, #1
			B		find_c
			
found_abc		ADD		R0, R4, R3, LSL #4 ; c + 16b
			ADD		R0, R0, R2, LSL #8 ; c + 16b + 256a
			
			LDMFD	R13!, {R1-R4}
			MOV		PC, LR