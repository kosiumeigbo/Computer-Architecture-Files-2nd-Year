UNPACKTWORD
			STMFD	R13!, {R0-R7}
			
			MOV		R2, R0
			MOV		R3, R1
			
LS_3_digits	MOV		R1, R2, LSL #22
			MOV		R1, R1, LSR #22 ; extracted LS TCD
			BL		UNPACKTRIPLET
			MOV		R4, R0 ; LS 3 digits
			
mid_3_digits	MOV		R1, R2, LSL #11
			MOV		R1, R1, LSR #22 ; extracted mid TCD
			BL		UNPACKTRIPLET
			MOV		R5, R0 ; mid 3 digits
			
MS_3_digits	MOV		R1, R2, LSR #22 ; extracted MS TCD
			BL		UNPACKTRIPLET
			MOV		R6, R0 ; MS 3 digits
			
get_9_digits	ADD		R0, R4, R5, LSL #12 ; LS 6 digits, d5-d0
			MOV		R7, R6, LSL #24 ; extracting d7 and d6
			ADD		R0, R0, R7 ; LS 8 digits, d7-d0
			STR		R0, [R3] ; storing d7-d0 in memory
			
			MOV		R0, R6, LSR #8
			MOV		R0, R0, LSL #28 ; extracting d8
			STR		R0, [R3, #4] ; storing d8 in memory
			
			LDMFD	R13!, {R0-R7}
			MOV		PC, LR