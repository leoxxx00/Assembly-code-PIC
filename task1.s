#include <xc.inc>  
; Set the configuration 
  CONFIG  FEXTOSC = OFF, RSTOSC = HFINT32, CLKOUTEN = OFF, CSWEN = ON, FCMEN = ON 
  CONFIG  MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF,PPS1WAY = OFF, STVREN = ON 
  CONFIG  WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC 
  CONFIG  WRT = OFF, SCANE = available, LVP = OFF 
  CONFIG  CP = OFF, CPD = OFF 
PSECT code 
 org        00h             ; coding begins here  
 ;Port setup
 BANKSEL    ANSELA          ; Select bank A to configure individual pins of PORTA as analog or digital
 CLRF       ANSELA          ; Digital I/O for PORTA 
 BANKSEL    PORTA           ; Make bank 0 as the current bank  
 CLRF       PORTA           ; Init PORTA 
 MOVLW      0xff            ; Load literal value 0xff into the W register         
 MOVWF      TRISA           ; Set PORTA as input  
 CLRF       LATA            ; Clear the LATA register, initializing the output latch for PORTA        
 clrf       TRISB	    ; PORTB is set up as output
 ;subroutine to input port A and output port B
 LOOP:  
 movf          PORTA,w	    ; Move the contents of the PORTA register to the W register
 movwf         LATB	    ; move the contents of the W register to the LATB register
 goto          LOOP         ; Go back to LOOP (label)   
 END                        ; directive 'end of program'