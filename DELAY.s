NUM 	EQU 	0X00152355 ;for100ms
			AREA    	mydelay, READONLY, CODE
			THUMB
			EXPORT  	DELAY	; Make available
			EXTERN 		__main
				
DELAY PROC
					PUSH {R0-R5}
					MOV32 R0,#NUM   ; we know that mcu 16mhz
					;(1/16mhz)*3 times "x" =100ms
					;x = 0x82355 for 100ms
loop				SUBS R0,R0,#0X01 ;takes 1 clk cyle according to datasheet
					BNE loop ;takes 2 clk cyle according to datasheet
					;in total 3 clk cycles needed.
					POP	{R0-R5}
					BX LR
		
			ALIGN
			ENDP
	
	
	
	
	