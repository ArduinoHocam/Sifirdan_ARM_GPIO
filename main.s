
;SIFIRDAN_ARM_ÖGRENIYORUM 
;#############
;ARDUINO HOCAM
;############# 
;LECTURE:GPIO

;Port F base address is : 0x40025000
SYSCTL_RCGCGPIO    		EQU 0x400FE608;RCGCGPIO (clock for gpio)
GPIO_PORTF_DIR			EQU	0x40025400
PORT_F_Pin_OUTPUTS		EQU	0x0E ; 0000_1110 PF1,PF2,PF3 are outputs	
GPIO_PORTF_AFSEL		EQU 0x40025420 ;PORTF AFSEL 
GPIO_PORTF_DEN			EQU 0x4002551C ;portf den
GPIO_PORTF_DATA			EQU	0x40025038; DATA REGISTER	


					AREA main , CODE, READONLY
					THUMB
					EXTERN DELAY
					EXTERN SUBROUTINE
					EXPORT __main
__main					
					
					LDR R1,=SYSCTL_RCGCGPIO
					LDR R0,[R1]
					ORR R0,R0,#0x20 ;enable port F ,disable rest of the ports
					STR R0,[R1]
					NOP
					NOP
					NOP ; let the GPIO clock stabilize

					LDR R1,=GPIO_PORTF_DIR
					LDR R0,[R1]
					BIC R0,#0xFF ;clear pins 0-7
					ORR R0,#PORT_F_Pin_OUTPUTS;set PF1 PF2 PF3 as output
					STR R0,[R1]
					
					LDR R1,=GPIO_PORTF_AFSEL
					LDR R0,[R1]
					BIC R0,#0xFF ;clear all pins as no alternate function
					STR R0,[R1]

					LDR R1,=GPIO_PORTF_DEN
					LDR R0,[R1]
					ORR R0,#0xFF ;SET AS ALL DIGITAN ENABLED
				    STR R0,[R1] 

					LDR R2,=0X00 ;INITIALLY MAKE IT off
					LDR R1,=GPIO_PORTF_DATA; get data 
					STR R2,[R1]
loop					
					LDR R1,=GPIO_PORTF_DATA ;get data
					MOV	R3,#0xFF
					STR	R3,[R1] 
					BL DELAY
					LDR R2,=0X00 ;INITIALLY MAKE IT off
					LDR R1,=GPIO_PORTF_DATA; get data 
					STR R2,[R1]
					BL DELAY
					B loop
					END


			
	
				
			
			
			
			
			
			
			
			