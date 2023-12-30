


#include <xc.inc>
; Set the configuration word
 CONFIG FEXTOSC = OFF, RSTOSC = HFINT32, CLKOUTEN = OFF, CSWEN = ON, FCMEN = ON
 CONFIG MCLRE = ON, PWRTE = OFF, LPBOREN = ON, BOREN = ON, BORV = LO, ZCD = OFF,PPS1WAY = OFF, STVREN = ON
 CONFIG WDTCPS = WDTCPS_31, WDTE = OFF, WDTCWS = WDTCWS_7, WDTCCS = SC
 CONFIG WRT = OFF, SCANE = available, LVP = OFF
 CONFIG CP = OFF, CPD = OFF
 PSECT code
temp1 EQU 70h ; assign memory location for a 8-bit variable temp1
temp2 EQU 71h ; assign memory location for a 8-bit variable temp2
org 00h ; coding begins here
clrf TRISB ; PORTB is set up as output
LOOP:
    movlw 0xff
    movwf LATB ; Turn on all LEDs
    call delay
    movlw 0x00
    movwf LATB ; Turn off all LEDs
    call delay
    goto LOOP ; Go back to LOOP (label) 
delay: movlw 0x0f
       movwf temp1
       clrf temp2
del1: decfsz temp1,f
      goto del1
      decfsz temp2,f
      goto del1
      return
