COPY		ADR		R1, TABLE1
		ADR		R2, TABLE2
		LDR		R0, [R1]
		STR		R0, [R2]
		LDR		R0, [R1, #4]
		STR		R0, [R2, #4]
		LDR		R0, [R1, #8]
		STR		R0, [R2, #8]
		LDR		R0, [R1, #12]
		STR		R0, [R2, #12]
		LDR		R0, [R1, #16]
		STR		R0, [R2, #16]
		
TABLE1	DCD		31, 402, 53, 888, 201
		
TABLE2	FILL		20
