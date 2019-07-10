PACKTRIPLET
			STMFD	R13!, {R2}
			;		the following code is similar to Q1 answer in CT4 but not exact
			
			AND		R0, R1, #0xF ; 4 LSB's
			
			LSR		R2, R1, #4 ; middle 4 bits
			AND		R2, R2, #0xF
			ADD		R0, R0, R2, LSL #3 ; x8
			ADD		R0, R0, R2, LSL #1 ; x2
			
			LSR		R2, R1, #8 ; 4 MSB's
			AND		R2, R2, #0xF
			ADD		R0, R0, R2, LSL #2 ; x4
			ADD		R0, R0, R2, LSL #5 ; x32
			ADD		R0, R0, R2, LSL #6 ; x64
			
			LDMFD	R13!, {R2}
			MOV		PC, LR