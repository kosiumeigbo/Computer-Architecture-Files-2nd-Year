		;		Input: R1 contains signed number in range 0 - 9
		;		Output: R2 contains the cube of R1, or -1 if R1 is out of range
		;
CUBE		ADR		R0, CUBETAB
		MOV		R2, #-1 ; error output for when input is out of range
		CMP		R1, #9
		BGT		DONE
		LDR		R2, [R0, R1, LSL #2]
DONE
		
CUBETAB	DCD		0,1,8, 27, 64, 125, 216, 343, 512, 729
