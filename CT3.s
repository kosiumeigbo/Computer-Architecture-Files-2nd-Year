		MOV		R3, R1
		MOV		R2, R1
		SUB		R6, R3, #1
LOOP1	MOV		R4, #0
		MOV		R5, R6
		CMP		R5, #0
		BEQ		LOOPEND
LOOP2	ADD		R4, R4, R3
		SUB		R5, R5, #1
		CMP		R5, #0
		BNE		LOOP2
		MOV		R3, R4
		SUB		R6, R6, #1
		B		LOOP1
LOOPEND	MOV		R0, R3
		AND		R7, R1, #1
		CMP		R7, #1
		BEQ		ODD
ODD		RSB		R0, R0, #0