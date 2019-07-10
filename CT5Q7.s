		ADR		R0, DATA
		LDR		R3, [R0]
		LDR		R4, [R0, #4]
		ADD		R4, R4, R3
		STR		R4, [R0, #8]
		
DATA		DCD		123, 234, 0
