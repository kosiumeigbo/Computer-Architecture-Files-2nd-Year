          MOV R0, #0 ; to initialise
          MOV R2, #5 ; for testing
          MOV R1, #7 ; for testing
     LOOP CMP R2, #0
          BEQ 
          BNE LOOP1
    LOOP1 ADD R0, R0, R1
          SUB R2, R2, #1
          B LOOP