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
			
PACKTWORD
			STMFD	R13!, {R1-R8}
			
			MOV		R6, #0
			MOV		R5, R1
			MOV		R1, #0
			MOV		R2, #0b1111
			
LS_TCD		LDRB		R4, [R5, #0]
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
			
mid_TCD		AND		R3, R4, R2 ; extracting x(15:12)
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
			
MS_TCD		LDRB		R4, [R5, #3]
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

MULTRIPLE      MOV PC, LR

MULTIPLY       MOV PC, LR

RECIPROCAL     MOV PC, LR

SQUAREROOT     MOV PC, LR