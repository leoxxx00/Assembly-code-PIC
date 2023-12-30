#include <xc.inc>
; Set the configuration word
CONFIG FEXTOSC = OFF, RSTOSC = HFINT32, CLKOUTEN = OFF, CSWEN = ON, FCMEN = ON
CONFIG MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF, PPS1WAY = OFF, STVREN = ON
CONFIG WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC
CONFIG WRT = OFF, SCANE = available, LVP = OFF
CONFIG CP = OFF, CPD = OFF
PSECT code
;Define meomry
temp1   EQU     0x70       ; Assign memory location for an 8-bit variable temp1
temp2   EQU     0x71       ; Assign memory location for an 8-bit variable temp2
;temp3   EQU     0x72       ; Assign memory location for an 8-bit variable temp3
org 0x00 ; Start of program

START:
    ; Setup for the port
    BANKSEL ANSELA ; Selects the register bank containing the ANSELA register
    CLRF ANSELA ; Clears the ANSELA register
    BANKSEL TRISA ;Configuring all pins in Port A as outputs
    CLRF TRISA	;Clear the TRISA register
    BANKSEL TRISB ; Configuring all pins in Port B as outputs
    CLRF TRISB; Clear the TRISB register

LOOP:
    ;display loop
    MOVLW 0x01 ;Load literal value 0x01 into the W register to set the 7-segment position SEG0
    MOVWF LATA ;Move the value in the W register to the LATA register
    movlw 0b11111001 ;pattern to display 1
    MOVWF LATB ;Move the value in the W register to the LATB register 
    call delay1s ;Call 1s delay
    MOVLW 0x02 ;Load literal value 0x02 into the W register to set the 7-segment position SEG1
    MOVWF LATA ;Move the value in the W register to the LATA register
    movlw 0b10100100 ;pattern to display 2
    MOVWF LATB ;Move the value in the W register to the LATB register 
    call delay1s ;Call 1s delay
    MOVLW 0x04 ;Load literal value 0x04 into the W register to set the 7-segment position SEG2
    MOVWF LATA ;Move the value in the W register to the LATA register
    movlw 0b10000010 ;pattern to display 6
    MOVWF LATB ;Move the value in the W register to the LATB register 
    call delay1s ;Call 1s delay
    MOVLW 0x08 ;Load literal value 0x08 into the W register to set the 7-segment position SEG3
    MOVWF LATA ;Move the value in the W register to the LATA register
    movlw 0b10000010 ;pattern to display 6
    MOVWF LATB ;Move the value in the W register to the LATB register 
    call delay1s ;Call 1s delay
    GOTO LOOP
;delay subroutines
delay1s:
    ; Set the number of iterations for a 1-second delay
    movlw 0x01   ; Initialize temp1
    movwf temp1	 ; Move the 0x01 to temp1 memory location
    movlw 0x09   ; Initialize temp2 
    movwf temp2	 ; Move the 0x01 to temp1 memory location
    ;movlw 0x02   ; Initialize temp3 
    ;movwf temp3	 ; Move the 0x20 to temp1 memory location
del1:
    decfsz temp1, f ;Values in specific file(f) register (temp1) will be decfsz(decerment) 
    goto del1	    ;Go back to del1 
    decfsz temp2, f ;Values in specific file(f) register (temp2) will be decfsz(decerment) 
    goto del1	    ;Go back to del1
    ;decfsz temp3, f ;Values in specific file(f) register (temp3) will be decfsz(decerment) 
    ;goto del1	    ;Go back to del1
    RETURN	    ;Return from subroutine

