		MOV		R3, R1, LSL #1 ; multiplying by 2
		
		MOV		R4, R1, LSL #30 ; dividing by 4
		MOV		R5, R1, ASR #2
		
		MOV		R6, R1, LSL #29 ; dividing by 8
		MOV		R7, R1, ASR #3
		
		ADDS		R0, R4, R6 ; addition of division by 4 and division by 8
		ADCS		R1, R5, R7
		
		ADDS		R1, R1, R3 ;second part of addition
		MOV		R2, #0 ;register for second carry
		MOVVS	R2, #1
