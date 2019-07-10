PACKTWORD
			STMFD	R13!, {R1-R8}
			
			MOV		R6, #0
			MOV		R5, R1
			MOV		R1, #0
			MOV		R2, #0b1111
			
LS_TCD	     LDRB		R4, [R5, #0]
			AND		R3, R4, R2 ; extracting x(3:0)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(7:4)
			AND		R3, R4, R2 ; extracting x(7:4)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(11:8)
			LDRB		R4, [R5, #1]
			AND		R3, R4, R2 ; extracting x(11:8)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(15:12)
			BL		PACKTRIPLET
			MOV		R1, #0
			MOV		R6, R0 ; LS TCD
			
mid_TCD   	AND		R3, R4, R2 ; extracting x(15:12)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(19:16)
			LDRB		R4, [R5, #2]
			AND		R3, R4, R2 ; extracting x(19:16)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(23:20)
			AND		R3, R4, R2 ; extracting x(23:20)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(27:24)
			LSR		R1, R1, #12 ; align mid 3 digits to 12 LSB
			BL		PACKTRIPLET
			MOV		R1, #0
			MOV		R7, R0 ; mid TCD
			
MS_TCD    	LDRB		R4, [R5, #3]
			AND		R3, R4, R2 ; extracting x(27:24)
			ADD		R1, R1, R3
			LSL		R2, R2, #4 ; to extract x(31:28)
			AND		R3, R4, R2 ; extracting x(31:28)
			ADD		R1, R1, R3
			LSR		R1, R1, #24 ; to align MS 3 digits to 12 LSB
			LSR		R2, R2, #28 ; to extract y(3:0)
			LDRB		R4, [R5, #4]
			AND		R3, R4, R2 ; extracting y(3:0)
			LSL		R3, R3, #8
			ADD		R1, R1, R3
			BL		PACKTRIPLET
			MOV		R8, R0 ; MS TCD
			
packed_TCD	ADD		R0, R6, R7, LSL #11
			ADD		R0, R0, R8, LSL #22 ; full packed TCD
			
			LDMFD	R13!, {R1-R8}
			MOV		PC, LR