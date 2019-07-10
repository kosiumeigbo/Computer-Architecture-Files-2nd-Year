		ADR		R0, DATA
		LDR		R3, [R0]
		ADD		R0, R0, #4
		LDR		R4, [R0]
		ADD		R4, R4, R3
		ADD		R0, R0, #4
		STR		R4, [R0]
		
DATA		DCD		123, 234, 0
