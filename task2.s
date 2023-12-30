#include <xc.inc>  
; Set up the configurations
  CONFIG  FEXTOSC = OFF, RSTOSC = HFINT32, CLKOUTEN = OFF, CSWEN = ON, FCMEN = ON 
  CONFIG  MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF,PPS1WAY = OFF, STVREN = ON 
  CONFIG  WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC 
  CONFIG  WRT = OFF, SCANE = available, LVP = OFF 
  CONFIG  CP = OFF, CPD = OFF 
PSECT code
;Define memory
temp1   EQU     70h       ; Assign memory location for a 8-bit variable temp1 
temp2   EQU     71h       ; Assign memory location for a 8-bit variable temp2 
temp3   EQU     72h	  ; Assign memory location for a 8-bit variable temp3 
org     00h		  ; Coding begins here 
clrf    TRISB		  ;Port B is setup as output
LOOP:  
    movlw    0xff	  ; 0xff to turn on all LEDS
    movwf    LATB         ; Turn on all LEDs    
    call     delay	  ; call delay 1s
    movlw    0x00	  ; 0x00 to turn off all LEDS
    movwf    LATB         ; Turn off all LEDs     
    call     delay	  ; call delay 1s      
    goto     LOOP	  ; Go back to LOOP (label)  
delay:
    ; Set the number of iterations for a 1-second delay
    movlw 0x01   ; Initialize temp1
    movwf temp1	 ; Move the 0x01 to temp1 memory location
    movlw 0x01  ; Initialize temp2 
    movwf temp2	 ; Move the 0x01 to temp1 memory location
    movlw 0x0C   ; Initialize temp3 
    movwf temp3	 ; Move the 0x20 to temp1 memory location
del1:
    decfsz temp1, f ;Values in specific file(f) register (temp1) will be decfsz(decerment) 
    goto del1	    ;Go back to del1 
    decfsz temp2, f ;Values in specific file(f) register (temp2) will be decfsz(decerment) 
    goto del1	    ;Go back to del1
    decfsz temp3, f ;Values in specific file(f) register (temp3) will be decfsz(decerment) 
    goto del1	    ;Go back to del1
    RETURN	    ;Return from subroutine








